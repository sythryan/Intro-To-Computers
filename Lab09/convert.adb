with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Ada.Text_IO;          use Ada.Text_IO;
procedure Convert is

   -- This program displays a table for converting centigrade temperatures
   -- to Fahrenheit temperatures

   Column_Width : constant := 7;  -- The width of one column in the table

   type Centigrade is digits 8 range 0.0 .. Float'Last;
   type Fahrenheit is digits 8 range 0.0 .. Float'Last;

   package Fahrenheit_IO is new Ada.Text_IO.Float_IO (Fahrenheit);

   ----------------------------------------------------------------------------
   function To_Fahrenheit (Degrees : in Centigrade) return Fahrenheit is
   -- Preconditions : None
   begin
      return Fahrenheit (Degrees);
   end To_Fahrenheit;

   ----------------------------------------------------------------------------
   procedure Display_Row (First : in Centigrade) is
   -- Displays one row of 10 values in a Centigrade to Fahrenheit conversion chart
   -- Preconditions : None
   --
   -- First is the temperature of the first value to display

      Centigrade_Temperature : Centigrade;
      Fahrenheit_Temperature : Fahrenheit;
   begin
      -- Display the ten temperatures in the row
      -- Each iteration, display one temperature
      for Degree in 0 .. 9 loop
         Centigrade_Temperature := 0.0;
         Fahrenheit_Temperature := To_Fahrenheit (Centigrade_Temperature);
         Fahrenheit_IO.Put (Item => Fahrenheit_Temperature,
                            Fore => Column_Width - 2,
                            Aft  => 1,
                            Exp  => 0);
      end loop;
   end Display_Row;


   ----------------------------------------------------------------------------
   procedure Display_Table (First_Label : in Centigrade;
                            Rows        : in Positive)   is
   -- Display the Centigrade to Fahrenheit table
   -- Preconditions : None

   -- First_Label is the starting Centigrade temperature
   -- Rows is the number of rows in the table

      Row_Label : Centigrade; -- The label to the left of the vertical line

   begin
      Row_Label := First_Label;

      -- Display the table
      -- Each iteration, display one line of the table
--      for Row in _________________ loop

         -- Display the label (as a whole number
         Put (Item  => Natural (Row_Label),
              Width => Column_Width);
         Put ('|');

         -- Display the rest of the row
         Display_Row (First => Row_Label);
         New_Line;

         Row_Label := Row_Label + 10.0;
--      end loop;
   end Display_Table;

   ----------------------------------------------------------------------------
   procedure Display_Headings is
   -- Displays the headings for the Centigrade to Fahrenheit table
   -- Preconditions  : None
   begin
      Set_Col (To => Column_Width);
      Put ("Centigrade to Fahrenheit Conversion Table");
      New_Line (2);

      Set_Col (To => Column_Width + 2);
      -- Display the numeric header labels
      -- Each iteration, display one label
--      for Count in ___________ loop
--         Put (Item  => Count,
--              Width => Column_Width);
--      end loop;
      New_Line;

      Set_Col (To => Column_Width + 2);
      -- Display the line of dashes
      -- Each iteration, display one dash
--      for Count ______________________ loop
--         Put ('-');
--      end loop;
      New_Line;
   end Display_Headings;

   ----------------------------------------------------------------------------
   procedure Get_Decade_Value (Item : out Centigrade) is
   -- Get a valid input value from the user
   -- Preconditions  : None
   -- Postconditions : Item is not negative and evenly divisible by 10

      Value : Integer;  -- Input value
   begin
      -- Get a non-negative value evenly divisible by 10
      -- Each iteration, check one user value
      loop
         Ada.Integer_Text_IO.Get (Value);
--         exit when ____________________;
         Put ("Your value must be evenly divisible by 10 and not negative");
         New_Line;
      end loop;
      Item := Centigrade (Value); -- Convert from type Integer to type Centigrade
   end Get_Decade_Value;


   ----------------------------------------------------------------------------
   Start          : Centigrade;    -- Input used to determine what rows are
   Number_Of_Rows : Positive;      -- displayed in the conversion table

begin
   -- Get the starting temperature for the conversion table

   Put ("Enter a starting Centigrade temperature for the conversion table.");
   New_Line;
   Put ("The value must be evenly divisible by 10");
   New_Line (2);
   Get_Decade_Value (Start);
   New_Line (2);

   -- Get the number of rows desired in the conversion table

   Put ("How many rows do you want in your table?  ");
   New_Line (2);
   Get (Number_Of_Rows);
   New_Line (4);

   -- Display table headings
   Display_Headings;

   -- Display the table
   Display_Table (First_Label => Start,
                  Rows        => Number_Of_Rows);


end Convert;

   