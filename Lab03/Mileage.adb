with Ada.Text_IO;
with Ada.Float_Text_IO;
with Ada.Integer_Text_IO;

procedure Mileage is

-- This program computes miles per gallon given four amounts
-- for gallons used, and starting and ending mileages

   -- Variables

   Amt1 : Float;      -- Number of gallons for fillup 1
   Amt2 : Float;      -- Number of gallons for fillup 2
   Amt3 : Float;      -- Number of gallons for fillup 3
   Amt4 : Float;      -- Number of gallons for fillup 4

   Start_Miles : Float;                     -- Starting mileage
   End_Miles   : Float;                     -- Ending mileage
   MPG         : Float;                     -- Computed miles per gallon

   Car_Make      : String (1 .. 20);             -- Car Model Year

   Model_Year    : Integer range 1 .. 3000;      -- Car Make
   Last          : Integer range 0 .. 20;

BEGIN     -- Mileage
   Ada.Text_IO.Put (Item => "Model year: ");                   -- Prompt Model year
   Ada.Integer_Text_IO.Get (Item => Model_Year);
   Ada.Text_IO.Skip_Line;
   Ada.Text_IO.New_Line (Spacing => 2);

   Ada.Text_IO.Put (Item => "Make: ");                         -- Prompt Car Make
   Ada.Text_IO.Get_Line (Item => Car_Make,
                         Last => Last);
   Ada.Text_IO.New_Line (Spacing => 2);

   Ada.Text_IO.Put (Item => "Starting Miles: ");               -- Prompt starting miles
   Ada.Float_Text_IO.Get (Item => Start_Miles);
   Ada.Text_IO.New_Line (Spacing => 2);

   Ada.Text_IO.Put (Item => "Gallon amount on 4 fill ups: ");  -- Prompt gallons on fill ups
   Ada.Text_IO.New_Line (Spacing => 1);
   Ada.Float_Text_IO.Get (Item => Amt1);
   Ada.Float_Text_IO.Get (Item => Amt2);
   Ada.Float_Text_IO.Get (Item => Amt3);
   Ada.Float_Text_IO.Get (Item => Amt4);
   Ada.Text_IO.New_Line (Spacing => 2);

   Ada.Text_IO.Put (Item => "Ending Miles: ");                 -- Prompt ending miles
   Ada.Float_Text_IO.Get (Item => End_Miles);

   MPG := (End_Miles - Start_Miles) / (Amt1 + Amt2 + Amt3 + Amt4);

   Ada.Text_IO.Put       (Item => "For the gallon amounts: ");   -- Echo Print gallons on fillups
   Ada.Text_IO.New_Line  (Spacing => 1);
   Ada.Float_Text_IO.Put (Item => Amt1,
                          Fore => 4,
                          Aft  => 1,
                          Exp  => 0);
   Ada.Text_IO.Put       (Item => ',');
   Ada.Float_Text_IO.Put (Item => Amt2,
                          Fore => 4,
                          Aft  => 1,
                          Exp  => 0);
   Ada.Text_IO.Put       (Item => ',');
   Ada.Float_Text_IO.Put (Item => Amt3,
                          Fore => 4,
                          Aft  => 1,
                          Exp  => 0);
   Ada.Text_IO.Put       (Item => ',');
   Ada.Float_Text_IO.Put (Item => Amt4,
                          Fore => 4,
                          Aft  => 1,
                          Exp  => 0);
   Ada.Text_IO.New_Line  (Spacing => 2);

   Ada.Text_IO.Put       (Item => "a starting mileage of ");     -- Echo print, starting miles
   Ada.Float_Text_IO.Put (Item => Start_Miles,
                          Fore => 6,
                          Aft  => 1,
                          Exp  => 0);
   Ada.Text_IO.New_Line  (Spacing => 1);

   Ada.Text_IO.Put       (Item => "and an ending mileage of ");  -- Echo print, Ending miles
   Ada.Float_Text_IO.Put (Item => End_Miles,
                          Fore => 6,
                          Aft  => 1,
                          Exp  => 0);
   Ada.Text_IO.New_Line (Spacing => 2);

   Ada.Text_IO.Put         (Item => "Your ");                       -- Display of all information
   Ada.Integer_Text_IO.Put (Item  => Model_Year ,
                            Width => 1);
   Ada.Text_IO.Put         (Item => " ");
   Ada.Text_IO.Put         (Item => Car_Make (1 .. Last));
   Ada.Text_IO.Put         (Item => " got ");
   Ada.Float_Text_IO.Put   (Item  => MPG,
                            Fore => 2,
                            Aft  => 1,
                            Exp  => 0);
   Ada.Text_IO.Put         (Item => " miles per gallon");
   Ada.Text_IO.New_Line    (Spacing => 1);

end Mileage;
