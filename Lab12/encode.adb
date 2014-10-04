with Ada.Text_IO;
with Ada.Characters.Handling;
use Ada.Characters.Handling;
procedure Encode is

   -- This program uses a "secret code" to encode a message.  The "secret code"
   -- is read from a file and the message to encode is entered from the keyboard.
   -- The encoded message is displayed on the console.

   -- Assumptions : 1. The name of the file with the code contains no more than
   --                  80 characters.
   --               2. The file with the code exists.
   --               3. The file with the code contains exactly 26 lowercase
   --                  letters and no other characters.
   --               4. The message to encode contains only lowercase letters and blanks.


   -- For messages
   subtype Message_String is String (1 .. 100);

   -- For file names
   subtype File_Name_String is string (1 .. 80);

   -- For "secret codes"
   subtype Lowercase    is Character range 'a' .. 'z';
   type    Encode_Array is array (Lowercase) of Lowercase;


   -----------------------------------------------------------------------------
   function Valid_Code (Code : in Encode_Array) return Boolean is
   -- Checks to make sure that the given code is a valid code.
   -- An invalid code contains two or more copies of a given letter.

   -- Preconditions  : none
   --
   -- Postconditions : Returns False if Code contains a duplicate letter
   --                  Otherwise, returns True

      Valid : Boolean;  -- The result of the function

   begin  -- Valid Code
      Valid := True;  -- Initialize result

      -- Check all the letters but the last in Code.  No need to check the last
      --    if we have already checked all those that come before it.
      -- Each iteration, one letter is checked to see if a duplicate exists
      for Current in Code'First .. Character'Pred (Code'Last) loop

         -- Compare the Current letter to all letters that follow it
         -- Each iteration, compare the current letter to one that follows
         for Index in Character'Succ (Current) .. Code'Last loop
            if Code (Current) = Code (Index) then  -- Is there a duplicate?
               Valid := False;
            end if;
         end loop;
      end loop;
      return Valid;
   end Valid_Code;

   -----------------------------------------------------------------------------
   procedure Get_Code (Code : out Encode_Array) is
   -- This procedure gets the code from a file

   -- Preconditions  : The file name contains no more than 80 characters
   --                  The file exists
   --                  The file contains exactly 26 lowercase letters and
   --                      no other characters
   --
   -- Postconditions : Code contains 26 lowercase letters

      Name   : File_Name_String;      -- Code file name
      Length : Positive;              -- Length of file name
      File   : Ada.Text_IO.File_Type; -- Code file

   begin -- Get Code
      Ada.Text_IO.Put_Line ("Enter the name of the file containing your code.");
      Ada.Text_IO.Get_Line (Item => Name, Last => Length);
      Ada.Text_IO.Open (File => File,
                        Mode => Ada.Text_IO.In_File,
                        Name => Name (1 .. Length));

      -- Get all of the letters in the code
      -- Each iteration, get one code letter
      for Index in Encode_Array'Range loop
         Ada.Text_IO.Get (File => File, Item => Code (Index));
      end loop;

      Ada.Text_IO.Close (File);
   end Get_Code;

   -----------------------------------------------------------------------------
   procedure Encode_Message (Message         : in  String;
                             Code            : in  Encode_Array;
                             Encoded_Message : out String) is
   -- Uses the given Code to encode the given Message

   -- Postconditions : Encoded_Message is the result of applying the Code to Message
   --                  Blanks are not changed


   begin
      -- Convert the first Length letters in Message
      -- Each iteration, one letter is converted and put in Encoded_Message
      for Index in Message'Range loop
         if Is_Letter (Message (Index)) then
            Encoded_Message (Index) :=  Code (To_Lower (Message (Index))); -- Modify this assignment statement
         else
            Encoded_Message (Index) := Message (Index);
         end if;
      end loop;
   end Encode_Message;

-----------------------------------------------------------------------------
   My_Code         : Encode_Array;    -- The Code
   Message         : Message_String;  -- The message
   Length          : Natural;         -- Length of the message
   Encoded_Message : Message_String;  -- The coded message

begin  -- Program Encode
   Get_Code (My_Code);
   if not Valid_Code (My_Code) then
      Ada.Text_IO.Put_Line ("The code is invalid; it contains a duplicate.");
   else
      Ada.Text_IO.Put_Line ("The code is valid.");

      -- Get the message
      Ada.Text_IO.Put_Line ("Enter a message to encode.");
      Ada.Text_IO.Get_Line (Item => Message, Last => Length);

      -- Encode the message
      Encode_Message (Message         => Message (1 .. Length),
                      Code            => My_Code,
                      Encoded_Message => Encoded_Message (1 .. Length));

      -- Display the encoded message
      Ada.Text_IO.New_Line (2);
      Ada.Text_IO.Put_Line ("The encoded message is");
      Ada.Text_IO.Put_Line (Encoded_Message (1 .. Length));
      Ada.Text_IO.New_Line (2);


--      -- Code to run for the last question
--
      Message (21 .. 33) := "HELLO MILDRED";
      Ada.Text_Io.Put_Line ("The message is");
      Ada.Text_Io.Put_Line (Message (21 .. 33));
      Encode_Message (Message         => Message(21 .. 33),
                      Code            => My_Code,
                      Encoded_Message => Encoded_Message(21 .. 33));

      -- Display the encoded message
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put_Line ("The encoded message is");
      Ada.Text_Io.Put_Line (Encoded_Message (21 .. 33));

   end if;
end Encode;