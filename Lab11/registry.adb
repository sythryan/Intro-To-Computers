with Ada.Text_IO;              use Ada.Text_IO;
with Ada.Direct_IO;
with Ada.Integer_Text_IO;      use Ada.Integer_Text_IO;
with Ada.Characters.Handling;  use Ada.Characters.Handling;
procedure Registry is

   -- This program is used to select gifts from a registry
   --
   -- Input
   --   Last name (for registry file name)
   --   Gift search parameters
   --   Binary file of gift information
   --
   --  Output
   --    Prompts
   --    Updated binary file of gift information
   --
   --  Assumptions
   --     The binary file exists
   --     No blanks or special characters in the last name
   --     User input is valid (no data validation is done)

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
   package Gift_IO   is new Ada.Direct_IO (Element_Type => Gift_Rec);
   package Dollar_IO is new Ada.Text_IO.Decimal_IO (Num => Dollars);

   subtype File_String is String (1 .. 50); -- For file names

   subtype Choice_Range is Integer range 1 .. 4;

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


   ----------------------------------------------------------------------------
   procedure Pick_A_Gift (Gift_File  : in out Gift_IO.File_Type) is
   -- Gets a gift choice from the user and updates the registry
   -- Preconditions  : Gift_File is open for input and output
   -- Postconditions : The entry for the desired gift is updated

      Gift_Index : Natural;  -- The index of the desired gift
      Quantity   : Natural;  -- The gift quantity
      Gift       : Gift_Rec; -- One gift

   begin
      Put_Line ("Enter the number of the gift you would like to select");
      Put_Line ("Enter 0 if you don't want to select any gift");
      Get (Gift_Index);
      New_Line;

      if Gift_Index > 0 then
         Put_Line ("Enter the quantity you plan to purchase");
         Get (Quantity);

         -- No need to update file if Quantity is zero
         if Quantity > 0 then
            -- Update the file
            Gift_IO.Read (File => Gift_File,
                          Item => Gift,
                          From => Gift_IO.Positive_Count (Gift_Index));

            Gift.Purchased := Gift.Purchased + Quantity;

            Gift_IO.Write (File => Gift_File,
                           Item => Gift,
                           To   => Gift_IO.Positive_Count (Gift_Index));
         end if;
      end if;
   end Pick_A_Gift;

   ----------------------------------------------------------------------------
   function Same_Description (Left  : in Description_Rec;
                              Right : in Description_Rec) return Boolean is
   -- Returns True if Left and Right are the same (case insensitive)
   begin
      return To_Lower (Left.Item (1 .. Left.Last))  = To_Lower (Right.Item (1 .. Right.Last));
   end Same_Description;


   ----------------------------------------------------------------------------
   procedure Search_By_Description (Gift_File : in out Gift_IO.File_Type) is
   -- Used to pick a gift with a particular description in the registry
   -- Preconditions  : File is open for input and output
   -- Postconditions : File is modified according to the choices made by the user

      Gift        : Gift_Rec;         -- One gift
      Description : Description_Rec;  -- A description of the gift
      Num_Found   : Natural := 0;     -- Number of matches found

   begin
      New_Line (2);
      Put_Line ("Enter a gift description that you want to find");
      Get_Line (Item => Description.Item,
                Last => Description.Last);
      New_Line;

      -- Display all the gift choices as a table

      Put_Headings;
      Gift_IO.Set_Index (File => Gift_File,
                         To   => 1);
      -- Display all of the gifts in the registry that have the desired name
      -- Each iteration, display one gift
      for Index in 1 .. Gift_IO.Size (Gift_File) loop
         Gift_IO.Read (File => Gift_File,
                       Item => Gift);
         if Same_Description (Description, Gift.Description) then
            Put_Gift (Gift   => Gift,
                      Number => Natural (Index));
            New_Line;
            Num_Found := Num_Found + 1;
         end if;
      end loop;
      New_Line (2);

      if Num_Found > 0 then
         Pick_A_Gift (Gift_File);
      else
         Put_Line ("No gifts were found that match that description");
      end if;

   end Search_By_Description;


   ----------------------------------------------------------------------------
   procedure Search_By_Price (Gift_File : in out Gift_IO.File_Type) is
   -- Used to pick a gift from gifts in the registry not above a particular price
   -- Preconditions  : File is open for input and output
   -- Postconditions : File is modified according to the choices made by the user

      Gift      : Gift_Rec;      -- One gift
      Max_Price : Dollars;       -- Maximum acceptable gift price
      Num_Found : Natural := 0;  -- Number of matches found
   begin
      New_Line (2);
      Put_Line ("What is the maximum price you wish to spend on a gift?");
      Dollar_IO.Get (Max_Price);
      New_Line;

      -- Display all the gift choices as a table

      Put_Headings;
      Gift_IO.Set_Index (File => Gift_File,
                         To   => 1);
      -- Display all of the gifts in the registry that are not above Max_Price
      -- Each iteration, display one gift
      for Index in 1 .. Gift_IO.Size (Gift_File) loop
         Gift_IO.Read (File => Gift_File,
                       Item => Gift);
         if Gift.Price <= Max_Price then
            Put_Gift (Gift   => Gift,
                      Number => Natural (Index));
            New_Line;
            Num_Found := Num_Found + 1;
         end if;
      end loop;
      New_Line (2);

      if Num_Found > 0 then
         Pick_A_Gift (Gift_File);
      else
         Put_Line ("No gifts were found at your price");
      end if;

   end Search_By_Price;


   ----------------------------------------------------------------------------
   procedure Search_All (Gift_File : in out Gift_IO.File_Type) is
   -- Used to pick a gift from all in the registry
   -- Preconditions  : File is open for input and output
   -- Postconditions : File is modified according to the choices made by the user

      Gift : Gift_Rec;  -- One gift

   begin
      -- Display all the gift choices as a table

      Put_Headings;
      Gift_IO.Set_Index (File => Gift_File,
                         To   => 1);
      -- Display all of the gifts in the registry
      -- Each iteration, display one gift
      for Index in 1 .. Gift_IO.Size (Gift_File) loop
         Gift_IO.Read (File => Gift_File,
                       Item => Gift);
         Put_Gift (Gift   => Gift,
                   Number => Natural (Index));
         New_Line;
      end loop;
      New_Line (2);

      Pick_A_Gift (Gift_File);

   end Search_All;

