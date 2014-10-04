with Ada.Sequential_IO;
with Ada.Text_IO;
with Ada.Float_Text_IO;
procedure Display is

   package Seq_Integer_IO is new Ada.Sequential_IO (Element_type => Float);

   Value     : Float;
   Int_File  : Seq_Integer_IO.File_Type;

begin
   Seq_Integer_IO.Open (File => Int_File,
                        Mode => Seq_Integer_IO.In_File,
                        Name => "Pasta.Dat");
   -- Display all of the numbers in the sequential file
   -- Each iteration, display one number
   Display_Loop :
   loop
      exit Display_Loop when Seq_Integer_IO.End_Of_File (Int_File);
      Seq_Integer_IO.Read (File => Int_File,
                           Item => Value);
      Ada.Float_Text_IO.Put (Item => Value,
                             Fore => 1,
                             Aft  => 1,
                             Exp  => 0);
      Ada.Text_IO.New_Line;
   end loop Display_Loop;
   Seq_Integer_IO.Close (Int_File);
end Display;