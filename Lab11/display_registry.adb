with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Sequential_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
procedure Display_Registry is

   -- This program displays a gift registry
   --
   -- Input
   --   Last name (for registry file name)
   --   Binary file of gift information
   --
   --  Output
   --    Prompt
   --
   --  Assumptions
   --     The binary file exists
   --     No blanks or special characters in the last name

   -- Column positions
   Column_2 : constant Ada.Text_IO.Positive_Count :=  8;
   Column_3 : constant Ada.Text_IO.Positive_Count := 38;
   Column_4 : constant Ada.Text_IO.Positive_Count := 48;
   Column_5 : constant Ada.Text_IO.Positive_Count := 58;


   -- Declarations for gift descriptions

   Max_Chars : constant := 25;

   subtype Description_String       is String (1 .. Max_Chars);
   subtype Description_Length_Range is Integer range 0 .. Max_Chars;

   type Description_Rec is
      record
         Item : Description_String;
         Last : Description_Length_Range;
      end record;


   -- Declarations for gift information

   type Dollars is delta 0.01 digits 5 range 0.00 .. 999.00;
   type Gift_Rec is
      record
         Description : Description_Rec;    -- The name of the gift
         Price       : Dollars;            -- Approximate cost
         Quantity    : Positive;           -- Quantity desired
         Purchased   : Natural;            -- Quantity purchased
      end record;


   -- I/O Package instantiations
   package Gift_IO   is new Ada.Sequential_IO (Element_Type => Gift_Rec);
   package Dollar_IO is new Ada.Text_IO.Decimal_IO (Num => Dollars);

   subtype File_String is String (1 .. 50); -- For file names

   ----------------------------------------------------------------------------
   procedure Put_Gift (Number : in Natural;
                       Gift   : in Gift_Rec) is
   -- Display the information for one gift on a line
   -- Preconditions  : None
   -- Postconditions : One line of information is displayed
   --                  The cursor is left at the end of that line
   begin
      Put (Item  => Number,
           Width => 4);

      -- Display the description
      Set_Col (To => Column_2);
      Put (Gift.Description.Item (1 .. Gift.Description.Last));

      -- Display the price
      Set_Col (To => Column_3);
      Dollar_IO.Put (Item => Gift.Price,
                     Fore => 3,
                     Aft  => 2,
                     Exp  => 0);

      -- Display the quantity desired
      Set_Col (To => Column_4);
      Put (Item  => Gift.Quantity,
           Width => 5);

      -- Display the number curently purhased
      Set_Col (To => Column_5);
      Put (Item  => Gift.Purchased,
           Width => 5);

   end Put_Gift;

   ----------------------------------------------------------------------------
   procedure Put_Headings is
   -- Displays the headings
   -- Preconditions : None
   begin
      Put ("Item");
      Set_Col (To => Column_2);
      Put ("Description");
      Set_Col (To => Column_3);
      Put (" Price");
      Set_Col (To => Column_4);
      Put ("Quantity");
      Set_Col (To => Column_5);
      Put ("Quantity");
      New_Line;
      Put ("   #");
      Set_Col (To => Column_4);
      Put ("Desired");
      Set_Col (To => Column_5);
      Put ("Purchased");
      New_Line (2);
   end Put_Headings;


-------------------------------------------------------------------------------

   File_Name : File_String;    -- The file name and
   Length    : Natural;        -- its length

   Gift      : Gift_Rec;            -- One gift;
   Gift_File : Gift_IO.File_Type;   -- A file of gifts

   Count : Natural := 0;       -- Number of gifts

begin
   -- Open the gift registry file

   Put_Line ("Enter your last name");
   Get_Line (Item => File_Name,
             Last => Length);
   Gift_IO.Open (File => Gift_File,
                 Mode => Gift_IO.In_File,
                 Name => File_Name (1 .. Length));

   -- Display table headings
   New_Line (3);
   Put_Headings;

   -- Display the gifts in the registry
   -- Each iteration, display one gift
   loop
      exit when Gift_IO.End_Of_File (Gift_File);

      -- Get and display a gift
      Gift_IO.Read (File => Gift_File,
                    Item => Gift);
      Count := Count + 1;
      Put_Gift (Number => Count,
                Gift   => Gift);
      New_Line;
   end loop;

   Gift_IO.Close (Gift_File);
   New_Line (2);
   Put_Line ("You have" & Integer'Image (Count) & " gifts in your registry");

end Display_Registry;            