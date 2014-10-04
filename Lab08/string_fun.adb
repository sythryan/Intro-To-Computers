with Ada.Text_IO;
with Ada.Characters.Handling;
procedure String_Fun is

   type Choice_Type is (Rock, Paper, Scissors);

   package Choice_IO is new Ada.Text_IO.Enumeration_IO (Enum => Choice_Type);

   ----------------------------------------------------------------------------
   procedure Put (Item : in Choice_Type) is
      Value : String := Choice_Type'Image (Item);
   begin
      Value := Ada.Characters.Handling.To_Lower (Value);
      Value (1) := Ada.Characters.Handling.To_Upper (Value (1));
      Ada.Text_IO.Put (Value);
   end Put;

-------------------------------------------------------------------------------
   Choice : Choice_Type := Rock;
   Count  : Integer     := 1;

begin
   Count := 1;
   loop
      Ada.Text_IO.Put ("Iteration number" & Integer'Image (Count));
      Ada.Text_IO.New_Line;

      Ada.Text_IO.Put ("Enter a choice: ");
      Choice_IO.Get (Choice);

      Ada.Text_IO.Put ("You entered ");
      Put (Choice);        -- You will replace this call
      Ada.Text_IO.New_Line (2);

      Count := Count + 1;
   end loop;
end String_Fun;
   