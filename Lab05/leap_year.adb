with Ada.Text_IO;
with Ada.Integer_Text_IO;
procedure Leap_Year is

   Year : Integer range 0 .. Integer'Last;

begin

   Ada.Text_IO.Put (Item => "Enter a year greater than 1752:  ");
   Ada.Integer_Text_IO.Get (Item => Year);
   Ada.Text_IO.New_Line (Spacing => 2);

   if Year < 1753 then
      Ada.Text_IO.Put (Item => "Year not greater than 1752.");
   else
      Ada.Text_IO.Put (Item => "The year ");
      Ada.Integer_Text_IO.Put (Item  => Year,
                            Width => 1);

      if Year rem 400 = 0 or (Year rem 100 /= 0 and Year rem 4 = 0) then
         Ada.Text_IO.Put (Item => " is a leap year.");
      else
         Ada.Text_IO.Put (Item => " is not a leap year.");
      end if;
   end if;




   Ada.Text_IO.New_Line;
end Leap_Year;