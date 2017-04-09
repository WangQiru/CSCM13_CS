pragma SPARK_Mode;


package Angles is

   
   type Angle is new Integer range 0 .. 359;
   
   function ReturnAngle (X,Y : Angle) return Angle with
     pre => ((X < 360) and (Y < 360)),
     Post => (if (X+Y < 360) then (X+Y = ReturnAngle'Result) else (X+Y - 360 = ReturnAngle'Result ));
   
   procedure ReturnAngleProc(X,Y : in Angle; Z : out Angle)
     with Depends => (Z => (X,Y)),
       pre => ((X < 360) and (Y < 360)),
       Post => (if (X+Y < 360) then (Z = X+Y) else (Z = X+Y - 360 ));
     
end Angles;
     
     
   
     
   
