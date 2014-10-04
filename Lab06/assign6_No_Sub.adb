with Ada.Text_IO;
with Ada.Float_Text_IO;
with Ada.Integer_Text_IO;
with Ada.Characters;
procedure Assign6 is
-- Written by Syth Ryan
--
-- This program computes the two roots of many quadratic equations
--
-- Input
-- Values of a, b, and c
-- Approximate the square root
-- Calculate the 2 outcomes
-- Ask for repeat
--
-- Output
-- Display the roots
-- Display the values of a, b, and c
-- Display number of imaginary and real roots
--
-- Assumptions
-- All data entered is valid

   -- Variables
   Answer      : Character;   -- Answer to repeat question

   A           : Float;      -- Value of A
   B           : Float;      -- Value of B
   C           : Float;      -- Value of C

   Imaginary   : Integer;    -- Count of imaginary results
   Real        : Integer;    -- Count of real roots results

   Sqrt_Num    : Float;      -- Number to square root
   Sqrt_In     : Float;      -- Current approximation
   Sqrt_Out    : Float;      -- Final approximation
   Root_1      : Float;      -- (+) outcome
   Root_2      : Float;      -- (-) outcome


begin

   Root_1    := 0.0;
   Root_2    := 0.0;
   Imaginary := 0;
   Real      := 0;
   -- Process many sets of values
   -- Each iteration, process one value
   Repeat_Loop :
   loop


      -- Get Values for a, b, and c
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

-------------------------------------------------------------------------------
      -- Approximate the square root
      Sqrt_Num := B ** 2 - 4.0 * A * C;          -- Number to Square root
      Sqrt_In  := (B ** 2 - 4.0 * A * C) / 2.0;  -- Initial Approximation

         if B ** 2 - 4.0 * A * C < 0.0 then
            Ada.Text_IO.Put (Item => "The roots are Imaginary.");
            Ada.Text_IO.New_Line;
            Imaginary := Imaginary + 1;
         else
            Real := Real + 1;
            -- Compute an approximation of the root
            -- Each iteration, calculate a more precise approximation
            Sqrt_Loop :
            loop
               Sqrt_Out := (Sqrt_In + Sqrt_Num / Sqrt_In) / 2.0;         -- New approximation
               exit Sqrt_Loop when abs (Sqrt_Out - Sqrt_In) < 0.00001;   -- exit when close
               Sqrt_In := Sqrt_Out;
            end loop Sqrt_Loop;


-------------------------------------------------------------------------------
            -- Calculate the 2 outcomes
            Root_1 := (-1.0 * B + Sqrt_In) / (2.0 * A);
            Root_2 := (-1.0 * B - Sqrt_In) / (2.0 * A);

-------------------------------------------------------------------------------
            Ada.Text_IO.Put       (Item => "Value of a: ");          -- Display the values of a, b, and c
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
            Ada.Text_IO.New_Line;
            Ada.Text_IO.Put       (Item => "The Roots are: ");       -- Display the roots
            Ada.Float_Text_IO.Put (Item => Root_1,
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 2);
            Ada.Text_IO.Put       (Item => ", ");
            Ada.Float_Text_IO.Put (Item => Root_2,
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 2);
            Ada.Text_IO.New_Line  (Spacing => 2);
         end if;

-------------------------------------------------------------------------------
         -- Ask for repeat
         Ada.Text_IO.Put (Item => "Would you like to solve another? Enter Y for yes or N for no: ");
         Ada.Text_IO.Get (Item => Answer);
         exit Repeat_Loop when Answer = 'N' or Answer = 'n';
         Ada.Text_IO.New_Line;
   end loop Repeat_Loop;

-------------------------------------------------------------------------------
   -- Display number of imaginary and real roots
   Ada.Text_IO.Put (Item => "Number of imaginary roots: ");
   Ada.Integer_Text_IO.Put (Item => Imaginary,
                           Width => 1);
   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put (Item => "Number of real roots solved: ");
   Ada.Integer_Text_IO.Put (Item => Real,
                           Width => 1);
end Assign6;

         