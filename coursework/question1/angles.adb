pragma SPARK_Mode;


package body Angles is
   
   function ReturnAngle (X,Y : in Angle) return Angle is
   begin     
      if X+Y  < 360 then return Angle(X+Y);
         else return Angle(X+Y - 360) ;
      end if;
   end ReturnAngle;
   
   
  procedure ReturnAngleProc (X,Y : in Angle; Z: out Angle) is
   begin     
     if X+Y < 360 then Z:=Angle(X+Y);
        else Z:= Angle(X+Y - 360);
     end if;
   end ReturnAngleProc;
   
     
end Angles;
     
     
   
     
   
