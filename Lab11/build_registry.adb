with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Sequential_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
procedure Build_Registry is

   -- This program creates a gift registry
   --
   -- Input
   --   Last name (used for registry file name)
   --   Gift information
   --
   --  Output
   --    Prompts
   --    Binary file of gift information
   --
   --  Assumptions
   --     No gift discription contains more than 25 characters
   --     No blanks or special characters in the last name


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

-------------------------------------------------------------------------------

   File_Name : File_String;    -- The file name and
   Length    : Natural;        -- its length

   Gift      : Gift_Rec;            -- One gift;
   Gift_File : Gift_IO.File_Type;   -- A file of gifts

   Count : Natural := 0;       -- Number of gifts entered

begin
   -- Create the gift registry file

   Put_Line ("Enter your last name");
   Get_Line (Item => File_Name,
             Last => Length);
   Gift_IO.Create (File => Gift_File,
                   Mode => Gift_IO.Out_File,
                   Name => File_Name (1 .. Length));

   New_Line (2);
   Put_Line ("Now enter all the gifts for your registry");
   Put_Line ("To end, press return when prompted for a gift description");
   New_Line;

   -- Get the gifts for the registry
   -- Each iteration, put one gift into the registry
   loop
      Put_Line ("Enter a gift description");
      Get_Line (Item => Gift.Description.Item,
                Last => Gift.Description.Last);

      exit when Gift.Description.Last = 0;

      New_Line;
      Put_Line ("About how much does this gift cost?");
      Dollar_IO.Get (Gift.Price);

      New_Line;
      Put_Line ("How many of these gifts would you like");
      Get (Gift.Quantity);
      Ada.Text_IO.Skip_Line;

      Gift.Purchased := 0;  -- None yet selected for purchase

      Gift_IO.Write (File => Gift_File,
                     Item => Gift);

      New_Line (2);
      Count := Count + 1;

   end loop;

   Gift_IO.Close (Gift_File);
   New_Line (2);
   Put_Line ("You have" & Integer'Image (Count) & " gifts in your registry");

end Build_Registry;
             