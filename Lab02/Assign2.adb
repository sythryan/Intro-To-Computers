with Ada.Text_IO;


procedure Initials is

-- This program computes my initials

   Row1 : constant string :=("   SSSS          JJJJJJJ          RRRRR");
   Row2 : constant string :=("  S    S            J             R    R");
   Row3 : constant string :=("  S                 J             R    R");
   Row4 : constant string :=("   SSS              J             RRRRR");
   Row5 : constant string :=("       S            J             R  R");
   Row6 : constant string :=("  S    S         J  J             R   R");
   Row7 : constant string :=("   SSSS           JJJ             R    R");

   ---------------------------------------------------


begin

     Ada.Text_IO.Put (Item => Row1);  -- Row 1
     Ada.Text_IO.New_Line;

     Ada.Text_IO.Put (Item => Row2);  -- Row 2
     Ada.Text_IO.New_Line;

     Ada.Text_IO.Put (Item => Row3);  -- Row 3
     Ada.Text_IO.New_Line;

     Ada.Text_IO.Put (Item => Row4);  -- Row 4
     Ada.Text_IO.New_Line;

     Ada.Text_IO.Put (Item => Row5);  -- Row 5
     Ada.Text_IO.New_Line;

     Ada.Text_IO.Put (Item => Row6);  -- Row 6
     Ada.Text_IO.New_Line;

     Ada.Text_IO.Put (Item => Row7);  -- Row 7
     Ada.Text_IO.New_Line;

end Initials;
