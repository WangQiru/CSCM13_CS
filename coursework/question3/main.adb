-- this is the executable file 
-- running the nuclear power system
--
-- it initialises the system
-- then runs for ever in a loop which
--   1) reads the temperature from console
--   2) monitors the cooling system so that the cooling
--      system is activated if the temperature is too high
--   3) prints out the status
-- 
--  the loop_invariant expresses that the system stays safe all the time.

with airplane_system_distance_speed;
use airplane_system_distance_speed;



procedure Main
is
begin
   loop
      pragma Loop_Invariant (Is_Reachable(Status_System));
      Read_Distance_And_Speed;
      Monitor_Reachable_Status;
      Print_Status;
   end loop;
end Main;
      
      
