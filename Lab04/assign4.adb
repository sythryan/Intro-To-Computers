with Ada.Text_IO;
procedure Assign4 is
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
--
-- Assumptions
-- All data entered is valid

   -- Types
      -- For Choice condition
   type Choice_Type is (rock, paper, scissors);

   -- Instantiate new package for enumerated I/O
   package Choice_IO is new Ada.Text_IO.Enumeration_IO (Enum => Choice_Type);

   -- Variables

   Choice_1 : Choice_Type;         -- Player 1's choice
   Choice_2 : Choice_Type;         -- Player 2's choice


begin

   -- Obtain players choices

   Ada.Text_IO.Put (Item => "Enter the choices made by the two players: ");
   Ada.Text_IO.New_Line;
   Choice_IO.Get (Item => Choice_1);
   Choice_IO.Get (Item => Choice_2);
   Choice_IO.Put (Item => Choice_1);
   Ada.Text_IO.Put (Item => " ");
   Choice_IO.Put (Item => Choice_2);
   Ada.Text_IO.New_Line (Spacing => 2);

   -- Determine winner

  if Choice_1 = Choice_2 then                                 -- Tie Game
     Ada.Text_IO.Put (Item => "Both players entered ");
     Choice_IO.Put (Item => Choice_1);
     Ada.Text_IO.Put (Item => ". The game is a tie.");

  elsif (Choice_1 = rock and Choice_2 = scissors) or (Choice_1 = paper and Choice_2 = rock) or (Choice_1 = scissors and Choice_2 = paper) then  -- Player 1 Wins
     Ada.Text_IO.Put (Item => "The first player's choice of ");
     Choice_IO.Put (Item => Choice_1);
     Ada.Text_IO.Put (Item => " beats ");
     Choice_IO.Put (Item => Choice_2);
     Ada.Text_IO.Put (Item => ".");
  elsif (Choice_2 = rock and Choice_1 = scissors) or (Choice_2 = paper and Choice_1 = rock) or (Choice_2 = scissors and Choice_1 = paper) then  -- Player 2 Wins
     Ada.Text_IO.Put (Item => "The second player's choice of ");
     Choice_IO.Put (Item => Choice_2);
     Ada.Text_IO.Put (Item => " beats ");
     Choice_IO.Put (Item => Choice_1);
     Ada.Text_IO.Put (Item => ".");
  end if;
end Assign4;
     