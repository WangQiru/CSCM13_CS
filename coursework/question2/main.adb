pragma SPARK_Mode (On);

with AS_IO_Wrapper;  use AS_IO_Wrapper; 
with Loops;  use Loops; 


procedure Main is
   N : Integer; 
   I : Result;
   Res : Result2;

begin
   -- First we initialise standard_input and standard output
   AS_Init_Standard_Output;
   AS_Init_Standard_Input;   
   loop
      AS_Put("Enter a number for N from 1 .. 1000: ");   
      AS_Get(N,"Please type in an integer; please try again");
      exit when N in 1 .. 1000;
      AS_Put_Line("Please Enter a number between 1 and 1000 for N");
   end loop;


   LoopProc(Result(N),I,Res);
   AS_Put("The result of the procedure is ");
   AS_Put(Integer(I));   
   AS_Put(Integer(Res));   
  
end Main;
   

