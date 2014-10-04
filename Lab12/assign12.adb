with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.IO_Exceptions;
procedure Assign12 is
-- Written by Syth Ryan
--
-- This program computes
--
-- Input
--
-- Output
--
-- Assumptions

   subtype Digit is Integer range 0 .. 9;  -- One digit
   type Digit_Array is array (Positive range <>) of Digit; -- Group of digits

   subtype Small_Array is Digit_Array (1 .. 50);  -- max of 50 digits per line
-------------------------------------------------------------------------------
   procedure Prepare_File (File : out Ada.Text_IO.File_Type) is

      -- Variables
      File_Name : String (1 .. 80); -- Name of the file
      Length    : Natural;          -- Length of the file name
   begin
      loop      -- Get a valid file name
         begin  -- Each iteration, check one file name
            Ada.Text_IO.Put_Line ("Enter the file name");
            Ada.Text_IO.Get_Line (Item => File_Name,
                                  Last => Length);
            Ada.Text_IO.Open (File => File,
                        Mode => Ada.Text_IO.In_File,
                        Name => File_Name (1 .. Length));
            exit;
         exception
            when Ada.IO_Exceptions.Name_Error =>
               Ada.Text_IO.Put_Line ("Invalid file name");
         end;
      end loop;
   end Prepare_File;

-------------------------------------------------------------------------------
   procedure Get_Digits (File    : in Ada.Text_IO.File_Type;
                         Item    : out Digit_Array;
                         Size    : out Natural) is

   -- Reads one line of digits from File
   -- Any multi-digit numbers in the line are ignored
   --
   -- Preconditions : File is open for input
   --
   -- Postconditions : Item contains the digits from the current line
   -- Size contains the index of the last number in
   -- array Item
   -- If there are no digits in Item, Size is set to
   -- Zero
   -- The reading marker is left on the line terminator

      -- Variables
      One_Number : Integer;

   begin
      Size := 0;
      -- Process one line of digits
      -- Each iteration, get one digit
      loop
         exit when Ada.Text_IO.End_Of_Line (File);
         Ada.Integer_Text_IO.Get (File => File,
                                  Item => One_Number);
         if One_Number > -1 and One_Number < 10 then
            Size := Size + 1;
            Item (Size) := One_Number;
         end if;
      end loop;
   end Get_Digits;
-------------------------------------------------------------------------------
   procedure Check_Pattern (Pattern    : in Small_Array;
                            Digit_Line : in Small_Array;
                            Line_Size  : in Natural;
                            Size       : in Natural;
                            Count      : out Natural;
                            P_Count    : out Natural) is

      -- Variables
      Point_1  : Natural; -- Beginning reader
      Point_2  : Natural; -- Ending reader

   begin
      Count   := 0;
      P_Count := 0;
      Point_1 := 1;
      Point_2 := Pattern'Length;

      loop
         exit when Point_2 > Line_Size;
         if Pattern = Digit_Line (Point_1 .. Point_2) then
            P_Count := P_Count + 1;
         end if;
         Count := Count + 1;
         Point_1 := Point_1 + 1;
         Point_2 := Point_2 + 1;
      end loop;
   end Check_Pattern;
-------------------------------------------------------------------------------
   procedure Search_File (File    : in Ada.Text_IO.File_Type;
                          Pattern : in Small_Array;
                          Size    : in Natural;
                          Count   : out Natural;
                          P_Count : out Natural) is
      -- Variables
      Digit_Line : Small_Array;  -- one line of digits
      Line_Size  : Natural;      -- Size of one line

   begin
            -- Process Many Lines of Digits in a File
      loop  -- Each iteration, Process one Line
         exit when Ada.Text_IO.End_Of_File (File);
         Get_Digits (File => File,
                     Item => Digit_Line,
                     Size => Line_Size);
         Digit_Line := Digit_Line (1 .. Digit_Line'Last);   -- Slice Digit line
         -- Check Pattern
         Check_Pattern (Pattern    => Pattern,
                        Digit_Line => Digit_Line,
                        Line_Size  => Line_Size,
                        Count      => Count,
                        P_Count    => P_Count,
                        Size       => Size);
      end loop;

   end Search_File;


-------------------------------------------------------------------------------
-- Main Program

   -- Variables
   File    : Ada.Text_IO.File_Type; -- File containing digits
   Pattern : Small_Array;           -- Pattern of digits
   Size    : Natural;               -- Size of Pattern
   Count   : Natural;            -- Number of lines processed
   P_Count : Natural;            -- Number of patterns found

begin

   -- Prepare File (get back file)
   Prepare_File (File => File);
   -- Get Pattern (get back pattern and size of pattern)
   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put_Line ("enter the desired pattern");
   Get_Digits (File => Ada.Text_IO.Standard_Input,
               Item => Pattern,
               Size => Size);
   Pattern := Pattern (1 .. Pattern'Last);     -- slice pattern
   -- Search File (give pattern and file,
   --              get back lines and matches
   Search_File (File    => File,
                Pattern => Pattern,
                Size    => Size,
                Count   => Count,
                P_Count => P_Count);
   -- Close file
   Ada.Text_IO.Close (File);
   -- Display results
   Ada.Integer_Text_IO.Put (Count, 1);
   Ada.Text_IO.Put_Line (" lines processed.");
   Ada.Text_IO.Put (" The pattern ");

   -- Put the pattern
   -- Each iteration, put one digit
   for Index in Pattern'First .. Pattern (Size) loop
      Ada.Integer_Text_IO.Put (Pattern (Index), 1);
   end loop;
   Ada.Text_IO.Put (" was found ");
   Ada.Integer_Text_IO.Put (P_Count, 1);
   Ada.Text_IO.Put_Line (" times.");

end Assign12;