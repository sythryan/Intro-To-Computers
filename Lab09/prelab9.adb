with Ada.Text_IO;
procedure Prelab9 is

   Length : Constant := 10;

   subtype Fun_String is String (1..Length);

   procedure Mess (Item : in out Fun_String) is
      Ch    : Character;
      First : Natural;
      Last  : Natural;
   begin
      First := 1;
      Fun_Loop :
      loop
         exit Fun_Loop when First > Length / 2 - 1;
         Last := Length - First + 1;
         if Item (First) > Item (Last) then
            Ch           := Item (First);
            Item (First) := Item (Last);
            Item (Last)  := Ch;
         end if;
         First := First + 1;
      end loop Fun_Loop;
   end Mess;

   Fun : Fun_String;

begin
   Fun := "hellonancy";
   Ada.Text_IO.Put (Fun);
   Ada.Text_IO.New_Line;
   Mess (Item => Fun);
   Ada.Text_IO.Put (Fun);
   Ada.Text_IO.New_Line;
end Prelab9;