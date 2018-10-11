*********************Multi-thread(CMOSmin=512)*********

.option ACCT=2  

*******************************************************

.options probe
.options post=1
.options scale=1
.options parhier=local

**************************LIB**********************

.include './45nm_NMOS_bulk35915.inc'
.include './45nm_PMOS_bulk49800.inc'

*******************************************************

.temp 25
.tran 100ps 600ns  uic 
*sweep width 180nm 560nm 40nm
.print tran V(*) I(*)

.IC V(LX)=0V
.IC V(RX)=0.9V


*.tran 1p 'pw' START=1.0e-18  uic $sweep vmtj 0.3 0.6 0.1
*.PLOT TRAN V(net7)

**************************PARAMETER********************

.parameter width= 300nm
 
*.global VDD
.global VSS

*V99 VDD 0 0.9V
V98 VSS 0 0V
V97	VH	0 0.45V

.global VD
.global VS

V91 VD 0 0.9V
V90 VS 0 0V


*****************************DRAM_CELL*****************************
.SUBCKT DRM   BL  WL0  WL1  WL2  WL3  
MN0     CA0   WL0   BL   VS   NCH	l=45nm w=90NM m=1
MN1     CA1   WL1   BL   VS   NCH	l=45nm w=90NM m=1
MN2     CA2   WL2   BL   VS   NCH	l=45nm w=90NM m=1
MN3     CA3   WL3   BL   VS   NCH	l=45nm w=90NM m=1
C0    	CA0   VSS   5fF
C1    	CA1   VSS   5fF
C2    	CA2   VSS   5fF
C3    	CA3   VSS   5fF
.ENDS


*****************************WRITE***************************
.SUBCKT WRITE WREN  WR  BL
MN0     WR   WREN   BL  VS   NCH    l=40nm w=180nm m=1   
.ENDS

***initial 
X_WRIT0  WREN  WR0  BLP0  WRITE

***dram_cell
X_DRMP0  BLP0 WLP0 WLP1 WLP2 WLP3 DRM



******************************
**********initial*************    
******************************
V000 WREN 0
+PWL ( 0.0NS  0.0V   0.1NS  0.0V  10.1NS  0.0V  10.2NS  1.8V  600NS  1.8V 600.1NS  0.0V)

V010 WR0  0
+PWL ( 0.0NS 0.45V   0.1NS 0.45V  10.3NS 0.45V 200.0NS 0.45V 
+    200.1NS 0.00V 220.0NS 0.00V 300.0NS 0.00V 400.0NS 0.00V
+    400.1NS 0.45V 450.1NS 0.45V 500.1NS 0.45V 600.1NS 0.45V)

******************************
**********word line***********   
******************************
***pos_side***

V200 WLP0  0
+PWL ( 0.0NS 0.00V  19.9NS  0.0V  20.0NS  1.8V  40.0NS  1.8V  40.1NS  0.0V
+     50.0NS  0.0V  60.0NS  0.0V  70.0NS  0.0V 100.0NS  0.0V
+    120.0NS  0.0V 140.0NS  0.0V 160.0NS  0.0V 180.0NS  0.0V
+    200.0NS  0.0V 219.9NS  0.0V 220.0NS  1.8V 240.0NS  1.8V 240.1NS  0.0V 
+    250.0NS  0.0V 260.0NS  0.0V 270.0NS  0.0V 300.0NS  0.0V
+    320.0NS  0.0V 340.0NS  0.0V 360.0NS  0.0V 380.0NS  0.0V 
+    400.0NS  0.0V 419.0NS  0.0V 420.0NS  1.8V 440.0NS  1.8V 440.1NS  0.0V
+    450.0NS  0.0V 460.0NS  0.0V 470.0NS  0.0V 500.0NS  0.0V
+    520.0NS  0.0V 540.0NS  0.0V 570.0NS  0.0V 600.0NS  0.0V)


V201 WLP1  0
+PWL ( 0.0NS 0.00V  59.9NS  0.0V  60.0NS  1.8V  80.0NS  1.8V  80.1NS 0.0V
+    100.0NS  0.0V 120.0NS  0.0V 160.0NS  0.0V 180.0NS  0.0V
+    200.0NS  0.0V 259.9NS  0.0V 260.0NS  1.8V 280.0NS  1.8V 280.1NS 0.0V
+    300.0NS  0.0V 320.0NS  0.0V 360.0NS  0.0V 380.0NS  0.0V
+    400.0NS  0.0V 459.9NS  0.0V 460.0NS  1.8V 480.0NS  1.8V 480.1NS 0.0V
+    500.0NS  0.0V 540.0NS  0.0V 580.0NS  0.0V 600.0NS  0.0V)


V202 WLP2  0
+PWL ( 0.0NS  0.0V  20.0NS  0.0V  60.0NS  0.0V  80.0NS  0.0V
+    100.0NS  0.0V 119.9NS  0.0V 120.0NS  1.8V 140.0NS  1.8V 140.1NS 0.0V
+    160.0NS  0.0V 170.0NS  0.0V 180.0NS  0.0V 190.0NS  0.0V
+    200.0NS  0.0V 220.0NS  0.0V 260.0NS  0.0V 280.0NS  0.0V
+    300.0NS  0.0V 319.9NS  0.0V 320.0NS  1.8V 340.0NS  1.8V 340.1NS 0.0V
+    360.0NS  0.0V 370.0NS  0.0V 380.0NS  0.0V 390.0NS  0.0V
+    400.0NS  0.0V 420.0NS  0.0V 460.0NS  0.0V 480.0NS  0.0V
+    500.0NS  0.0V 519.9NS  0.0V 520.0NS  1.8V 540.0NS  1.8V 540.1NS 0.0V
+    560.0NS  0.0V 570.0NS  0.0V 580.0NS  0.0V 600.0NS  0.0V)


V203 WLP3  0
+PWL ( 0.0NS  0.0V  20.0NS  0.0V  60.0NS  0.0V  80.0NS  0.0V
+    100.0NS  0.0V 159.9NS  0.0V 160.0NS  1.8V 180.0NS  1.8V 180.1NS 0.0V
+    200.0NS  0.0V 220.0NS  0.0V 260.0NS  0.0V 280.0NS  0.0V
+    300.0NS  0.0V 359.9NS  0.0V 360.0NS  1.8V 380.0NS  1.8V 380.1NS 0.0V
+    400.0NS  0.0V 420.0NS  0.0V 460.0NS  0.0V 480.0NS  0.0V 
+    500.0NS  0.0V 559.9NS  0.0V 560.0NS  1.8V 580.0NS  1.8V 580.1NS 0.0V
+    600.0NS  0.0V)
******************************
**********word line***********   
******************************
.end  
      
