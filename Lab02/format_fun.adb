with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
procedure Format_Fun is

   Octane           : constant Integer := 89;
   Inches_Per_Meter : constant Float   := 39.370_078_740_157;
   Avogadro         : constant Float   := 6.022_141_99E23;

begin


   -- Use the following lines to learn about the output of whole numbers
--   Ada.Text_IO.Put (Item => "12345678901234567890");
--   Ada.Text_IO.New_Line;
--   Ada.Integer_Text_IO.Put (Item  => -Octane,
--                            Width => 5);
--   Ada.Text_IO.New_Line;
--   Ada.Text_IO.New_Line;


--   -- Use the following lines to learn about the output of real numbers in common decimal form
--   Ada.Text_IO.Put (Item => "12345678901234567890");
--   Ada.Text_IO.New_Line;
--   Ada.Float_Text_IO.Put (Item => Inches_Per_Meter,
--                          Fore => 5,
--                          Aft  => 5,
--                          Exp  => 0);
--   Ada.Text_IO.New_Line;
--   Ada.Text_IO.New_Line;
--
   -- Use the following lines to learn about the output of real numbers in scientific notation form
   Ada.Text_IO.Put (Item => "12345678901234567890");
   Ada.Text_IO.New_Line;
   Ada.Float_Text_IO.Put (Item => Avogadro,
                          Fore => 1,
                          Aft  => 2,
                          Exp  => 5);
   Ada.Text_IO.New_Line;

end Format_Fun;