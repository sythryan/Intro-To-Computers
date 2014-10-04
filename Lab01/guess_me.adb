with JEWL.IO;   use JEWL.IO;
with Ada.Numerics.Discrete_Random;
procedure Guess_Me is

   ---------------------------------------------------------------------------
   --   Copyright John English 2000. Contact address: je@brighton.ac.uk
   --   This software is released under the terms of the GNU General Public
   --   License and is intended primarily for educational use.
   ---------------------------------------------------------------------------

   type   Number_Type is range 1 .. 1000;
   package Number_IO   is new Integer_IO (Number_Type);
   use Number_IO;

   package Random_Numbers is new Ada.Numerics.Discrete_Random (Number_Type);
   use Random_Numbers;

   My_Generator : Random_Numbers.Generator;

   Secret : Number_Type;
   Guess  : Number_Type;

begin

   Reset (My_Generator);
   Secret := Random (My_Generator);

   Message ("You have 10 attempts to fine the secret number between 1 and 1000!");

   for Count in 1 .. 10 loop
      Get (Guess, "Attempt " & Count & ": Enter a number between 1 and 1000:");
      exit when Guess = Secret;
      if Guess < Secret then
         Message ("Too low! Try again!");
      else
         Message ("Too high! Try again!");
      end if;
   end loop;
   if Guess = Secret then
      Message ("congratulations! The secret number was " & Secret & "!");
   else
      Message ("Bad luck! The secret number was " & Secret & "!");
   end if;

exception

   when Input_Cancelled =>
      Message ("You gave up! The secret number was " & Secret &"!");

end Guess_Me;


