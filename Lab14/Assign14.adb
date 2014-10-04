with Ada.Text_IO;
with Ada.Integer_Text_IO;
procedure Assign14 is

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


   -----------------------------------------------------------------------------
   procedure Binary_Search (List   : in  Student_Array;
                            Item   : in  Lucky_Range;
                            Found  : out Boolean;
                            Num    : out Natural) is
   -- Search List for the given Item
   -- Preconditions  : Items in List are in Ascending order
   -- Postconditions : if Item is in list
   --                        Found is True
   --                        Index is the location of Item
   --                  If Item is not in List
   --                        Found is False
   --                        Index is undefined
      First   : Integer; -- Lower index bound of list
      Last    : Integer; -- Upper index bound of list
      Middle  : Integer; -- Middle index
   begin
      First := List'First;   -- Set up initial
      Last  := List'Last;    -- list of bounds
      Found := False;

      Search_Loop :   -- Search for Item in List (First..Last)
      loop            -- Each iteration, check the middle value and half list
         exit Search_Loop when   Found         or      -- We found item
                                 First > Last;         -- No items left in list
         Middle := (First + Last) / 2;
         if Item < List (Middle).Lucky_Number then
            -- Item is not in List (Middle..Last)
            Last := Middle - 1; -- Redefine list to 1st half
         elsif Item > List (Middle).Lucky_Number then
            -- Item is not in List (Middle..Last)
            First := Middle + 1; -- Redefine list to 2nd half
         else
            Found := True;
            Num   := Middle;
         end if;
      end loop Search_Loop;
   end Binary_Search;

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
   procedure Display_Name (Students : in Student_Array;
                           I        : in Natural) is
   -- Display the student's name
   -- Preconditions  : None
   -- Postconditions : Name of student in array Students is displayed
      Blank_Pos : Natural;
   begin
      -- Display the last name without the padded blanks
      Blank_Pos := Index (Source  => Students (I).Name.Last,
                          Pattern => ' ');
      if Blank_Pos > 0 then
         Ada.Text_IO.Put (Students (I).Name.Last (1 .. Blank_Pos - 1));
      else
         Ada.Text_IO.Put (Students (I).Name.Last);
      end if;

      Ada.Text_IO.Put (',' & ' ');

      -- Display the first name without the padded blanks
      Blank_Pos := Index (Source  => Students (I).Name.First,
                          Pattern => ' ');
      if Blank_Pos > 0 then
         Ada.Text_IO.Put (Students (I).Name.First (1 .. Blank_Pos - 1));
      else
         Ada.Text_IO.Put (Students (I).Name.First);
      end if;
   end Display_Name;

   ----------------------------------------------------------------------------
   procedure Display_Students (Students : in Student_Array) is
   -- Display all the student information, one student per line
   -- Preconditions  : None
   -- Postconditions : Data in array Students is displayed
   begin
      for I in Students'Range loop
         Display_Name (Students => Students,
                       I        => I);

         -- Display the student's lucky number
         Ada.Text_IO.Set_Col (To => 25);
         Lucky_IO.Put (Item  => Students (I).Lucky_Number,
                       Width => 1);
         Ada.Text_IO.New_Line;
      end loop;
   end Display_Students;


   ----------------------------------------------------------------------------
   procedure Search_Ordered (List : in out Student_Array) is
   -- Sorts all students in the array by lucky number
   -- Preconditions  : None
   -- Postconditions : Array sorted by lucky number
      Value : Student_Rec;
      J     : Natural;
   begin
      for Index in (List'First + 1) .. List'Last loop
         Value := List (Index);
         J     := Index - 1;
         while J in List'Range and then List (J).Lucky_Number > Value.Lucky_Number loop
            List (J + 1) := List (J);
            J := J - 1;
         end loop;
         List (J + 1) := Value;
      end loop;
   end Search_Ordered;

-------------------------------------------------------------------------------

   Class : Class_Array;   -- Information of a class
   Size  : Natural;       -- The number of students in the class
   Item  : Lucky_Range;   -- Item to search
   Test  : Integer;       -- Temp variable to test domain of Lucky_Range
   Found : Boolean;       -- Whether Item was found
   Num   : Integer;       -- Where Item was found


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
   Search_Ordered (Class (1 .. Size));
   Display_Students (Class (1 .. Size));
   Ada.Text_IO.New_Line (2);

   loop
      Ada.Text_IO.Put ("Please enter a lucky number: ");
      Ada.Integer_Text_IO.Get (Test);
      exit when Test > 9999 or Test < 1000;
      Item := Lucky_Range (Test);
      Binary_Search (List => Class (1 .. Size),
                     Item => Item,
                     Found => Found,
                     Num   => Num);
      if Found then
         Display_Name (Students => Class,
                       I        => Num);
         Ada.Text_IO.Put (" picked the lucky number ");
         Lucky_IO.Put (Class (Num).Lucky_Number, 1);
         Ada.Text_IO.New_Line (2);
      else
         Ada.Text_IO.Put ("No student has lucky number ");
         Ada.Integer_Text_IO.Put (Test, 1);
         Ada.Text_IO.New_Line (2);
      end if;
   end loop;
end Assign14;
      