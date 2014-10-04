with Ada.Text_IO;
procedure InLab14 is

-- Assumptions
--   1. The data file is formatted with name on one line followed by
--      lucky number on a second line
--   2. The name is in the form Last Name comma First Name

   subtype Name_String is String (1 .. 20);
   type    Lucky_Range is range 1000 .. 9999;

   type Name_Rec is
      record
         First : Name_String;
         Last  : Name_String;
      end record;

   type Student_Rec is
      record
         Name         : Name_Rec;
         Lucky_Number : Lucky_Range;
      end record;

   type    Student_Array is array (Positive range <>) of Student_Rec;
   subtype Class_Array   is Student_Array (1 .. 50);

   package Lucky_IO is new Ada.Text_IO.Integer_IO (Num => Lucky_Range);

   ----------------------------------------------------------------------------
   function Index (Source  : in String;
                   Pattern : in Character) return Natural is
   -- Returns the index of the first occurrence of Pattern in Source
   -- Preconditions  : None
   -- Postconditions : If Source contains Pattern then
   --                     Source (Result) = Pattern
   --                  Else
   --                     Result is zero

      Result : Natural;

   begin
      Result := Source'First;
      loop
         exit when Result > Source'Last   or else
                   Source (Result) = Pattern;
         Result := Result + 1;
      end loop;

      if Result > Source'Last then
         return 0;
      else
         return Result;
      end if;
   end Index;


   ----------------------------------------------------------------------------
   procedure Get_Name (File : in out Ada.Text_IO.File_Type;
                       Name :    out Name_Rec) is
   -- Gets a student name from single line of a data file
   -- Preconditions  : File is open for input
   -- Postconditions : Name contains blank padded first and last names

      subtype Name_String is String (1 .. 40);

      Whole_Name     : Name_String;
      Length         : Natural;
      Comma_Position : Natural;

   begin
      Ada.Text_IO.Get_Line (File => File,
                            Item => Whole_Name,
                            Last => Length);
      Comma_Position := Index (Source  => Whole_Name (1 .. Length),
                               Pattern => ',');
      -- Copy the last name and first name into the record
      Name.Last (1 .. Comma_Position - 1)           := Whole_Name (1 .. Comma_Position - 1);
      Name.First (1 .. Length - Comma_Position - 1) := Whole_Name (Comma_Position + 2 .. Length);

      -- Pad the last name and first name with blanks (both statements are incorrect!)
      Name.Last (Comma_Position .. Name.Last'Last)   := (others => ' ');
      Name.First (Length - Comma_Position .. Name.First'Last) := (others => ' ');
   end Get_Name;


   ----------------------------------------------------------------------------
   procedure Get_Students (Class : out Student_Array;
                           Last  : out Natural) is
   -- Gets the data for a class of students
   -- Preconditions  : None
   -- Postconditions : Class contains the data read
   --                  Last is the index of the last element read
   --                  If no elements are read, Last is Class'First - 1

      subtype File_String is String (1 .. 80);

      File      : Ada.Text_IO.File_Type;
      File_Name : File_String;
      Length    : Natural;

   begin
      Ada.Text_IO.Put_Line ("Enter the name of the data file with student information.");
      Ada.Text_IO.Get_Line (Item => File_Name,
                            Last => Length);
      Ada.Text_IO.Open (File => File,
                        Mode => Ada.Text_IO.In_File,
                        Name => File_Name (1 .. Length));

      Last := Class'First - 1;

      -- Get the student data from the file
      -- Each iteration, get the data for one student
      loop
         exit when Ada.Text_IO.End_Of_File (File);
         Last := Last + 1;
         -- Get the student's name
         Get_Name (File => File,
                   Name => Class (Last).Name);
         -- Get the student's lucky number
         Lucky_IO.Get (File => File,
                       Item => Class (Last).Lucky_Number);

         if not Ada.Text_IO.End_Of_File (File) then
            Ada.Text_IO.Skip_Line (File);
         end if;
      end loop;

      Ada.Text_IO.Close (File);
   end Get_Students;


   ----------------------------------------------------------------------------
   procedure Display_Students (Students : in Student_Array) is
   -- Display all the student information, one student per line
   -- Preconditions  : None
   -- Postconditions : Data in array Students is displayed
      Blank_Pos : Natural;
   begin
      for I in Students'Range loop

                  -- Display the last name without the padded blanks
         Blank_Pos := Index (Source  => Students (I).Name.Last,
                             Pattern => ' ');
         if Blank_Pos > 0 then
            Ada.Text_IO.Put (Students (I).Name.Last (1 .. Blank_Pos - 1));
         else
            Ada.Text_IO.Put (Students (I).Name.Last);
         end if;
         Ada.Text_IO.Put (',');

         Ada.Text_IO.Put (' ');  -- Blank between first and last name

         -- Display the first name without the padded blanks
         Blank_Pos := Index (Source  => Students (I).Name.First,
                             Pattern => ' ');
         if Blank_Pos > 0 then
            Ada.Text_IO.Put (Students (I).Name.First (1 .. Blank_Pos - 1));
         else
            Ada.Text_IO.Put (Students (I).Name.First);
         end if;





         -- Display the student's lucky number
         Ada.Text_IO.Set_Col (To => 25);
         Lucky_IO.Put (Item  => Students (I).Lucky_Number,
                       Width => 1);
         Ada.Text_IO.New_Line;
      end loop;
   end Display_Students;


   ----------------------------------------------------------------------------
   function "<" (Left  : in Name_Rec;
                 Right : in Name_Rec) return Boolean is
   begin
      if Left.Last < Right.Last then
         return True;
      elsif Left.Last = Right.Last then
         if Left.First < Right.First then
            return True;
         else
            return False;
         end if;
      else
         return False;
      end if;
   end "<";


   ----------------------------------------------------------------------------
   procedure Swap (Left  : in out Student_Rec;
                   Right : in out Student_Rec) is

      Temp : Student_Rec;
   begin
      Temp  := Left;
      Left  := Right;
      Right := Temp;
   end Swap;


   ----------------------------------------------------------------------------
   function Position_Of_Smallest_Name (List : in Student_Array) return Positive is
      Result : Positive;
   begin
      Result := List'First;
      for Index in List'First + 1 .. List'Last loop
         if List (Index).Name < List (Result).Name then
            Result := Index;
         end if;
      end loop;
      return Result;
   end Position_Of_Smallest_Name;


   --------------------------------------------------------------------------
   procedure Sort_By_Name (List : in out Student_Array) is
      Min_Index : Positive;
   begin
      for Pass in List'First .. List'Last - 1 loop
         Min_Index := Position_Of_Smallest_Name (List (Pass .. List'Last));
         Swap (Left => List (Min_Index), Right => List (Pass));
      end loop;
   end Sort_By_Name;


   ----------------------------------------------------------------------------
   function Position_Of_Smallest_Number (List : in Student_Array) return Positive is
      Result : Positive;
   begin
      Result := List'First;
      for Index in List'First + 1 .. List'Last loop
         if List (Index).Lucky_Number < List (Result).Lucky_Number then
            Result := Index;
         end if;
      end loop;
      return Result;
   end Position_Of_Smallest_Number;


   ----------------------------------------------------------------------------
   procedure Sort_By_Lucky_Number (List : in out Student_Array) is
      Min_Index : Positive;
   begin
      for Pass in List'First .. List'Last - 1 loop
         Min_Index := Position_Of_Smallest_Number (List (Pass .. List'Last));
         Swap (Left => List (Min_Index), Right => List (Pass));
      end loop;
   end Sort_By_Lucky_Number;


-------------------------------------------------------------------------------

   Class : Class_Array;   -- Information of a class
   Size  : Natural;       -- The number of students in the class

begin
   Get_Students (Class => Class,
                 Last  => Size);
   Ada.Text_IO.New_Line (2);

   Ada.Text_IO.Put_Line ("The unordered list of students");
   Ada.Text_IO.New_Line;
   Display_Students (Class (1 .. Size));
   Ada.Text_IO.New_Line (2);

   Ada.Text_IO.Put_Line ("Students ordered by lucky number");
   Ada.Text_IO.New_Line;
   Sort_By_Lucky_Number (Class (1 .. Size));
   Display_Students (Class (1 .. Size));
   Ada.Text_IO.New_Line (2);

   Ada.Text_IO.Put_Line ("Students ordered by name");
   Ada.Text_IO.New_Line;
   Sort_By_Name (Class (1 .. Size));
   Display_Students (Class (1 .. Size));
end InLab14;
      