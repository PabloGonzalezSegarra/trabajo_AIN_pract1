/* 
 * @Authors: Pablo González Segarra & Carles Carbonell Sales
*/

+flag(F): team(200)
  <-
  +movingP1;
  +general_moving;
  +free;
  +no_corro;
  .print("Moving to target 1");
  .goto([127,0,9]).
  
+health(H): H<=45 & free
  <-
  -general_moving;
  -free;
  +acurarse;
  .print("I'm dying!");
  .goto([130,0,120]).

+packs_in_fov(ID,Type,Angle,Distance,Health,Position): Type = 1001 & acurarse
<-
  .print("Going to medic pack");
  .goto(Position);
  -acurarse;
  +apormedpaquete.

+pack_taken(TYPE, N): TYPE = medic & apormedpaquete
  <-
  .print("Medic pack taken with ", N, " health points");
  -apormedpaquete;
  +free;
  +general_moving.
  
+ammo(H): H<=35 & free
  <-
  +aporammo;
  -free;
  -general_moving;
  .print("Without ammo!");
  .goto([130,0,120]).

+packs_in_fov(ID,Type,Angle,Distance,Health,Position): Type = 1002 & aporammo
<-
  .print("Going to ammo pack");
  .goto(Position);
  -aporammo;
  +aporammopaquete.

+pack_taken(TYPE, N): TYPE = fieldops & aporammopaquete
  <-
  .print("Ammo pack taken with ", N, " ammo points");
  +general_moving;
  +free;
  -aporammopaquete.

+target_reached(T): movingP1 & general_moving
  <-
  .print("Reached target 1, moving to target 2");
  .goto([9,0,127]);
  +no_corro;
  -movingP1;
  +movingP2.

+target_reached(T): movingP2 & general_moving
  <-
  .print("Reached target 2, moving to target 3");
  .goto([127,0,245]);
  +no_corro;
  -movingP2;
  +movingP3.

+target_reached(T): movingP3 & general_moving
  <-
  .print("Reached target 3, moving to target 4");
  .goto([245,0,127]);
  +no_corro;
  -movingP3;
  +movingP4.

+target_reached(T): movingP4 & general_moving
  <-
  .print("Reached target 4, moving to target 1");
  .goto([127,0,9]);
  +no_corro;
  -movingP4;
  +movingP1.

+friends_in_fov(ID,Type,Angle,Distance,Health,Position)
<-
  .print("Friend in pov");
  ?health(H);
  .shoot(5,Position);
  if (Health >= H)  {
    if(no_corro & general_moving){
      if (movingP1 & general_moving) {
          .print("Friend in pov with more heal, going back to target 4");
          -movingP1;
          +movingP4;
          -no_corro;
          .goto([127,0,9]);
      }else{
        if(movingP2 & general_moving){
          .print("Friend in pov with more heal, going back to target 1");
          -movingP2;
          +movingP1;
          -no_corro;
          .goto([245,0,127]);
        }else{
          if(movingP3 & general_moving){
            .print("Friend in pov with more heal, going back to target 2");
            -movingP3;
            +movingP2;
            -no_corro;
            .goto([9,0,127]);
          }else{
            if(movingP4 & general_moving){
              .print("Friend in pov with more heal, going back to target 3");
              -movingP4;
              +movingP3;
              -no_corro;
              .goto([9,0,127]);
            }else{
              .print("Unknow state");
            }
          }
        }
      }
    }
  }.

