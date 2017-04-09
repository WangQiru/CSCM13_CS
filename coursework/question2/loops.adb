pragma SPARK_Mode;


package body Loops is
   
   
   
  procedure LoopProc (N : in Result; I: out Result; Res: out Result2) is
      begin
      I := 0;
      Res := 0;      
      loop 
         pragma Loop_Invariant(Result2(I)*2-Res = 0 and (Result2(N)>Res));
         I := I + 1;
         Res := Res + 2;
         exit when Res >= Result2(N);
      end loop;
      end LoopProc;
     
end Loops;
     
     
   
     
   
