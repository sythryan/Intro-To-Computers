with Ada.Characters.Handling;
use Ada.Characters.Handling;
with Ada.Integer_Text_IO;
with Ada.Text_IO;
procedure Character_Fun is

   Ch : Character;


begin
   Char_Loop :
   loop
      Ada.Text_IO.Put ("Enter a character ->");
      Ada.Text_IO.Get (Ch);
      Ada.Text_IO.New_Line;

      Ada.Text_IO.Put ("Your character is at position ");
      Ada.Integer_Text_IO.Put (Item => Character'Pos (Ch),
                               Width => 1);
      Ada.Text_IO.New_Line;




      if Is_Graphic (Ch) then
         Ada.Text_IO.Put ("Your character is a graphic character");
         Ada.Text_IO.New_Line;
      elsif Is_Control (Ch) then
         Ada.Text_IO.Put ("Your character is a control character");
      end if;

      if Is_Letter (Ch) then
         Ada.Text_IO.Put ("Your character is a letter");
         Ada.Text_IO.New_Line;
      end if;

      if Is_Lower (Ch) then
         Ada.Text_IO.Put ("Your character is a lowercase letter");
         Ada.Text_IO.New_Line;
      elsif Is_Upper (Ch) then
         Ada.Text_IO.Put ("Your character is an uppercase letter");
         Ada.Text_IO.New_Line;
      end if;

      if Is_Digit (Ch) then
         Ada.Text_IO.Put ("Your character is a decimal digit.");
         Ada.Text_IO.New_Line;
      end if;

      if Is_Hexadecimal_Digit (Ch) then
         Ada.Text_IO.Put ("Your character is a hexadecimal digit");
         Ada.Text_IO.New_Line;
      end if;

      if Is_Alphanumeric (Ch) then
         Ada.Text_IO.Put ("Your character is an alphanumeric character");
         Ada.Text_IO.New_Line;
      elsif Is_Special (Ch) then
         Ada.Text_IO.Put ("You character is a special character");
         Ada.Text_IO.New_Line;
      end if;
      Ada.Text_IO.New_Line (2);

      Ada.Text_IO.Put (Character'Val (7));

   end loop Char_Loop;
end Character_Fun;