with Ada.Text_IO;
with Ada.Integer_Text_IO;
procedure Assign7 is
-- Written by Syth Ryan
--
-- This program computes the number of starting
-- inventory and ending inventory
--
-- Input
-- Initial inventory amounts
-- Purchase and sales transactions
-- File to write output
--
-- Output
-- Prompts
-- Beginning inventory table
-- Ending inventory table
-- Total sale transactions
-- Total Purchase transactions
--
-- Assumptions
-- The file names entered by the user are valid and the input file exist
-- The data in the input file is valid
-- The sale will never result in a negative inventory value

   -- Max number of characters in file name
   Max : constant Integer := 50;

   -- Types
   type Bar_Type is (Chunky, Skybar, Valomilk, Zagnut);
   type Transaction_Type is (Sale, Purchase, Done);

   -- Instantiate new package for enumerated I/O
   package Bar_IO is new Ada.Text_IO.Enumeration_IO (Enum => Bar_Type);
   package Transaction_IO is new Ada.Text_IO.Enumeration_IO (Enum => Transaction_Type);

-------------------------------------------------------------------------------
   -- Open File
   procedure Open_File (File : out Ada.Text_IO.File_Type) is

      File_Name : String (1 .. Max);        -- Name of the file
      Length    : Integer range 0 .. Max;   -- Number of characters

   begin
      -- Get name
      Ada.Text_IO.Get_Line (Item => File_Name,
                            Last => Length);
      if Length = Max then
         Ada.Text_IO.Skip_Line;
      end if;

      -- Prepare the file
      Ada.Text_IO.Open (File => File,
                        Name => File_Name (1 .. Length),
                        Mode => Ada.Text_IO.In_File);
   end Open_File;
-------------------------------------------------------------------------------
   -- Get initial inventory
   procedure Initial_Inventory (Chunky_Amt   : out Integer;
                                Skybar_Amt   : out Integer;
                                Valomilk_Amt : out Integer;
                                Zagnut_Amt   : out Integer) is

      -- Variables
      Inventory_File : Ada.Text_IO.File_Type;
      Bar            : Bar_Type;                  -- Type of bar
      Amount         : Integer;                   -- Amount of product
      Bar_Count      : Integer;                   -- Loop control variable

   begin

      -- Open file
      Ada.Text_IO.Put ("Enter the file name with this week's beginning inventory: ");
      Open_File (File => Inventory_File);

      -- Initialize counts
      Bar_Count := 1;

      -- Process each of the 4 types of bars
      -- Each iteration, get one bar
      Bar_Loop :
      loop
         exit Bar_Loop when Bar_Count > 4;
         Bar_IO.Get (File => Inventory_File,
                     Item => Bar);
         Ada.Integer_Text_IO.Get (File => Inventory_File,
                                  Item => Amount);
         if Bar  = Chunky then
            Chunky_Amt   := Amount;
         elsif Bar = Skybar then
            Skybar_Amt   := Amount;
         elsif Bar = Valomilk then
            Valomilk_Amt := Amount;
         elsif Bar = Zagnut then
            Zagnut_Amt   := Amount;
         end if;
         Bar_Count := Bar_Count + 1;
      end loop Bar_Loop;

      -- Close the input file
      Ada.Text_IO.Close (File => Inventory_File);

   end Initial_Inventory;
-------------------------------------------------------------------------------
   -- Display initial inventory table
   procedure Display_Inventory (Chunky_Amt   : in Integer;
                                Skybar_Amt   : in Integer;
                                Valomilk_Amt : in Integer;
                                Zagnut_Amt   : in Integer) is

   begin
      Ada.Text_IO.Put_Line ("----------------------------");
      Ada.Text_IO.Put      ("Cases of Chunky:    ");
      Ada.Integer_Text_IO.Put (Chunky_Amt, 8);
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put      ("Cases of Skybar:    ");
      Ada.Integer_Text_IO.Put (Skybar_Amt, 8);
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put      ("Cases of Valomilk:  ");
      Ada.Integer_Text_IO.Put (Valomilk_Amt, 8);
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put      ("Cases of Zagnut:    ");
      Ada.Integer_Text_IO.Put (Zagnut_Amt, 8);
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put_Line ("----------------------------");
   end Display_Inventory;
