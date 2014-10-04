with Ada.Integer_Text_IO;
with Ada.Text_IO;
procedure Count_And_Sum is

   N                : Integer range 0 .. Integer'Last;  -- The number of integers to process
   Num              : Integer;                          -- Number entered by user
   Odd_Num          : Integer;                          -- Number of odd numbers
   Even_Num         : Integer;                          -- Sum of even numbers




begin
   Odd_Num  := 0;                                       -- Initialization of odd number count
   Even_Num := 0;                                       -- Initialization of even number sum

   Ada.Text_IO.Put (Item => "Enter N and then N integers");
   Ada.Text_IO.New_Line;
   Ada.Integer_Text_IO.Get (Item => N);                 -- Loop control variable initialization

   -- Process many odd and even numbers
   -- Each iteration, process one number

   Num_Loop :
   loop
      exit Num_Loop when N = 0;                           -- Test loop control variable
         Ada.Text_IO.Put (Item => "Enter a number: ");
         Ada.Integer_Text_IO.Get (Item => Num);
         N := N - 1;                                      -- Update loop control variable
         if Num rem 2 /= 0 then
            Odd_Num := Odd_Num + 1;
         else
            Even_Num := Even_Num + Num;
         end if;
   end loop Num_Loop;

   -- Display the results
   Ada.Text_IO.New_Line (Spacing => 2);
   Ada.Text_IO.Put (Item => "The number of odd numbers is ");
   Ada.Integer_Text_IO.Put (Item => Odd_Num,
                            Width => 1);
   Ada.Text_IO.New_Line (Spacing => 2);
   Ada.Text_IO.Put (Item => "The sum of the even numbers is ");
   Ada.Integer_Text_IO.Put (Item => Even_Num,
                            Width => 1);
   Ada.Text_IO.New_Line (Spacing => 2);
   Ada.Text_IO.Put (Item => "All done");
end Count_And_Sum;

   