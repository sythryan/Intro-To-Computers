with Ada.Text_IO;
with Ada.Integer_Text_IO;
procedure Triangles is
-------------------------------------------------------------------------------
      procedure Display_One_Line (Count  : in Integer;
                                  Char   : in Character) is
         Num_Chars : Integer;

      begin

         Num_Chars := 1;

         -- Process a line of characters
         -- Each iteration, process one character
         Char_Loop :
         loop
            exit Char_Loop when Num_Chars > Count;
            Ada.Text_IO.Put (Item => Char);
            Ada.Text_IO.Put (Item => " ");
            Num_Chars := Num_Chars + 1;
         end loop Char_Loop;
         Ada.Text_IO.New_Line;
      end Display_One_Line;

-------------------------------------------------------------------------------
   procedure Get_Character (Char : out Character) is

   begin

      -- Get valid Drawing Character
      -- Each iteration, process one character
      Char_Loop :
      loop
         Ada.Text_IO.Put (Item => "Enter a drawing character: ");  -- Prompt for character
         Ada.Text_IO.Get (Item => Char);                           -- Get character
         exit Char_Loop when Char = '*' or Char = '#';             -- Exit when character is valid
         Ada.Text_IO.Put (Item => "Invalid character.");           -- Prompt for new character
         Ada.Text_IO.New_Line (Spacing => 2);
      end loop Char_Loop;
   end Get_Character;
-------------------------------------------------------------------------------
   procedure Top_Half (Char        : in Character;
                       Num_Of_Rows : in Integer) is

      Count : Integer;

   begin
      Count := 1;
      -- Process top half of triangle
      -- Each iteration, process one row
      Top_Loop :
      loop
         exit Top_Loop when Count > Num_Of_Rows;
         Display_One_Line (Char => Char,
                           Count => Count); -- Display one line of characters
         Count := Count + 1;
      end loop Top_Loop;
   end Top_Half;
-------------------------------------------------------------------------------
   procedure Bottom_Half (Char        : in Character;
                          Num_Of_Rows : in Integer) is

      Count : Integer;

   begin
      Count := Num_Of_Rows;
      -- Process top half of triangle
      -- Each iteration, process one row
      Top_Loop :
      loop
         exit Top_Loop when Count < 1;
         Display_One_Line (Char => Char,
                           Count => Count); -- Display one line of characters
         Count := Count - 1;
      end loop Top_Loop;
   end Bottom_Half;

-------------------------------------------------------------------------------
   Rows        : Integer;
   Char        : Character;

begin

   -- Draw a number of triangles
   -- Each iteration, draw one triangle
   Triangle_Loop :
   loop
      Ada.Text_IO.Put (Item => "Enter number of rows: ");   -- Promt the user for number of rows
      Ada.Integer_Text_IO.Get (Item => Rows);               -- Get rows
      exit Triangle_Loop when Rows rem 2 = 0 or Rows < 0;   -- exit loop when rows is even or negative
      Get_Character (Char => Char);
      Top_Half (Char => Char,
               Num_Of_Rows => Rows / 2 + 1);                -- Draw Top Triangle
      Bottom_Half (Char => Char,
                   Num_Of_Rows => Rows / 2);                -- Draw bottom Triangle
      Ada.Text_IO.New_Line (Spacing => 2);
   end loop Triangle_Loop;


end Triangles;