-------------------------------------------------------------------------------
   -- Process this weeks transactions
   procedure Process_Transactions (Chunky_Amt   : in out Integer;
                                   Skybar_Amt   : in out Integer;
                                   Valomilk_Amt : in out Integer;
                                   Zagnut_Amt   : in out Integer;
                                   Sales        : out Integer;
                                   Purchases    : out Integer) is

      -- Variables
      Transaction_File : Ada.Text_IO.File_Type;           -- Transaction file type
      Transaction      : Transaction_Type;                -- Type of transaction
      Bar              : Bar_Type;                        -- Type of bar
      Amount           : Integer range 1 .. Integer'Last; -- Amount of bars

   begin
      -- Transaction Counters
      Sales     := 0;
      Purchases := 0;

      -- Open File
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put_Line ("Enter the file name with this week's transactions: ");
      Open_File (File => Transaction_File);

      -- Process all types of bars and transactions
      -- Each iteration, get one bar and transaction type
      Transaction_Loop :
      loop
         -- Get transaction type
         Transaction_IO.Get (File => Transaction_File,
                             Item => Transaction);
         exit Transaction_Loop when Transaction = Done;
         -- Get bar and amount
         Bar_IO.Get (File => Transaction_File,
                     Item => Bar);
         Ada.Integer_Text_IO.Get (File => Transaction_File,
                                  Item => Amount);
         -- Update inventory and inctrement counter
         if Transaction = Sale then
            Sales := Sales + 1;
            if Bar = Chunky then
               Chunky_Amt := Chunky_Amt - Amount;
            elsif Bar = Skybar then
               Skybar_Amt := Skybar_Amt - Amount;
            elsif Bar = Valomilk then
               Valomilk_Amt := Valomilk_Amt - Amount;
            elsif Bar = Zagnut then
               Zagnut_Amt := Zagnut_Amt - Amount;
            end if;
         else -- Purchase
            Purchases := Purchases + 1;
            if Bar = Chunky then
               Chunky_Amt := Chunky_Amt + Amount;
            elsif Bar = Skybar then
               Skybar_Amt := Skybar_Amt + Amount;
            elsif Bar = Valomilk then
               Valomilk_Amt := Valomilk_Amt + Amount;
            elsif Bar = Zagnut then
               Zagnut_Amt := Zagnut_Amt + Amount;
            end if;
         end if;

      end loop Transaction_Loop;

      -- Close the input file
      Ada.Text_IO.Close (File => Transaction_File);
   end Process_Transactions;
