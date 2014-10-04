with Ada.Text_IO;
with Ada.Integer_Text_IO;
procedure Donors is

   -- File of donor amounts
   Donor_File  : Ada.Text_IO.File_Type;
   File_Name   : String (1 .. 80);
   Name_Length : Integer range 0 .. 80;

   Amount : Integer range 0 .. Integer'Last;  -- Amount of one donation
   Total  : Integer range 0 .. Integer'Last;  -- Total of all contributions

   -- Counts of contribution levels
   Donor       : Integer range 0 .. Integer'Last;
   Patron      : Integer range 0 .. Integer'Last;
   Contributor : Integer range 0 .. Integer'Last;
   Supporter   : Integer range 0 .. Integer'Last;
   Director    : Integer range 0 .. Integer'Last;
   Producer    : Integer range 0 .. Integer'Last;

begin
   -- Get the name of the data file
   Ada.Text_IO.Put (Item => "Enter the name of your data file");
   Ada.Text_IO.New_Line;
   Ada.Text_IO.Get_Line (Item => File_Name,
                         Last => Name_Length);


   -- Prepare the data file
   Ada.Text_IO.Open (File => Donor_File,
                     Mode => Ada.Text_IO.In_File,
                     Name => File_Name (1 .. Name_Length));


   -- Initialize total and counts
   Total       := 0;
   Donor       := 0;
   Patron      := 0;
   Contributor := 0;
   Supporter   := 0;
   Director    := 0;
   Producer    := 0;

   -- Categorize the donations and calculate the total
   -- Each iteration, process one donation
   Contribution_Loop :
   loop
      Ada.Integer_Text_IO.Get (File => Donor_File,
                               Item => Amount);
      exit Contribution_Loop when Amount < 1;
      Total := Total + Amount;
      if Amount >= 2000 then
         Producer := Producer + 1;
      elsif Amount >= 1000 then
         Director := Director + 1;
      elsif Amount >= 500 then
         Supporter := Supporter + 1;
      elsif Amount >= 250 then
         Contributor := Contributor + 1;
      elsif Amount >= 125 then
         Patron := Patron + 1;
      elsif Amount >= 50 then
         Donor := Donor + 1;
      end if;
   end loop Contribution_Loop;

   -- Close the input file
   Ada.Text_IO.Close (File => Donor_File);

   -- Display the results

   Ada.Text_IO.New_Line (Spacing => 3);
   Ada.Text_IO.Put (Item => "Donations totaled $");
   Ada.Integer_Text_IO.Put (Item  => Total,
                            Width => 1);
   Ada.Text_IO.New_Line (Spacing => 3);

   Ada.Text_IO.Put (Item => "Number of donations at each level");
   Ada.Text_IO.New_Line (Spacing => 2);

   Ada.Text_IO.Put (Item => "Donor      ");
   Ada.Integer_Text_IO.Put (Item  => Donor,
                            Width => 8);
   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put (Item => "Patron     ");
   Ada.Integer_Text_IO.Put (Item  => Patron,
                            Width => 8);
   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put (Item => "Contributor");
   Ada.Integer_Text_IO.Put (Item  => Contributor,
                            Width => 8);
   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put (Item => "Supporter  ");
   Ada.Integer_Text_IO.Put (Item  => Supporter,
                            Width => 8);
   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put (Item => "Director   ");
   Ada.Integer_Text_IO.Put (Item  => Director,
                            Width => 8);
   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put (Item => "Producer   ");
   Ada.Integer_Text_IO.Put (Item  => Producer,
                            Width => 8);
   Ada.Text_IO.New_Line;

end Donors;