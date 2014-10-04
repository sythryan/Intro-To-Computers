with Ada.Text_IO;
with Ada.Float_Text_IO;

procedure Exercise_3 is

   -- Programming Assignment One
   --
   --
   -- A program to calculate credit balances

   -- Constants
   Debt          : constant Float := 300.00;
   Payment       : constant Float := 22.40;
   Interest_Rate : constant Float := 0.02;

   -- Variables
   Charge    : Float;
   Reduction : Float;
   Remaining : Float;

begin -- Exercise 3
   Charge    := Interest_Rate * Debt;
   Reduction := Payment - Charge;
   Remaining := Debt - Reduction;
   Ada.Text_IO.Put (Item => "Payment ");
   Ada.Float_Text_IO.Put (Item => Payment,
                          Fore => 1,
                          Aft  => 2,
                          Exp  => 0);
   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put (Item => "Charge ");
   Ada.Float_Text_IO.Put (Item => Charge,
                          Fore => 1,
                          Aft  => 2,
                          Exp  => 0);
   Ada.Text_IO.New_Line;
   Ada.Text_IO.Put (Item => "Balance owed ");
   Ada.Float_Text_IO.Put (Item => Remaining,
                          Fore => 1,
                          Ayt  => 2,
                          Exp  => 0);
   Ada.Text_IO.New_Line;

end Exercise_3;



