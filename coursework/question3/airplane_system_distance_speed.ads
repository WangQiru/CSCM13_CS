-- This file was created by Wang Qiru
-- it is an example of a critical system
-- if the Distance for the destination airport is not reachable at the given Speed 
-- or if the Speed is too slow fot the given Distance
-- that system will recommend a Speed dynamically.

pragma SPARK_Mode (On);

with SPARK.Text_IO;
use  SPARK.Text_IO;


package airplane_system_distance_speed is
   
   
   -- Max_Speed_Possible and Min_Speed_Possible describes the 
   -- Maximum and Minimum Speed which could ever occur when running this system
   
   Max_Speed_Possible : constant Integer := 20000;
   Min_Speed_Possible : constant Integer := 1000;
   
   
   -- Gas_Capacity describes the amount of Gas of the airplane   
   
   Gas_Capacity : constant Integer := 1000;
   
   -- Max_Distance_Possible and Min_Distance_Possible describes the 
   -- Maximum and Minimum Distance which could ever occur when running this system for the airplane
   -- Max_Distance_Possible is calculated using the formula designed below

   Max_Distance_Possible : constant Integer := Gas_Capacity/500 * (Max_Speed_Possible - Min_Speed_Possible) + Gas_Capacity;
   Min_Distance_Possible : constant Integer := 1000;
  
   -- range of Distance and Speed which possible can exist
   type Flying_Range is new Integer range Min_Distance_Possible .. Max_Distance_Possible;
   type Engine_Speed_Range is new Integer range Min_Speed_Possible .. Max_Speed_Possible;

   -- result of the flight
   type Flight_Result is (Reached, Not_Reached);
   
   -- status of the overall system consisting of the Speed, Distance and the status of the airplane system
   type Status_System_Type  is 
      record
         Distance_Entered  : Flying_Range;
         Speed_Entered : Engine_Speed_Range;
         Target_Status : Flight_Result;
      end record;
   
   -- Status System is a global variab Integer(le determining the status of the system
   Status_System : Status_System_Type;
   
   -- Read_Distance_And_Speed gets the current Distance and Speed from console input output
   -- and updates Status_System
   procedure Read_Distance_And_Speed with
     Global => (In_Out => (Standard_Output, Standard_Input,Status_System)),
     Depends => (Standard_Output => (Standard_Output,Standard_Input),
		 Standard_Input  => Standard_Input,
		 Status_System   => (Status_System, Standard_Input));
   
   -- This function converts a value into Flight_Result
   -- into a string which can be printed to console
   function Flight_Result_To_String (Target_Status   : Flight_Result) return String;
      
   
   
   -- Print Status prints out the status of the system on console
   procedure Print_Status with
     Global => (In_Out => Standard_Output, 
		Input  => Status_System),
     Depends => (Standard_Output => (Standard_Output,Status_System)),
     Pre => (Status_System.Speed_Entered > 1000 and Status_System.Speed_Entered < 20000 and Status_System.Distance_Entered > 1000 and Integer(Status_System.Distance_Entered)< Max_Distance_Possible);
   
   
   -- Is_Reachable determines whether the target is reachable, if applied to Status_System
   
   function Is_Reachable (Status : Status_System_Type) return Boolean is
     (if ( (Gas_Capacity/500 * (Max_Speed_Possible - Integer(Status.Speed_Entered)) + Gas_Capacity) >= Integer(Status.Distance_Entered))
	      then Status.Target_Status = Reached
              else Status.Target_Status = Not_Reached);

      
   -- Monitor_Reachable_Status monitors the Distance
   -- it checks if the distance is within airplane's range
   -- Afterwards the system will be safe as expressed by  the post condition   
   procedure Monitor_Reachable_Status  with
     Global  => (In_Out => Status_System),
     Depends => (Status_System => Status_System),
     Post    => Is_Reachable(Status_System);

   -- Cal_Recommend_Speed calculates the recommend Speed based on the Distance input
   -- It returns the recommend Speed in output
   function Cal_Recommend_Speed  (Speed,Distance: Integer; Status : Status_System_Type) return Integer with
     Pre => ((Speed > Min_Speed_Possible or Speed = Min_Speed_Possible) and (Speed < Max_Speed_Possible or Speed = Max_Speed_Possible) and (Distance > Min_Distance_Possible or Distance = Min_Distance_Possible) and (Distance < Max_Distance_Possible or Distance = Max_Distance_Possible)),
     Post    => (Cal_Recommend_Speed'Result > Min_Speed_Possible or Cal_Recommend_Speed'Result = Min_Speed_Possible) and (Cal_Recommend_Speed'Result = Max_Speed_Possible or Cal_Recommend_Speed'Result < Max_Speed_Possible) ;
   	        
   
end  airplane_system_distance_speed;


