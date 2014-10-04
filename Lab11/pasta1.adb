with Ada.Text_IO;
with Ada.Direct_IO;
with Ada.Float_Text_IO;
with Ada.IO_Exceptions;
procedure Pasta is

-- This program maintains the warehouse inventory of different pasta varieties

   -- Name of inventory file
   Inventory_File_Name : constant String := "Pasta.Dat";

   -- Type for Description
   type Description_Type is new String (1 .. 20);

   -- Types for sales
   type Num_Sales is new Integer range 1 .. Integer'Last;   -- Number of sales
   type Sales_Total is new Float range 1.0 .. Float'Last;   -- Total amount in pounds sold


   -- Type for the different transactions
   type Transaction_Type is (Sale, Shipment, New_Pasta, Amount, Total, Done);

   -- Types for pasta amounts
   subtype Warehouse_Pounds is Float range 0.0 .. 20_000.0;  -- Ten ton maximum
   subtype Shipping_Pounds  is Float range 1.0 ..  2_000.0;  -- One pound minimum, one ton maximum

   -- Instantiations of I/O Packages
   package  Transaction_IO is new Ada.Text_IO.Enumeration_IO
                                  (Enum => Transaction_Type);

   -- Record
   type Pasta_Rec is
   record
      Description     : Description_Type;
      Amount          : Warehouse_Pounds;
      Number_Of_Sales : Num_Sales;
      Total_Sales     : Sales_Total;
   end record;


   package  Pasta_IO is new Ada.Direct_IO (Element_Type => Warehouse_Pounds);
   use type Pasta_IO.Count;  -- Make operators directly visible
   subtype  Pasta_ID_Type is Pasta_IO.Count;  -- A synonym for clarity

   package Pasta_ID_IO is new Ada.Text_IO.Integer_IO (Num => Pasta_IO.Count);

   ----------------------------------------------------------------------------
   procedure Prepare_File (Pasta_File : out Pasta_IO.File_Type) is

   -- This procedure prepares the direct access file containing
   -- the company's pasta inventory information

   begin
      Pasta_IO.Open (File => Pasta_File,
                     Mode => Pasta_IO.Inout_File,
                     Name => Inventory_File_Name);
   exception
      when Ada.IO_Exceptions.Name_Error =>
         Ada.Text_IO.Put_Line ("Inventory file does not exist");
         Ada.Text_IO.Put_Line ("Creating the inventory file Pasta.Dat");
         Pasta_IO.Create (File => Pasta_File,
                          Mode => Pasta_IO.Inout_File,
                          Name => Inventory_File_Name);
   end Prepare_File;

   ----------------------------------------------------------------------------
   procedure Get_Transaction (Transaction : out Transaction_Type;
                              Pasta_File  : in Pasta_IO.File_Type) is

   -- This procedure asks the user what type of transaction they want to
   -- do and gets it from them.  Handles invalid input.

   begin
      if Pasta_IO.Size (Pasta_File) = 0 then
         Ada.Text_IO.Put_Line ("  No Information on record please use: ");
         Ada.Text_IO.Put_Line ("  New_Pasta - Obtain the number for a new pasta");
         Ada.Text_IO.Put_Line ("  Total     - Total pasta in the inventory");
         Ada.Text_IO.Put_Line ("  Done      - Exit this program");
      else
         Ada.Text_IO.New_Line (2);
         Ada.Text_IO.Put_Line ("The following operations are available:");
         Ada.Text_IO.Put_Line ("  Sale      - Update inventory for a shipment out");
         Ada.Text_IO.Put_Line ("  Shipment  - Update inventory for a shipment in");
         Ada.Text_IO.Put_Line ("  New_Pasta - Obtain the number for a new pasta");
         Ada.Text_IO.Put_Line ("  Amount    - Amount of a pasta in the inventory");
         Ada.Text_IO.Put_Line ("  Total     - Total pasta in the inventory");
         Ada.Text_IO.Put_Line ("  Done      - Exit this program");
         Ada.Text_IO.New_Line;
      end if;
      Input_Loop :  -- Get a transaction from the user
      loop          -- Each iteration, one input value is checked
         Ada.Text_IO.Put ("Enter your choice:   ");
         Transaction_IO.Get (Transaction);
         Validation_Block :  -- To handle invalid input values
         begin
            exit Input_Loop;
         exception
            when Ada.IO_Exceptions.Data_Error =>
               Ada.Text_IO.Skip_Line;  -- Skip over bad data
               Ada.Text_IO.Put_Line ("Invalid choice, please try again.");
         end Validation_Block;
      end loop Input_Loop;
   end Get_Transaction;

   ----------------------------------------------------------------------------
   procedure Get_Pasta_ID
             (Max_Value : in  Pasta_ID_Type;     -- The largest possible ID
              Pasta_ID  : out Pasta_ID_Type) is  -- The ID of the desired pasta

   -- This procedure prompts for and gets a valid pasta identification number.
   -- Handles invalid input.

   begin
      Validation_Loop :   -- Get a valid Pasta ID number
      loop                -- Each iteration, one input value is checked
         Ada.Text_IO.Put ("Enter the Pasta Identification Number:  ");
         Validation_Block :
         begin
            Pasta_ID_IO.Get (Pasta_ID);
            exit Validation_Loop when Pasta_ID > 0 and Pasta_ID <= Max_Value;
            Ada.Text_IO.Put_Line ("Invalid number.");
            Ada.Text_IO.Put ("Pasta number must be between 1 and ");
            Pasta_ID_IO.Put (Item => Max_Value, Width => 1);
            Ada.Text_IO.New_Line;
         exception
            when Ada.IO_Exceptions.Data_Error =>
               Ada.Text_IO.Skip_Line;  -- Skip over bad data
               Ada.Text_IO.Put_Line ("Invalid number.  ");
            when CONSTRAINT_ERROR =>
               Ada.Text_IO.Put_Line ("Invalid number.  ");
               Ada.Text_IO.Put ("Pasta number must be between 1 and ");
               Pasta_ID_IO.Put (Item => Max_Value, Width => 1);
               Ada.Text_IO.New_Line;
         end Validation_Block;
      end loop Validation_Loop;
   end Get_Pasta_ID;

   ----------------------------------------------------------------------------
   procedure Get_Pounds (Amount : out Shipping_Pounds) is

   -- This procedure prompts for and gets a valid weight of a pasta shipment
   -- Handles invalid input.

   begin
      Validation_Loop :  -- Get a valid number of pounds for a truck
      loop               -- Each iteration, one input value is checked
         Ada.Text_IO.Put ("Enter the amount (pounds) of pasta in shipment:  ");
         Validation_Block :
         begin
            Ada.Float_Text_IO.Get (Amount);
            exit Validation_Loop;
         exception
            when Ada.IO_Exceptions.Data_Error =>
               Ada.Text_IO.Skip_Line;  -- Skip over bad data
               Ada.Text_IO.Put_Line ("Data must be numeric.");
            when CONSTRAINT_ERROR =>
               Ada.Text_IO.Put_Line ("Invalid amount.");
               Ada.Text_IO.Put ("Enter a number between ");
               Ada.Float_Text_IO.Put (Item => Shipping_Pounds'First,
                                      Fore => 1, Aft  => 1, Exp  => 0);
               Ada.Text_IO.Put (" and ");
               Ada.Float_Text_IO.Put (Item => Shipping_Pounds'Last,
                                      Fore => 1, Aft  => 1, Exp  => 0);
               Ada.Text_IO.New_Line;
         end Validation_Block;
      end loop Validation_Loop;
   end Get_Pounds;

   ----------------------------------------------------------------------------
   procedure Process_Sale (Pasta_File : in out Pasta_IO.File_Type) is

   -- This procedure gets sales information from the user and subtracts
   -- the amount of pasta sold from the inventory.

      Pasta_Number : Pasta_ID_Type;    -- The pasta identification number
      Amount       : Shipping_Pounds;  -- The amount of pasta sold and shipped
      Total        : Warehouse_Pounds; -- The total amount in inventory

   begin
      -- Get a valid Pasta ID number from the user
      -- The maximum legal value of a pasta ID number is the last index
      -- in the direct file of pasta weights
      Get_Pasta_ID (Max_Value => Pasta_IO.Size (Pasta_File),
                    Pasta_ID  => Pasta_Number);
      -- Get a valid amount from the user
      Get_Pounds (Amount);

      -- Update the inventory

      -- Get the total amount in inventory
      Pasta_IO.Read (File => Pasta_File,
                     Item => Total,
                     From => Pasta_Number);
      -- Calculate the new total
      Total := Total - Amount;
      -- Put the new total back in the inventory file
      Pasta_IO.Write (File => Pasta_File,
                      Item => Total,
                      To   => Pasta_Number);
   exception
      when CONSTRAINT_ERROR =>   -- Negative total
         Ada.Text_IO.Put_Line ("Not enough Pasta in stock for this sale!");
   end Process_Sale;

   ----------------------------------------------------------------------------
   procedure Process_Shipment (Pasta_File : in out Pasta_IO.File_Type) is

   -- This procedure gets factory production information from the user
   -- and adds it to the inventory

      Pasta_Number : Pasta_ID_Type;    -- The pasta identification number
      Amount       : Shipping_Pounds;  -- The amount of pasta sold and shipped
      Total        : Warehouse_Pounds; -- The total amount in inventory

   begin  -- Process Shipment
      -- Get the necessary data from the user
      -- The maximum legal value of a pasta ID number is the last index
      Get_Pasta_ID (Max_Value => Pasta_IO.Size (Pasta_File),
                    Pasta_ID  => Pasta_Number);
      -- Get a valid amount from the user
      Get_Pounds (Amount);

      -- Update the inventory

      -- Get the total amount in inventory
      Pasta_IO.Read (File => Pasta_File,
                     Item => Total,
                     From => Pasta_Number);

      -- Calculate the new total
      Total := Total + Amount;
      -- Put the new total back in the inventory file
      Pasta_IO.Write (File => Pasta_File,
                      Item => Total,
                      To   => Pasta_Number);
   exception
      when CONSTRAINT_ERROR =>   -- Inventory exceeded Warehouse_Weight'Last
         Ada.Text_IO.Put_Line ("Not enough room in warehouse for shipment!");
   end Process_Shipment;

   ----------------------------------------------------------------------------
   procedure Process_New (Pasta_File : in out Pasta_IO.File_Type) is

   -- This procedure determines and displays a unique identification
   -- number for a new pasta variety.  It also initializes the inventory
   -- of that variety to zero.

      New_Pasta_Num : Pasta_ID_Type;  -- The ID number for the new variety

   begin
      -- The ID of the new pasta is one greater than
      -- the size of the inventory file
      New_Pasta_Num := Pasta_IO.Size (Pasta_File) + 1;
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put ("The number assigned to the new pasta variety is ");
      Pasta_ID_IO.Put (Item => New_Pasta_Num,  Width => 1);

      -- Initialize the new pasta's inventory to zero
      Pasta_IO.Write (File => Pasta_File,
                      Item => 0.0,
                      To   => New_Pasta_Num);
   end Process_New;

   ----------------------------------------------------------------------------
   procedure Process_Amount_Query (Pasta_File : in Pasta_IO.File_Type) is

   -- This procedure displays the amount of a particular pasta in stock

      Pasta_Number : Pasta_ID_Type;    -- The pasta identification number
      Total        : Warehouse_Pounds; -- The total amount in inventory

   begin
      -- Get the necessary data from the user
      -- The maximum legal value of a pasta ID number is the last index
      Get_Pasta_ID (Max_Value => Pasta_IO.Size (Pasta_File),
                    Pasta_ID  => Pasta_Number);

      -- Get the total amount in inventory
      Pasta_IO.Read (File => Pasta_File,
                     Item => Total,
                     From => Pasta_Number);

      -- Display the total
      Ada.Text_IO.Put ("The amount of that pasta in stock is ");
      Ada.Float_Text_IO.Put (Item => Total, Fore => 1, Aft  => 1, Exp  => 0);
      Ada.Text_IO.Put_Line (" pounds.");
   end Process_Amount_Query;

   ---------------------------------------------------------------
   procedure Process_Total_Query (Pasta_File : in Pasta_IO.File_Type) is

   -- This procedure determines and displays the total amount of
   -- pasta in the warehouse

      Total  : Float;              -- The total amount of pasta in stock
      Amount : Warehouse_Pounds;   -- The amount of one pasta in stock

   begin
      Total := 0.0;                            -- Initialize sum
      Pasta_IO.Set_Index (File => Pasta_File,  -- Initialize file index
                          To   => 1);

      Sum_Loop :   -- Each iteration, one pasta variety amount is read and
      loop         -- added to the total
         exit Sum_Loop when Pasta_IO.End_Of_File (Pasta_File);
         Pasta_IO.Read (File => Pasta_File,  Item => Amount);
         Total := Total + Amount;
      end loop Sum_Loop;

      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put ("Total amount of pasta in the warehouse is ");
      Ada.Float_Text_IO.Put (Item => Total, Fore => 1, Aft  => 1, Exp  => 0);
      Ada.Text_IO.Put_Line (" pounds.");
   end Process_Total_Query;

   ----------------------------------------------------------------------------
   procedure Process_Transaction
         (Which_Transaction : in     Transaction_Type;      -- Which kind
          Inventory_File    : in out Pasta_IO.File_Type) is -- Inventory file
   -- This procedure carries out the appropriate actions
   -- for the given type of transaction.

   begin
      case Which_Transaction is
         when Sale =>
            Process_Sale (Inventory_File);
         when Shipment =>
            Process_Shipment (Inventory_File);
         when New_Pasta =>
            Process_New (Inventory_File);
         when Amount =>
            Process_Amount_Query (Inventory_File);
         when Total =>
            Process_Total_Query (Inventory_File);
         when Done =>
            null;
      end case;
   end Process_Transaction;

-------------------------------------------------------------------------------

   Transaction : Transaction_Type;    -- Type of transaction being processed
   Pasta_File  : Pasta_IO.File_Type;  -- Pasta inventory totals

begin  -- Program Pasta
   Prepare_File (Pasta_File);

   Transaction_Loop :  -- Process all of the user's transactions
   loop                -- Each iteration, one transaction is processed
      Get_Transaction (Transaction, Pasta_File);
      exit Transaction_Loop when Transaction = Done;
      Process_Transaction (Which_Transaction => Transaction,
                           Inventory_File    => Pasta_File);
   end loop Transaction_Loop;
   -- Close the file
   Pasta_IO.Close (Pasta_File);
exception
   when others =>                   -- If any exception is not handled where
      Pasta_IO.Close (Pasta_File);  -- it occurs, close the file and propagate
      raise;                        -- the exception back to the system.
end Pasta;