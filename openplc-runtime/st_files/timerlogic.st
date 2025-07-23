(* ---------- Main.st ---------- *)
PROGRAM Main
VAR
    (* Inputs / memory *)
    Weight      AT %MW0 : INT;      (* written by Unity – kg            *)
    StartReq    AT %IX0.0 : BOOL;    (* Unity tells PLC a box has spawned*)
                                     (* (optional – otherwise use Weight≠0) *)

    (* Outputs *)
    Motor       AT %QX0.0 : BOOL;    (* drives the conveyor              *)

    (* Internal timers *)
    T_Light  : TON;                  (* light box run time  – set PT later *)
    T_Medium : TON;                  (* medium-weight timer               *)
    T_Heavy  : TON;                  (* heavy-weight timer                *)

    NewBoxTrig : R_TRIG;             (* edge detector on Weight changes   *)
END_VAR


(* ========== Detect the arrival of a new box ========== *)
NewBoxTrig(CLK := (Weight <> 0));    (* rising edge when Unity writes MW0 *)

IF NewBoxTrig.Q THEN
    (* ----- classify weight and start the right timer ----- *)
    IF   Weight >= 10 THEN           (* heavy (10 kg +)  *)
         T_Heavy(IN := TRUE, PT := T#9s);   (* adjust PT later *)
    ELSIF Weight >= 5 THEN           (* medium (5 – 9 kg) *)
         T_Medium(IN := TRUE, PT := T#6s);
    ELSE                             (* light (< 5 kg)   *)
         T_Light(IN := TRUE, PT := T#3s);
    END_IF;
END_IF


(* Conveyor runs while **any** timer is counting *)
Motor := T_Light.IN OR T_Medium.IN OR T_Heavy.IN;

(* Feed the .IN pin with FALSE once each timer finishes *)
IF T_Light.Q THEN
    T_Light(IN := FALSE);
    Weight := 0;                     (* reset ready for next box *)
END_IF;

IF T_Medium.Q THEN
    T_Medium(IN := FALSE);
    Weight := 0;
END_IF;

IF T_Heavy.Q THEN
    T_Heavy(IN := FALSE);
    Weight := 0;
END_IF;