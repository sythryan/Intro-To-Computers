with Ada.Text_IO;
with Ada.Integer_Text_IO;

procedure Age is

-- This program computes a persons age
-- in a certain year

   -- Variables

   Year_Born   :   Integer;         -- Year person was born
   Future_Year :   Integer;         -- Future year
   Future_Age  :   Integer;         -- Future Age

   Last        :   Natural;

   First_Name  :   String (1..30);                  -- Person's first name
   Last_Name   :   String (1..30);                  -- Person's last name

Begin  -- Age

   Ada.Text_IO.Put         (Item => "Year born: ");          -- Prompt year born
   Ada.Integer_Text_IO.Get (Item => Year_Born);
   Ada.Text_IO.New_Line    (Spacing => 1);

   Ada.Text_IO.Put         (Item => "Future Year: ");        -- Prompt future year
   Ada.Integer_Text_IO.Get (Item => Future_Year);
   Ada.Text_IO.New_Line    (Spacing => 1);
   Ada.Text_IO.Skip_Line;

   Ada.Text_IO.Put         (Item => "First name: ");         -- Prompt for first name
   Ada.Text_IO.Get_Line    (Item => First_Name,
                            Last => Last);
   Ada.Text_IO.New_Line    (Spacing => 1);

   Ada.Text_IO.Put         (Item => "Last name: ");          -- Prompt for last name
   Ada.Text_IO.Get_Line    (Item => Last_Name,
                            Last => Last);
   Ada.Text_IO.New_Line    (Spacing => 1);

   Future_Age :=           (Future_Year - Year_Born);        -- How to solve for future age

   Ada.Text_IO.Put         (Item => Last_Name (1 .. Last));  -- Display results
   Ada.Text_IO.Put         (Item => ", ");
   Ada.Text_IO.Put         (Item => First_Name (1 .. Last));
   Ada.Text_IO.Put         (Item => " will be ");
   Ada.Integer_Text_IO.Put (Item => Future_Age,
                           Width => 1);
   Ada.Text_IO.Put         (Item => " years old in ");
   Ada.Integer_Text_IO.Put (Item => Future_Year,
                           Width => 1);

end Age;



                     