-------------------------------------------------------------------------------
   -- put file to write the ending inventory
   procedure Out_File (Chunky_Amt    : in Integer;
                       Skybar_Amt    : in Integer;
                       Valomilk_Amt  : in Integer;
                       Zagnut_Amt    : in Integer) is
      -- Variables
      End_Inventory : Ada.Text_IO.File_Type;   -- Holds ending inventory
      Out_Name      : String (1 .. 50);        -- Name of out put file
      Name_Length   : Integer range 0 .. 50;   -- Length of file name
   begin
      -- Get name of file for output
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put_Line ("Enter the name of the file for the ending inventory");
      Ada.Text_IO.Get_Line (Item => Out_Name,
                            Last => Name_Length);
      -- Prepare the file
      Ada.Text_IO.Create (File => End_Inventory,
                          Name => Out_Name (1 .. Name_Length));
      -- Save bar amounts to file
      ----------------------------------------------------------
      Bar_IO.Put (File  => End_Inventory,
                  Item  => Chunky,
                  Width => 10);
      Ada.Integer_Text_IO.Put (File  => End_Inventory,
                               Item  => Chunky_Amt,
                               Width => 8);
      Ada.Text_IO.New_Line (File => End_Inventory);
      ----------------------------------------------------------
      Bar_IO.Put (File  => End_Inventory,
                  Item  => Skybar,
                  Width => 10);
      Ada.Integer_Text_IO.Put (File  => End_Inventory,
                               Item  => Skybar_Amt,
                               Width => 8);
      Ada.Text_IO.New_Line (File => End_Inventory);
      ----------------------------------------------------------
      Bar_IO.Put (File  => End_Inventory,
                  Item  => Valomilk,
                  Width => 10);
      Ada.Integer_Text_IO.Put (File  => End_Inventory,
                               Item  => Valomilk_Amt,
                               Width => 8);
      Ada.Text_IO.New_Line (File => End_Inventory);
      ----------------------------------------------------------
      Bar_IO.Put (File  => End_Inventory,
                  Item  => Zagnut,
                  Width => 10);
      Ada.Integer_Text_IO.Put (File  => End_Inventory,
                               Item  => Zagnut_Amt,
                               Width => 8);
      Ada.Text_IO.New_Line (File => End_Inventory);

   end Out_File;
-------------------------------------------------------------------------------
-- level 0
   -- Variables
   Chunky_Amt   : Integer;   -- Cases of Chunky
   Skybar_Amt   : Integer;   -- Cases of Skybar
   Valomilk_Amt : Integer;   -- Cases of Valomilk
   Zagnut_Amt   : Integer;   -- Cases of Zagnut

   Sales        : Integer;   -- Number of sale transactions
   Purchases    : Integer;   -- Number of purchase transactions
begin
   -- Get initial inventory
   Initial_Inventory    (Chunky_Amt   => Chunky_Amt,
                         Skybar_Amt   => Skybar_Amt,
                         Valomilk_Amt => Valomilk_Amt,
                         Zagnut_Amt   => Zagnut_Amt);
   -- Display initial inventory table
   Ada.Text_IO.New_Line (2);
   Ada.Text_IO.Put_Line ("The starting inventory is");
   Display_Inventory    (Chunky_Amt   => Chunky_Amt,
                         Skybar_Amt   => Skybar_Amt,
                         Valomilk_Amt => Valomilk_Amt,
                         Zagnut_Amt   => Zagnut_Amt);

   -- Process this weeks transactions
   Process_Transactions (Chunky_Amt   => Chunky_Amt,
                         Skybar_Amt   => Skybar_Amt,
                         Valomilk_Amt => Valomilk_Amt,
                         Zagnut_Amt   => Zagnut_Amt,
                         Sales        => Sales,
                         Purchases    => Purchases);
   -- Display ending inventory table
   Ada.Text_IO.New_Line (2);
   Ada.Text_IO.Put_Line ("The ending inventory is");
   Display_Inventory    (Chunky_Amt   => Chunky_Amt,
                         Skybar_Amt   => Skybar_Amt,
                         Valomilk_Amt => Valomilk_Amt,
                         Zagnut_Amt   => Zagnut_Amt);
   Ada.Text_IO.New_Line (2);
   -- Display number of sales and purchases
   Ada.Integer_Text_IO.Put (Item  => Sales,
                            Width => 5);
   Ada.Text_IO.Put_Line (" sales transactions processed");
   Ada.Integer_Text_IO.Put (Item  => Purchases,
                            Width => 5);
   Ada.Text_IO.Put_Line (" purchase transactions processed");

   -- put file to write the ending inventory
   Out_File             (Chunky_Amt   => Chunky_Amt,
                         Skybar_Amt   => Skybar_Amt,
                         Valomilk_Amt => Valomilk_Amt,
                         Zagnut_Amt   => Zagnut_Amt);

end Assign7;
