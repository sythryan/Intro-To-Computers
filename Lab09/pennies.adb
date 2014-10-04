with Ada.Text_IO;
with Ada.Float_Text_IO;
procedure Pennies is

   type Dollars is delta 0.01 digits 8;
   package Dollars_IO is new Ada.Text_IO.Decimal_IO (Num => Dollars);

   Three_Pennies : constant Dollars := 0.03;
   Total_Dollars : Dollars;

begin
   Total_Dollars := 0.0;                 -- Initialize the sum
   for Count in 1 .. 100_000 loop
      Total_Dollars := Total_Dollars + Three_Pennies;
   end loop;

   Dollars_IO.Put (Item => Total_Dollars,
                          Fore => 10,
                          Aft  => 2,
                          Exp  => 0);
   Ada.Text_IO.New_Line;

end Pennies;
      