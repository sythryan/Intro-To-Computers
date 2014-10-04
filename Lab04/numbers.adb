with Ada.Integer_Text_IO;
with Ada.Text_IO;
procedure Numbers is

   -- Three whole numbers used in if statement practice exercises
   A : Integer;
   B : Integer;
   C : Integer;

begin
   -- Prompt for and get three whole numbers
   Ada.Text_IO.Put (Item => "Enter three whole numbers");
   Ada.Text_IO.New_Line;
   Ada.Integer_Text_IO.Get (Item => A);
   Ada.Integer_Text_IO.Get (Item => B);
   Ada.Integer_Text_IO.Get (Item => C);
   Ada.Text_IO.New_Line (Spacing => 3);

   if A = B and B = C then
      Ada.Text_IO.Put (Item => "All numbers are equal.");
      Ada.Text_IO.New_Line;
   elsif A = C or B = C or A = B then
      Ada.Text_IO.Put (Item => "Two numbers are equal.");
      Ada.Text_IO.New_Line;
   else
      Ada.Text_IO.Put (Item => "All numbers are unique.");
   end if;

      Ada.Text_IO.Put (Item => "All done!");
      Ada.Text_IO.New_Line;
end Numbers;  