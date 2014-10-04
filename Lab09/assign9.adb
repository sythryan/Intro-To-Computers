with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Characters.Handling;
procedure Assign9 is
-- Written by Syth Ryan
--
-- This program computes and dipslays a calendar year
--
-- Input:
-- Year
-- Day January 1st starts on
--
-- Output:
-- Prompts
-- One calendar year
--
-- Assumptions:
-- User enters a whole number for the year
-- User enters the day of the week correctly
-------------------------------------------------------------------------------
   -- Types
   -- For condition week day
   type Week_Day_Type is (Sunday, Monday, Tuesday, Wednesday, Thursday,
                          Friday, Saturday);
   -- For condition month
   type Month_Type is (January, Feburary, March, April, May, June, July,
                       August, September, October, November, December);
   -- Instantiate Enumeration I/O
   package Week_Day_IO is new Ada.Text_IO.Enumeration_IO (Enum => Week_Day_Type);
-------------------------------------------------------------------------------
      -- Display one week
      -- Preconditions : Date must be between 1 and 31
      procedure Week (Current_Date : in out Integer;
                      Last_Date    : in Integer;
                      Day          : in out Week_Day_Type) is

         -- Variables
         Date : Natural;         -- Date to display

      begin

         Date := Current_Date;
         -- Display one week
         -- Each iteration, display one date
         Date_Loop :
         loop
            Ada.Integer_Text_IO.Put (Item => Date,
                                     Width => 3);
            exit Date_Loop when Date = Last_Date or Day = Saturday;
            Date := Date + 1;
            Day  := Week_Day_Type'Succ (Day);
         end loop Date_Loop;
         Current_Date := Date + 1;
      end Week;
-------------------------------------------------------------------------------
   -- Display one month
   -- Preconditions : Current_Date must be between 1 and 31
   --                 Last_Date must be between 1 and 31
   procedure Display_Month (Year  : in Integer;
                            Month : in Month_Type;
                            Day   : in out Week_Day_Type) is

      -- Variables
      Current_Date : Natural;                        -- Beginning day number
      Last_Date    : Natural;                        -- The number of days in the month
      Value        : String := Month_Type'Image (Month);    -- Month changed to only first letter uppercase

   begin
      -- Change to only first letter to upper case
      Value := Ada.Characters.Handling.To_Lower (Value);
      Value (1) := Ada.Characters.Handling.To_Upper (Value (1));

      -- Set the month header
      Ada.Text_IO.Put ("       ");
      Ada.Text_IO.Put         (Value);
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put ("  S  M  T  W  T  F  S");
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put (" --------------------");
      Ada.Text_IO.New_Line;

      -- Determine leading blanks for first week
      if Day = Monday then
         Ada.Text_IO.Put ("   ");
      elsif Day = Tuesday then
         Ada.Text_IO.Put ("      ");
      elsif Day = Wednesday then
         Ada.Text_IO.Put ("         ");
      elsif Day = Thursday then
         Ada.Text_IO.Put ("            ");
      elsif Day = Friday then
         Ada.Text_IO.Put ("               ");
      elsif Day = Saturday then
         Ada.Text_IO.Put ("                  ");
      else
         null;    -- No blanks if sunday
      end if;

      -- Determine number of days in the month
      if Month = April or Month = June or Month = September or Month = November then
         Last_Date := 30;
      elsif Month = Feburary then    -- Determine if Feburary is a leap year
         if Year rem 400 = 0 or (Year rem 100 /= 0 and Year rem 4 = 0) then
            Last_Date := 29;
         else
            Last_Date := 28;
         end if;
      else
         Last_Date := 31;
      end if;

      Current_Date := 1;

      -- Display all weeks in a month
      -- Each itration, display one week
      Week_Loop :
      loop
         -- Display one week
         Week (Current_Date => Current_Date,
               Last_Date    => Last_Date,
               Day          => Day);
         exit Week_Loop when Current_Date > Last_Date;
         Day := Sunday;
         Ada.Text_IO.New_Line;

      end loop Week_Loop;
      if Day = Saturday then
         Day := Sunday;
      else
         Day  := Week_Day_Type'Succ (Day);
      end if;
   end Display_Month;
-------------------------------------------------------------------------------
   -- Get a valid year
   -- Preconditions : none
   procedure Get_Year (Year : out Integer) is

   begin
      -- Get a valid number for year
      -- Each iteration, check one number
      Valid_Loop :
      loop
         Ada.Text_IO.Put ("For what year do you want a calendar?");
         Ada.Text_IO.New_Line;
         Ada.Integer_Text_IO.Get (Year);
         exit Valid_Loop when Year > 1752;
         Ada.Text_IO.New_Line;
         Ada.Text_IO.Put ("Please enter a year greater than 1752.");
         Ada.Text_IO.New_Line (2);
      end loop Valid_Loop;
      Ada.Text_IO.New_Line (2);
   end Get_Year;
-------------------------------------------------------------------------------
-- Main program
   -- Variables
   Year    : Integer range 1753 .. Integer'Last;   -- Year of the calendar
   Day     : Week_Day_Type;                        -- Day month ends, next month starts and
                                                   -- day january 1st falls on
begin
   -- Get a valid year
   Get_Year (Year => Year);

   -- Get the day of week for January 1st
   Ada.Text_IO.Put ("What day of the week does January 1, ");
   Ada.Integer_Text_IO.Put (Year, 1);
   Ada.Text_IO.Put (" fall on?");
   Ada.Text_IO.New_Line;
   Week_Day_IO.Get (Day);
   Ada.Text_IO.New_Line (2);

   -- Display calendar heading for the year
   Ada.Text_IO.Put ("Calendar for ");
   Ada.Integer_Text_IO.Put (Year, 1);
   Ada.Text_IO.New_Line (2);

   -- Display all months
   -- Each iteration, display one month
   for Month in January .. December loop
      -- Display one month
      Display_Month (Year    => Year,
                     Month   => Month,
                     Day     => Day);
      Ada.Text_IO.New_Line (2);
   end loop;
end Assign9;