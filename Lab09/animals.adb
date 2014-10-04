with Ada.Text_IO;
procedure Animals is

   -- Some different names of animals
   type Animal_Type is (Mouse, Squirrel, Rat, Cow, Pig, Chicken, Puma, Lion, Tiger, Monkey);

   -- Create a package of I/O operations for the animals
   package Animal_IO is new Ada.Text_IO.Enumeration_IO (Enum => Animal_Type);

   -- Variable
   My_Choice : Animal_Type;  -- Animal entered by user

begin
   -- Prompt for an animal
   Ada.Text_IO.Put_Line ("Enter one of the following animal names");

   -- Display the list of legal animals
   -- Each iteration, display one animal name
   For_Loop :
   for Animal_Type in Animal_Type loop
      Animal_IO.Put (Animal_Type);
      Ada.Text_IO.Put (" ");

   end loop For_Loop;


   Ada.Text_IO.New_Line;

   -- Get an animal from the user
   Animal_IO.Get (Item => My_Choice);

   -- Display which group of animals the choice is in
   case My_Choice is
      when Mouse .. Rat =>
         Ada.Text_IO.Put_Line ("Your animal is a rodent.");
      when Cow .. Chicken =>
         Ada.Text_IO.Put_Line ("Your animal is a farm animal.");
      when Puma .. Tiger =>
         Ada.Text_IO.Put_Line ("Your animal is a ferocious cat");
   end case;

end Animals; 