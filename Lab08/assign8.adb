with Ada.Text_IO;
with Ada.Float_Text_IO;
with Ada.Integer_Text_IO;
procedure Assign8 is
-- Written by Syth Ryan
--
-- This program computes the grade of
-- of many grapefruit's
--
-- Input:
-- Information on grapefruits, one grapefruit per line
--
-- Output:
-- Prompts
-- Table of the classification results
-- Graph of the classification results
--
-- Assumptions
--

   type Grade_Type is (A, B, C, R);   -- Grades of Grape Fruit
   package Grade_IO is new Ada.Text_IO.Enumeration_IO (Enum => Grade_Type);


   Inches  : Float;          -- Diameter
   Grade   : Grade_Type;     -- Grade
   A_Count : Natural;        -- Grade A total
   B_Count : Natural;        -- Grade B total
   C_Count : Natural;        -- Grade C Total
   R_Count : Natural;        -- Rejected Total

-------------------------------------------------------------------------------
      procedure Display_One_Line (Count   : in Natural;
                                  A_Count : in Natural;
                                  B_Count : in Natural;
                                  C_Count : in Natural;
                                  R_Count : in Natural;
                                  X_Val   : in Float) is

         Num_Chars : Natural; -- number of x's in the line
         Num_Count : Natural; -- count control variable

      begin

         if Count = 1 then                  -- Determine what line to write for
            Num_Chars := A_Count / Integer (X_Val);
         elsif Count = 2 then
            Num_Chars := B_Count / Integer (X_Val);
         elsif Count = 3 then
            Num_Chars := C_Count / Integer (X_Val);
         else
            Num_Chars := R_Count / Integer (X_Val);
         end if;

         Num_Count := 0;

         -- Process a line of characters
         -- Each iteration, process one character
         Char_Loop :
         loop
            exit Char_Loop when Num_Count = Num_Chars;
            Ada.Text_IO.Put (Item => 'X');
            Num_Count := Num_Count + 1;
         end loop Char_Loop;
      end Display_One_Line;

