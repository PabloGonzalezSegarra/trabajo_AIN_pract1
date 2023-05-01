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

+friends_in_fov(ID,Type,Angle,Distance,Health,Position): movingP1 & general_moving 
<-
?health(H);
.shoot(5,Position);
.print("Shooting to ", ID);
if(Health > H & no_corro){
  -no_corro;
  -movingP1;
  +movingP4;
  .goto([245,0,127]);
  .print("Running away to target 4");
}.


+friends_in_fov(ID,Type,Angle,Distance,Health,Position): movingP2 & general_moving 
<-
?health(H);
.shoot(5,Position);
.print("Shooting to ", ID);
if(Health > H & no_corro){
  -no_corro;
  -movingP2;
  +movingP1;
  .goto( [127,0,9]);
  .print("Running away to target 1");
}.

+friends_in_fov(ID,Type,Angle,Distance,Health,Position): movingP3 & general_moving 
<-
?health(H);
.shoot(5,Position);
.print("Shooting to ", ID);
if(Health > H & no_corro){
  -no_corro;
  -movingP3;
  +movingP2;
  .goto([9,0,127]);
  .print("Running away to target 2");
}.

+friends_in_fov(ID,Type,Angle,Distance,Health,Position): movingP4 & general_moving 
<-
?health(H);
.shoot(5,Position);
.print("Shooting to ", ID);
if(Health > H & no_corro){
  -no_corro;
  -movingP4;
  +movingP3;
  .goto([127,0,245]);
  .print("Running away to target 3");
}.

+friends_in_fov(ID,Type,Angle,Distance,Health,Position)
<-
.print("Shooting to ", ID);
.shoot(5,Position).
