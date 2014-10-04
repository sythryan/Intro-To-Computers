with Ada.Text_IO;                               -- Syth Ryan
with Ada.Float_Text_IO;
with Ada.Integer_Text_IO;

procedure assign3 is         --  assignment 3 calculating compound interest

-- This computes the amount of money in an account
-- after certain years and times compounded

   -- Variables

   Money         : Float;                        -- Amount of money invested
   Rate          : Float;                        -- Interest rate
   Money_end     : Float;                        -- Ending amount after interest
   Rate_Compound : Float;                        -- Rate divided by Compound
   Decimal       : Float;                        -- Interest rate in decimal form

   Years           : Integer;                      -- Number of years investing
   Compound        : Integer;                      -- Amount of times compounded
   Last_Char       : Integer;                      -- length of string

   Name            : String (1 .. 20);             -- Name of the account


---------------------------------------

begin      -- Interest

   -- Input
   -- Gathers all the information required to
   -- find the ending amount after compounded interest

   Ada.Text_IO.Put (Item => "Amount of money invested: ");              -- Prompt and get
   Ada.Float_Text_IO.Get (Item => Money);                               -- amount of money invested
   Ada.Text_IO.New_Line (Spacing => 2);

   Ada.Text_IO.Put (Item => "Interest rate %: ");                       -- Prompt and get
   Ada.Float_Text_IO.Get (Item => Rate);                                -- interest rate
   Ada.Text_IO.New_Line (Spacing => 2);

   Ada.Text_IO.Put (Item => "Number of Years: ");                       -- Prompt and get
   Ada.Integer_Text_IO.Get (Item => Years);                             -- number of years
   Ada.Text_IO.New_Line (Spacing => 2);

   Ada.Text_IO.Put (Item => "Number of times compounded per year: ");   -- Prompt and get number of
   Ada.Integer_Text_IO.Get (Item => Compound);                          -- times compounded
   Ada.Text_IO.Skip_Line;
   Ada.Text_IO.New_Line (Spacing => 2);

   Ada.Text_IO.Put (Item => "Name of the account: ");                   -- Prompt and get name of the account
   Ada.Text_IO.Get_Line (Item => Name, Last => Last_Char);
   Ada.Text_IO.New_Line (Spacing => 5);

   Decimal         := Rate / 100.0;                         -- Solve rate % to decimal form

   Rate_Compound   := Decimal / Float (Compound);           -- Solve rate decimal divided by compound


   Money_end       := Money * (1.0 + Rate_Compound) ** (Years * Compound);  -- Solve for ending amount

   -- Output
   -- Displays all the inputs and the ending amount after compound interest.
   -- For example "There is $270.27 in the account syth after 5 years."


   Ada.Text_IO.Put (Item => "Amount of money invested: $ ");            -- Echo print
   Ada.Float_Text_IO.Put (Item => Money,                                -- amount of money invested
                            Fore => 4,
                            Aft  => 2,
                            Exp  => 0);
   Ada.Text_IO.New_Line (Spacing => 2);

   Ada.Text_IO.Put (Item => "Interest rate %: ");                       -- Echo print
   Ada.Float_Text_IO.Put (Item => Rate,                                 -- interest rate
                            Fore => 4,
                            Aft  => 2,
                            Exp  => 0);
   Ada.Text_IO.New_Line (Spacing => 2);

   Ada.Text_IO.Put (Item => "Number of Years: ");                       -- Echo print
   Ada.Integer_Text_IO.Put (Item => Years, Width => 1);                 -- number of years
   Ada.Text_IO.New_Line (Spacing => 2);

   Ada.Text_IO.Put (Item => "Number of times compounded per year: ");   -- Echo print
   Ada.Integer_Text_IO.Put (Item => Compound, Width => 1);              -- times compounded
   Ada.Text_IO.New_Line (Spacing => 2);

   Ada.Text_IO.Put (Item => "Name of the account: ");                   -- Echo print name of the account
   Ada.Text_IO.Put (Item => Name (1 .. Last_Char));
   Ada.Text_IO.New_Line (Spacing => 2);

   Ada.Text_IO.Put         (Item => "There is ");
   Ada.Text_IO.Put         (Item => "$");
   Ada.Float_Text_IO.Put   (Item => Money_end,                              -- Echo print ending money amount
                            Fore => 4,
                            Aft  => 2,
                            Exp  => 0);
   Ada.Text_IO.Put         (Item => " in the account ");
   Ada.Text_IO.Put         (Item => Name (1 .. Last_Char));                 -- Echo print name of the account
   Ada.Text_IO.Put         (Item => " after ");
   Ada.Integer_Text_IO.Put (Item => Years,                                  -- Echo print number of years
                            Width => 1);
   Ada.Text_IO.Put         (Item => " years.");
end assign3;