-------------------------------------------------------------------------------
   -- Display Graph
   procedure Graph (A_Count : in Natural;
                    B_Count : in Natural;
                    C_Count : in Natural;
                    R_Count : in Natural) is

      Count     : Natural;     -- to determine line for display one line
      Max_X     : Float;      -- Max Number of x's
      Max_Total : Natural;    -- Max of the count totals
      Grade_Val : Grade_Type; -- Grade to graph
      X_Val     : Float;


   begin



      Ada.Text_IO.New_Line (4);

      -- Calculate the x's
      Max_Total := Integer'Max ((Integer'Max (A_Count, B_Count)), (Integer'Max (C_Count, R_Count)));

      if Max_Total = 0 then
         Max_Total := 1;
      end if;

      Max_X := Float (Max_Total) / 20.0;
      X_Val := Float'Ceiling (Max_X);

      Grade_Val := A;
      Count := 1;

      Ada.Text_IO.Put ("Grapefruit Classification Results (Each X represents ");
      Ada.Integer_Text_IO.Put (Integer (X_Val), 1);
      Ada.Text_IO.Put (" grapefruits)");
      Ada.Text_IO.New_Line (2);

      Graph_Loop :
      for Grade in A .. R loop
         Grade_IO.Put (Grade_Val);
         Ada.Text_IO.Put ("   ");
         -- Display one line
         Display_One_Line (A_Count => A_Count,
                           B_Count => B_Count,
                           C_Count => C_Count,
                           R_Count => R_Count,
                           Count   => Count,
                           X_Val   => X_Val);

         Ada.Text_IO.New_Line;
         if Grade = R then
            null;
         else
            Grade_Val := Grade_Type'Succ (Grade_Val);
         end if;
         Count := Count + 1;
      end loop Graph_Loop;
   end Graph;


-------------------------------------------------------------------------------
   -- Display table
   procedure Total_Table (A_Count : in Natural;
                          B_Count : in Natural;
                          C_Count : in Natural;
                          R_Count : in Natural) is
   begin
      Ada.Text_IO.New_Line (2);
      Ada.Text_IO.Put ("Grapefruit Classification Totals");
      Ada.Text_IO.New_Line (2);
      Ada.Text_IO.Put ("Grade");
      Ada.Text_IO.Put ("      ");
      Ada.Text_IO.Put ("Total");
      Ada.Text_IO.New_Line (2);
      Grade_IO.Put (A);
      Ada.Text_IO.Put ("              ");
      Ada.Integer_Text_IO.Put (A_Count, 1);
      Ada.Text_IO.New_Line;
      Grade_IO.Put (B);
      Ada.Text_IO.Put ("              ");
      Ada.Integer_Text_IO.Put (B_Count, 1);
      Ada.Text_IO.New_Line;
      Grade_IO.Put (C);
      Ada.Text_IO.Put ("              ");
      Ada.Integer_Text_IO.Put (C_Count, 1);
      Ada.Text_IO.New_Line;
      Grade_IO.Put (R);
      Ada.Text_IO.Put ("              ");
      Ada.Integer_Text_IO.Put (R_Count, 1);
      Ada.Text_IO.New_Line;
   end Total_Table;
-------------------------------------------------------------------------------
   -- Add grade totals
   procedure Totals (Grade   : in Grade_Type;
                     A_Count : in out Natural;
                     B_Count : in out Natural;
                     C_Count : in out Natural;
                     R_Count : in out Natural) is
   begin
      if Grade = A then
         A_Count := A_Count + 1;
      elsif Grade = B then
         B_Count := B_Count + 1;
      elsif Grade = C then
         C_Count := C_Count + 1;
      else
         R_Count := R_Count + 1;
      end if;
   end Totals;
-------------------------------------------------------------------------------
   -- Modify the grade based on condition.
   procedure Modify (Grade : in out Grade_Type) is

      type Condition_Type is (Excellent, Good, Fair, Poor);  -- Condition of Grape Fruit
      package Condition_IO is new Ada.Text_IO.Enumeration_IO (Enum => Condition_Type);

      Condition : Condition_Type;   -- Condition

   begin
      Condition_IO.Get (Condition);
      if Condition = Excellent then
         null;                     -- no change in condition
      elsif Condition = Good then
         Grade := Grade_Type'Succ (Grade);
      elsif Condition = Fair then
         if Grade = C then
            Grade := Grade_Type'Last;
         else
            Grade := Grade_Type'Succ (Grade);
            Grade := Grade_Type'Succ (Grade);
         end if;
      else
         if Grade = B or Grade = C then
            Grade := Grade_Type'Last;
         else
            Grade := Grade_Type'Succ (Grade);
            Grade := Grade_Type'Succ (Grade);
            Grade := Grade_Type'Succ (Grade);
         end if;
      end if;
   end Modify;

-------------------------------------------------------------------------------
   -- Determine initial grade.
   procedure Determine (Grade : out Grade_Type) is

   begin
      Ada.Float_Text_IO.Get (Inches);
      if Inches >= 4.0 then
         Grade := A;
      elsif Inches < 4.0 and Inches >= 3.5 then
         Grade := B;
      else
         Grade := C;
      end if;
   end Determine;
-------------------------------------------------------------------------------
-- Main program
begin

   A_Count := 0;
   B_Count := 0;
   C_Count := 0;
   R_Count := 0;

   Ada.Text_IO.Put ("Enter grapefruit information");
   Ada.Text_IO.New_Line;

   -- Process many grapefruit's
   -- Each iteration, process one grapfruit
   Fruit_Loop :
   loop
      -- Determine initial grade.
      Determine (Grade => Grade);
      exit Fruit_Loop when Inches <= 0.0;
      -- Modify the grade based on condition.
      Modify (Grade => Grade);
      -- Add Grade totals
      Totals (Grade   => Grade,
              A_Count => A_Count,
              B_Count => B_Count,
              C_Count => C_Count,
              R_Count => R_Count);
   end loop Fruit_Loop;

   -- Display table
   Total_Table (A_Count => A_Count,
                B_Count => B_Count,
                C_Count => C_Count,
                R_Count => R_Count);

   -- Display Graph
   Graph (A_Count => A_Count,
          B_Count => B_Count,
          C_Count => C_Count,
          R_Count => R_Count);
end Assign8;