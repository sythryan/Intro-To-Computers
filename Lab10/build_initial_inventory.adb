with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Direct_IO;
procedure Build_Initial_Inventory is

-- This program creates an initial inventory file for the candy company
-- The intial inventory contains only four candy bars
--
-- Written by John McCormick
--
-- Input from keyboard
--    The name for the initial inventory file
--    Quantities in stock for each of the four candy bars
--
-- Output
--    Prompts to screen
--    Intial values to inventory file
--
-- Assumptions
--    The user enters four valid Natural numbers

   type Product_Type is (Chunky, Skybar, Valomilk, Zagnut);
      pragma Warnings (Off, Chunky);    -- Turn off warnings
      pragma Warnings (Off, Skybar);    -- for not using the
      pragma Warnings (Off, Valomilk);  -- four Product_Type
      pragma Warnings (Off, Zagnut);    -- literals directly

   -- I/O Package for the inventory file
   package Inventory_IO is new Ada.Direct_IO (Element_Type => Natural);

   -- Declarations for the initial inventory file

   Max_Name_Size : constant := 50;
   subtype File_Name_String is String (1 .. Max_Name_Size);

   Name   : File_Name_String;
   Length : Natural;
   File   : Inventory_IO.File_Type;


   Amount : Natural;  -- One value in the inventory file

begin
   Ada.Text_IO.Put_Line ("What name do you wish to use for the inventory file?");
   Ada.Text_IO.Get_Line (Item => Name,
                         Last => Length);

   -- Prepare the file for output
   Inventory_IO.Create (File => File,
                        Name => Name (1 .. Length),
                        Mode => Inventory_IO.Out_File);

   Ada.Text_IO.Put_Line ("Enter the 4 values for Chunky, Skybar, Valomilk, and Zagnut");

   -- Fill in the initial inventory file
   -- Each iteration, write one value to the inventory file
   for Product in Product_Type loop
      Ada.Integer_Text_IO.Get (Amount);
      Inventory_IO.Write (Item => Amount,
                          File => File);
   end loop;

   Inventory_IO.Close (File);
end Build_Initial_Inventory;
