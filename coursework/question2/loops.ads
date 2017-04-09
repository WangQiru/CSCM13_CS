pragma SPARK_Mode;


package Loops is

   
   type Result is new Integer range 0 .. 1000;
   type Result2 is new Integer range 0 .. (Integer(Result'Last)+1);
   

   
   procedure LoopProc(N : in Result; I : out Result;Res : out Result2)
     with Depends => (Res => N, I => N),
     Pre => N>0,
     Post => ((Result2(N)=Res) or (Result2(N)+1=Res)) and (Result2(I)*2 = Res);
    
end Loops;
     
     
   
     
   
