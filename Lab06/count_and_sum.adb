with Ada.Integer_Text_IO;
with Ada.Text_IO;
procedure Count_And_Sum is

   Odd_Num          : Integer;                          -- Number of odd numbers
   Even_Num         : Integer;                          -- Sum of even numbers
   Num              : Integer;                          -- Number entered by user



begin
   Odd_Num  := 0;                                       -- Initialization of odd number count
   Even_Num := 0;                                       -- Initialization of even number sum

   -- Process many odd and even numbers positive numbers
   -- Each iteration, process one number

   Num_Loop :
   loop
      Ada.Text_IO.Put (Item => "Enter a number: ");
      Ada.Integer_Text_IO.Get (Item => Num);
      exit Num_Loop when Num < 1;                        -- Test loop control variable
      if Num rem 2 /= 0 then
         Odd_Num := Odd_Num + 1;                         -- Update odd numbers
      else
         Even_Num := Even_Num + Num;                     -- Update even numbers
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

   