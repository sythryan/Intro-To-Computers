with Ada.Integer_Text_IO;
with Ada.Text_IO;
procedure Counting is

   Start  : Integer;
   Finish : Integer;
   Count  : Integer;  -- Loop control variable
   Count_Number : Integer;
begin

   -- Get the data

   Ada.Text_IO.Put (Item => "Start? ");
   Ada.Integer_Text_IO.Get (Item => Start);

   Ada.Text_IO.Put (Item => "Finish? ");
   Ada.Integer_Text_IO.Get (Item => Finish);

   Ada.Text_IO.Put (Item => "Count by? ");
   Ada.Integer_Text_IO.Get (Item => Count_Number);
   Ada.Text_IO.New_Line (Spacing => 4);

   -- Display the results

   Ada.Text_IO.Put (Item => "Counting by ");
   Ada.Integer_Text_IO.Put (Item => Count_Number,
                            Width => 1);
   Ada.Text_IO.Put (Item => "'s, the numbers from ");
   Ada.Integer_Text_IO.Put (Item => Start,
                            Width => 1);
   Ada.Text_IO.Put (Item => " to ");
   Ada.Integer_Text_IO.Put (Item => Finish,
                            Width => 1);
   Ada.Text_IO.Put (Item => " are:");
   Ada.Text_IO.New_Line (Spacing => 2);

   Count := Start;
   Exercise_Loop :
   loop
      exit Exercise_Loop when Count > Finish;
      Ada.Integer_Text_IO.Put (Item => Count);
      Count := Count + Count_Number;
      Ada.Text_IO.New_Line;
   end loop Exercise_Loop;






   Ada.Text_IO.New_Line (Spacing => 2);
   Ada.Text_IO.Put (Item => "All done");
end Counting;

   