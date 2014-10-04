with Ada.Text_IO;
with Ada.Float_Text_IO;
with Ada.Characters;
with Ada.Integer_Text_IO;
procedure Assign6 is
-- Written by Syth Ryan
--
-- This program computes the two roots of many quadratic equations
--
-- Input
-- Prompt and get values
-- Test if imaginary
-- Compute roots
-- Ask to do another (exit statement)
--
-- Output
-- Display roots
-- Display values entered
-- Display number of real
-- Display number of imaginary
--
-- Assumptions
-- All equations are quadratic (A never equals 0)
-- All data entered is valid


   -- Variables
   A         : Float;     -- Value of a
   B         : Float;     -- Value of b
   C         : Float;     -- Value of c
   Root_1    : Float;     -- (+) outcome
   Root_2    : Float;     -- (-) outcome
   Answer    : Character; -- Answer to repeat
   Imaginary : Integer;   -- Count of imaginary outcomes
   Real      : Integer;   -- Count of real outcomes

-------------------------------------------------------------------------------
   -- Level 1
   -- Compute roots
   procedure Compute_Roots (A       : in Float;
                            B       : in Float;
                            C       : in Float;
                            Root_1  : out Float;
                            Root_2  : out Float;
                            Real    : in out Integer) is
      -- Variables
      Sqrt_In     : Float;      -- Current approximation
      Sqrt_Num    : Float;      -- Number to square root
      Sqrt_Out    : Float;      -- Final approximation

   begin

      Sqrt_Num  := B ** 2 - 4.0 * A * C;          -- Number to Square root
      Sqrt_In   := (B ** 2 - 4.0 * A * C) / 2.0;  -- Initial Approximation
      Root_1    := 0.0;
      Root_2    := 0.0;

      -- Compute an approximation of the root
      -- Each iteration, calculate a more precise approximation
      Sqrt_Loop :
      loop
         Sqrt_Out := (Sqrt_In + Sqrt_Num / Sqrt_In) / 2.0;         -- New approximation
         exit Sqrt_Loop when (Sqrt_Out - Sqrt_In) <= 0.00001;   -- exit when close
         Sqrt_In := Sqrt_Out;
      end loop Sqrt_Loop;

      Root_1 := (-1.0 * B + Sqrt_In) / (2.0 * A);
      Root_2 := (-1.0 * B - Sqrt_In) / (2.0 * A);
      Real   := Real + 1;
   end Compute_Roots;

-------------------------------------------------------------------------------

-- Level 0
-- Main program
begin

   Imaginary := 0;
   Real      := 0;

   -- Process many sets of values
   -- Each iteration, process one set of values
   Repeat_Loop :
   loop
      -- Prompt and get values
      Ada.Text_IO.Put       (Item => "Please enter the values of a, b, c in ax^2+bx+c=0");
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put       (Item => "Value of a: ");
      Ada.Float_Text_IO.Get (Item => A);
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put       (Item => "Value of b: ");
      Ada.Float_Text_IO.Get (Item => B);
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put       (Item => "Value of c: ");
      Ada.Float_Text_IO.Get (Item => C);
      Ada.Text_IO.New_Line  (Spacing => 2);

      -- Test if imaginary
      if B ** 2 - 4.0 * A * C < 0.0 then
         Ada.Text_IO.Put (Item => "The roots are Imaginary.");
         Ada.Text_IO.New_Line;
         Imaginary := Imaginary + 1;
      else
         -- Compute roots
         Compute_Roots (A       => A,
                        B       => B,
                        C       => C,
                        Root_2  => Root_2,
                        Root_1  => Root_1,
                        Real    => Real);
         -- Display roots
         Ada.Text_IO.Put (Item => "The Roots are: ");
         Ada.Float_Text_IO.Put (Item => Root_1,
                                Fore => 1,
                                Aft  => 6,
                                Exp  => 1);
         Ada.Text_IO.Put (Item => ", ");
         Ada.Float_Text_IO.Put (Item => Root_2,
                                Fore => 1,
                                Aft  => 6,
                                Exp  => 1);
         Ada.Text_IO.New_Line;
      end if;

      -- Display values entered
      Ada.Text_IO.Put       (Item => "Value of a: ");
      Ada.Float_Text_IO.Put (Item => A,
                             Fore => 2,
                             Aft  => 1,
                             Exp  => 0);
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put       (Item => "Value of b: ");
      Ada.Float_Text_IO.Put (Item => B,
                             Fore => 2,
                             Aft  => 1,
                             Exp  => 0);
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put       (Item => "Value of c: ");
      Ada.Float_Text_IO.Put (Item => C,
                             Fore => 2,
                             Aft  => 1,
                             Exp  => 0);
      Ada.Text_IO.New_Line (Spacing => 2);

      -- Ask to do another (exit statement)
      Ada.Text_IO.Put (Item => "Would you like to solve another? Enter Y for yes or N for no: ");
      Ada.Text_IO.Get (Item => Answer);
      exit Repeat_Loop when Answer = 'N' or Answer = 'n';
      Ada.Text_IO.New_Line;

   end loop Repeat_Loop;

   -- Display number of real
   Ada.Text_IO.Put (Item => "Number of real roots: ");
   Ada.Integer_Text_IO.Put (Item => Real,
                           Width => 1);
   Ada.Text_IO.New_Line;

   -- Display number of imaginary
   Ada.Text_IO.Put (Item => "Number of imaginary roots: ");
   Ada.Integer_Text_IO.Put (Item => Imaginary,
                           Width => 1);
end Assign6;
