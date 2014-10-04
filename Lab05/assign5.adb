with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
procedure Assign5 is
-- Written by Syth Ryan
--
-- This program computes the winner of rock, paper, scissors
--
-- Input
-- Obtain Players choices
--
-- Output
-- All input data
-- The winner of rock, paper, scissors
-- Number of games won by player 1
-- Number of games won by player 2
-- Number of tie games
-- Percentage of rock wins
-- Percentage of paper wins
-- Percentage of scissors wins
--
-- Assumptions
-- All data entered is valid

   -- Types
      -- For Choice condition
   type Choice_Type is (rock, paper, scissors);

   -- Instantiate new package for enumerated I/O
   package Choice_IO is new Ada.Text_IO.Enumeration_IO (Enum => Choice_Type);


   -- Variables

   Choice_1     : Choice_Type;         -- Player 1's choice
   Choice_2     : Choice_Type;         -- Player 2's choice

   Wins          : Integer;             -- Number of wins to play to
   Player1_Wins  : Integer;             -- Player 1's win count
   Player2_Wins  : Integer;             -- Player 2's win count
   Tie_Games     : Integer;             -- Tie game count
   Rock_Wins     : Integer;             -- Number of rock wins
   Paper_Wins    : Integer;             -- Number of paper wins
   Scissors_Wins : Integer;             -- Number of Scissors_Wins
   Total_Games   : Integer;             -- Total number of games

begin

   Player1_Wins  := 0;
   Player2_Wins  := 0;
   Tie_Games     := 0;
   Rock_Wins     := 0;
   Paper_Wins    := 0;
   Scissors_Wins := 0;
   Total_Games   := 0;

   -- Obtain number of wins to stop at
   Ada.Text_IO.Put (Item => "Enter number of wins to stop at: ");
   Ada.Integer_Text_IO.Get (Item => Wins);

   -- Play many games of rock, paper, scissors
   -- Each iteration, play one game

   Win_Loop:
   loop
   exit Win_loop when (Player1_Wins = Wins or Player2_Wins = Wins);

   -- Obtain players choices

   Ada.Text_IO.Put (Item => "Enter the choices made by the two players: ");
   Ada.Text_IO.New_Line;
   Choice_IO.Get (Item => Choice_1);
   Choice_IO.Get (Item => Choice_2);
   Choice_IO.Put (Item => Choice_1);
   Ada.Text_IO.Put (Item => " ");
   Choice_IO.Put (Item => Choice_2);
   Ada.Text_IO.New_Line (Spacing => 2);

   -- Determine winner of one game

      if Choice_1 = Choice_2 then                                 -- Tie Game
         Ada.Text_IO.Put (Item => "Both players entered ");
         Choice_IO.Put (Item => Choice_1);
         Ada.Text_IO.Put (Item => ". The game is a tie.");
         Tie_Games := Tie_Games + 1;

      elsif (Choice_1 = rock and Choice_2 = scissors) or (Choice_1 = paper and Choice_2 = rock) or (Choice_1 = scissors and Choice_2 = paper) then  -- Player 1 Wins
         Ada.Text_IO.Put (Item => "The first player's choice of ");
         Choice_IO.Put (Item => Choice_1);
         Ada.Text_IO.Put (Item => " beats ");
         Choice_IO.Put (Item => Choice_2);
         Ada.Text_IO.Put (Item => ".");
         Player1_Wins := Player1_Wins + 1;
         If Choice_1 = rock then
            Rock_Wins := Rock_Wins + 1;
         elsif Choice_1 = paper then
            Paper_Wins := Paper_Wins + 1;
         elsif Choice_1 = scissors then
            Scissors_Wins := Scissors_Wins +1;
         end if;

      elsif (Choice_2 = rock and Choice_1 = scissors) or (Choice_2 = paper and Choice_1 = rock) or (Choice_2 = scissors and Choice_1 = paper) then  -- Player 2 Wins
         Ada.Text_IO.Put (Item => "The second player's choice of ");
         Choice_IO.Put (Item => Choice_2);
         Ada.Text_IO.Put (Item => " beats ");
         Choice_IO.Put (Item => Choice_1);
         Ada.Text_IO.Put (Item => ".");
         Player2_Wins := Player2_Wins + 1;
         If Choice_2 = rock then
            Rock_Wins := Rock_Wins + 1;
         elsif Choice_2 = paper then
            Paper_Wins := Paper_Wins + 1;
         elsif Choice_2 = scissors then
            Scissors_Wins := Scissors_Wins +1;
         end if;

      end if;
      Ada.Text_IO.New_Line (Spacing => 2);
   end loop Win_Loop;

   -- Display overall results

   Total_Games := Rock_Wins + Paper_Wins + Scissors_Wins;

   Ada.Text_IO.Put (Item => "The number of games won by the first player: ");
   Ada.Integer_Text_IO.Put (Item => Player1_Wins,
                            Width => 1);
   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put (Item => "The number of games won by the second player: ");
   Ada.Integer_Text_IO.Put (Item => Player2_Wins,
                            Width => 1);
   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put (Item => "The number of games that were ties: ");
   Ada.Integer_Text_IO.Put (Item => Tie_Games,
                            Width => 1);
   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put (Item => "The percentage of winning choices that were rock: ");
   Ada.Float_Text_IO.Put (Item => float (Rock_Wins) / float (Total_Games) * 100.0,
                          Fore => 3,
                          Aft  => 1,
                          Exp  => 0);
   Ada.Text_IO.Put (Item => "%");

   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put (Item => "The percentage of winning choices that were paper: ");
   Ada.Float_Text_IO.Put (Item => float (Paper_Wins) / float (Total_Games) * 100.0,
                          Fore => 3,
                          Aft  => 1,
                          Exp  => 0);
   Ada.Text_IO.Put (Item => "%");

   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put (Item => "The percentage of winning choices that were scissors: ");
   Ada.Float_Text_IO.Put (Item => float (Scissors_Wins) / float (Total_Games) * 100.0,
                          Fore => 3,
                          Aft  => 1,
                          Exp  => 0);
   Ada.Text_IO.Put (Item => "%");
end Assign5;
     