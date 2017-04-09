pragma SPARK_Mode (On);

with AS_IO_Wrapper;  use AS_IO_Wrapper; 


package body airplane_system_distance_speed is
   
   
   procedure Read_Distance_And_Speed is
      Distance : Integer;
      Speed : Integer;
   begin
      AS_Put_Line("Please input a distance to the destination airport");
      loop
	 AS_Get(Distance,"Please type in an integer");
	 exit when (Distance >= Min_Distance_Possible) and (Distance <= Max_Distance_Possible);
         AS_Put("Please type in a value between ");
         AS_Put(Min_Distance_Possible);
         AS_Put(" and ");
	 AS_Put(Max_Distance_Possible);
	 AS_Put_Line("");
      end loop;
      AS_Put_Line("Please input a speed for airplane");
       loop
	 AS_Get(Speed,"Please type in an integer");
	 exit when (Speed >= Min_Speed_Possible) and (Speed <= Max_Speed_Possible);
         AS_Put("Please type in a value between ");
         AS_Put(Min_Speed_Possible);
         AS_Put(" and ");
	 AS_Put(Max_Speed_Possible);
	 AS_Put_Line("");
      end loop;
      Status_System.Distance_Entered := Flying_Range(Distance);
      Status_System.Speed_Entered := Engine_Speed_Range(Speed);
   end Read_Distance_And_Speed;
   
   function Flight_Result_To_String (Target_Status : Flight_Result) return String is
      begin
	 if (Target_Status = Reached) 
	 then return "Reached";
	 else return "Not_Reached";
	 end if;
      end Flight_Result_To_String;
	
   
   
   procedure Print_Status is
   begin
      AS_Put("Speed = ");
      AS_Put(Integer(Status_System.Speed_Entered));
      AS_Put_Line("");
      AS_Put("Distance = ");
      AS_Put(Integer(Status_System.Distance_Entered));
      AS_Put_Line("");
      AS_Put("Target = ");
      AS_Put_Line(Flight_Result_To_String(Status_System.Target_Status));
      AS_Put("Recommend Speed = ");
      AS_Put_Line(Cal_Recommend_Speed(Integer(Status_System.Speed_Entered),Integer(Status_System.Distance_Entered),Status_System));
     
   end Print_Status;
   
   
   procedure Monitor_Reachable_Status  is
   begin
      if (((Gas_Capacity/500 * (Max_Speed_Possible - Integer(Status_System.Speed_Entered)) + Gas_Capacity))>= Integer(Status_System.Distance_Entered))
      then Status_System.Target_Status := Reached;
      else Status_System.Target_Status := Not_Reached;
      end if;
   end Monitor_Reachable_Status;
   
   
   function Cal_Recommend_Speed (Speed,Distance : Integer;Status : Status_System_Type) return Integer is
       Recommend_Speed :Engine_Speed_Range;
       New_Distance : Flying_Range;
   begin

      if(Status.Target_Status = Reached)
      then      
      Recommend_Speed := Engine_Speed_Range(Max_Speed_Possible);     

      loop 
         exit when Recommend_Speed = Engine_Speed_Range(Min_Speed_Possible);
         pragma Loop_Invariant( Recommend_Speed >= 1001 and Recommend_Speed <= 20000);          
         
         New_Distance := Flying_Range(((Gas_Capacity/500 * (Max_Speed_Possible - Integer(Recommend_Speed)) + Gas_Capacity)));
         if (New_Distance >= Flying_Range(Distance) and Recommend_Speed > Engine_Speed_Range(Speed))
         then return Integer(Recommend_Speed);
         end if;
            
         Recommend_Speed := Recommend_Speed - 1;
      end loop;
         return Speed;
         
      else 
          Recommend_Speed := Engine_Speed_Range(Speed);  

      loop 
         exit when Recommend_Speed = Engine_Speed_Range(Min_Speed_Possible);
         pragma Loop_Invariant( Recommend_Speed >= 1001 and Recommend_Speed <= 20000); 
         Recommend_Speed := Recommend_Speed - 1;
         
         New_Distance := Flying_Range(((Gas_Capacity/500 * (Max_Speed_Possible - Integer(Recommend_Speed)) + Gas_Capacity)));
         if (New_Distance >= Flying_Range(Distance) and Recommend_Speed < Engine_Speed_Range(Speed))
         then return Integer(Recommend_Speed);
         end if;
        
      end loop;
         return Speed;
         end if;
      end Cal_Recommend_Speed;
     
end airplane_system_distance_speed;    