-------------------------------------------------------------------------------

   File_Name : File_String;    -- The file name and
   Length    : Natural;        -- its length

   Gift_File : Gift_IO.File_Type;   -- A file of gifts

   Choice : Choice_Range;  -- What kind of search

begin
   -- Open the gift registry file
   Put_Line ("Enter the last name of the gift registry owner");
   Get_Line (Item => File_Name,
             Last => Length);
   Gift_IO.Open (File => Gift_File,
                 Mode => Gift_IO.Inout_File,
                 Name => File_Name (1 .. Length));

   -- Search the gift registry
   -- Each iteration, search for one gift
   loop
      Put_Line ("How would you like to search for a gift?");
      Put_Line ("    1 = by gift description");
      Put_Line ("    2 = by gift price");
      Put_Line ("    3 = show me all the gifts");
      Put_Line ("    4 = end program");
      New_Line;
      Get (Choice);
      New_Line (2);
      exit when Choice = 4;
      -- Process the choice
      case Choice is
         when 1 =>
            Skip_Line;  -- Set reading marker to line after choice
            Search_By_Description (Gift_File);
         when 2 =>
            Search_By_Price (Gift_File);
         when 3 =>
            Search_All (Gift_File);
         when 4 =>
            null;  -- should never get here because of the exit statement
      end case;
      New_Line (3);

   end loop;

   Gift_IO.Close (Gift_File);

end Registry;            