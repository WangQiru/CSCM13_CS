pragma SPARK_Mode (On);

with AS_IO_Wrapper;  use AS_IO_Wrapper; 
with Angles;  use Angles; 


procedure Main is
   X,Y : Integer; 
   Z: Angle;

begin
   -- First we initialise standard_input and standard output
   AS_Init_Standard_Output;
   AS_Init_Standard_Input;   
   loop
      AS_Put("Enter a number for X from 0 .. 359: ");   
      AS_Get(X,"Please type in an integer; please try again");
      exit when X in 0 .. 359;
      AS_Put_Line("Please Enter a number between 0 and 359 for X");
   end loop;
   loop
      AS_Put("Enter a number for Y from 0 .. 359: ");   
      AS_Get(Y,"Please type in an integer; please try again");
      exit when Y in 0 .. 359;
      AS_Put_Line("Please Enter a number between 0 and 359 for Y");
   end loop;
   AS_Put("The result of the function is ");
   AS_Put_Line(Integer(ReturnAngle(Angle(X),Angle(Y))));
   ReturnAngleProc(Angle(X),Angle(Y),Z);
   AS_Put("The result of the procedure is ");
   AS_Put_Line(Integer(Z));   
  
end Main;
   

