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
.SUBCKT DRM   BL  NBL  WL0  WL1  WL2  
MN0     CA0   WL0   BL   VS   NCH	l=45nm w=90NM m=1
MN1     CA1   WL1   BL   VS   NCH	l=45nm w=90NM m=1
MN2     CA2   WL2   BL   VS   NCH	l=45nm w=90NM m=1
C0    	CA0   VSS   5fF
C1    	CA1   VSS   5fF
C2    	CA2   VSS   5fF
.ENDS

*****************************SENSE_AMPLIFIER***********************

.SUBCKT SA    SE    NSE    BL    NBL
***.SUBCKT  SA   BL   NBL
MP0     BL   NBL   AA0    VD    PCH      l=40nm w=360NM m=1
MP1     NBL  BL    AA0    VD    PCH      l=40nm w=360NM m=1
MP2     AA0  NSE   VD     VD    PCH      l=40nm w=360NM m=1

MN0     BL   NBL   BB0    VS    NCH      l=40nm w=180NM m=1
MN1     NBL  BL    BB0    VS    NCH      l=40nm w=180NM m=1
MN2     BB0  SE    VS     VS    NCH      l=40nm w=180NM m=1
.ENDS

*****************************WRITE***************************
.SUBCKT WRITE WREN  WR  BL
MN0     WR   WREN   BL  VS   NCH    l=40nm w=180nm m=1   
.ENDS

.SUBCKT PRECH VH BL NBL PRE
MN0    VH    PRE    BL    VS    NCH    l=40nm w=80nm m=1
MN1    VH    PRE    BLN   VS    NCH    l=40nm w=80nm m=1
MN2    BL    PRE    BLN   VS    NCH    l=40nm w=80nm m=1
.ENDS


***initial 
X_WRIT0  WREN0  WR0  BLP0  WRITE
****X_WRIT1  WREN1  WR1  BLP1  WRITE
****X_WRIT2  WREN2  WR2  BLP2  WRITE
****X_WRIT3  WREN3  WR3  BLP3  WRITE
****X_WRIT4  WREN4  WR4  BLP4  WRITE
****X_WRIT5  WREN5  WR5  BLP5  WRITE
****X_WRIT6  WREN6  WR6  BLP6  WRITE
****X_WRIT7  WREN7  WR7  BLP7  WRITE

***dram_cell
X_DRMP0  BLP0 BLN0  WLP0 WLP1 WLP2  DRM
****X_DRMP1  BLP1 BLN1  WLP0 WLP1 WLP2  DRM
****X_DRMP2  BLP2 BLN2  WLP0 WLP1 WLP2  DRM
****X_DRMP3  BLP3 BLN3  WLP0 WLP1 WLP2  DRM
****X_DRMP4  BLP4 BLN4  WLP0 WLP1 WLP2  DRM
****X_DRMP5  BLP5 BLN5  WLP0 WLP1 WLP2  DRM
****X_DRMP6  BLP6 BLN6  WLP0 WLP1 WLP2  DRM
****X_DRMP7  BLP7 BLN7  WLP0 WLP1 WLP2  DRM

***sense_amplifier
X_SA0  SE0  NSE0  BLP0  BLN0  SA
****SA1  SE1  NSE1  BLP1  BLN1  SA
****X_SA2  SE2  NSE2  BLP2  BLN2  SA
****X_SA3  SE3  NSE3  BLP3  BLN3  SA
****X_SA4  SE4  NSE4  BLP4  BLN4  SA
****X_SA5  SE5  NSE5  BLP5  BLN5  SA
****X_SA6  SE6  NSE6  BLP6  BLN6  SA
****X_SA7  SE7  NSE7  BLP7  BLN7  SA

******Prechage****************
X_PRE0  VH  BLP0  BLN0  PRE  PRECH
******************************

**********initial*************    
******************************
V000 WREN0  0
+PWL ( 0.0NS  0.0V   0.1NS  0.0V  21.0NS  0.0V  21.1NS  1.8V  29.0NS  1.8V  29.1NS  0.0V
+     51.0NS  0.0V  51.1NS  1.8V  60.0NS  1.8V  60.1NS  0.0V
+     81.0NS  0.0V  81.1NS  1.8V  90.0NS  1.8V  90.1NS  0.0V
+     100.0NS 0.0V  110.0NS 0.0V)



V010 WR0  0
+PWL ( 0.0NS 0.00V  21.1NS 0.00V  21.2NS  0.9V  30.1NS  0.9V 30.2NS  0.0V 
+     51.1NS 0.00V  51.2NS  0.9V  60.0NS  0.9V  60.1NS 0.00V
**+     51.1NS 0.00V  51.2NS 0.00V  60.0NS 0.00V  60.1NS 0.00V
+     81.1NS 0.00V  81.2NS 0.00V  90.0NS 0.00V  90.1NS 0.00V)

**********precharge***********
V300 PRE 0
+PWL ( 0.0NS 0.00V   10.0NS 1.8V  20.0NS  1.8V  20.1NS 0.0V
+     40.0NS 0.00V   40.1NS 1.8V  50.0NS  1.8V  50.1NS 0.0V
+     70.0NS 0.00V   70.1NS 1.8V  80.0NS  1.8V  80.1NS 0.0V
+    100.0NS 0.00V  100.1NS 1.8V 103.0NS  1.8V 103.1NS 0.0V
)

V400 SE0 0
+PWL ( 0.0NS 0.00V   21.0NS 0.00V  21.1NS  0.0V  40.0NS 0.0V  90.0NS  0.0V
+    105.0NS 0.00V  105.1NS  1.8V 110.0NS  1.8V 110.1NS 1.8V)

V401 NSE0 0
+PWL ( 0.0NS  1.8V   21.0NS  1.8V  21.1NS  1.8V  40.0NS 1.8V  90.0NS  1.8V
+    105.0NS  1.8V  105.1NS  0.0V 110.0NS  0.0V 110.1NS 0.0V)

******************************
**********word line***********   
******************************
***pos_side***

V200 WLP0  0
+PWL ( 0.0NS 0.00V   0.1NS  1.8V  20.0NS  1.8V  30.0NS  1.8V  30.1NS  0.0V
+     50.0NS  0.0V  60.0NS  0.0V  70.0NS  0.0V 100.0NS  0.0V
+    103.2NS  0.0V 103.3NS  1.8V 110.0NS  1.8V 110.1NS  0.0V)
**+    200.0NS  0.0V 219.9NS  0.0V 220.0NS  1.8V 240.0NS  1.8V 240.1NS  0.0V 
**+    250.0NS  0.0V 260.0NS  0.0V 270.0NS  0.0V 300.0NS  0.0V
**+    320.0NS  0.0V 340.0NS  0.0V 360.0NS  0.0V 380.0NS  0.0V 
**+    400.0NS  0.0V 419.0NS  0.0V 420.0NS  1.8V 440.0NS  1.8V 440.1NS  0.0V
**+    450.0NS  0.0V 460.0NS  0.0V 470.0NS  0.0V 500.0NS  0.0V
**+    520.0NS  0.0V 540.0NS  0.0V 570.0NS  0.0V 600.0NS  0.0V)


V201 WLP1  0
+PWL ( 0.0NS 0.00V  31.1NS  0.0V  31.2NS  1.8V  60.0NS  1.8V  60.1NS 0.0V
+    103.2NS  0.0V 103.3NS  1.8V 110.0NS  1.8V 110.1NS  0.0V)
**+    200.0NS  0.0V 259.9NS  0.0V 260.0NS  1.8V 280.0NS  1.8V 280.1NS 0.0V
**+    300.0NS  0.0V 320.0NS  0.0V 360.0NS  0.0V 380.0NS  0.0V
**+    400.0NS  0.0V 459.9NS  0.0V 460.0NS  1.8V 480.0NS  1.8V 480.1NS 0.0V
**+    500.0NS  0.0V 540.0NS  0.0V 580.0NS  0.0V 600.0NS  0.0V)


V202 WLP2  0
+PWL ( 0.0NS  0.0V  60.1NS  0.0V  60.2NS  1.8V  90.0NS  1.8V  90.1NS 0.0V
+    103.2NS  0.0V 103.3NS  1.8V 110.0NS  1.8V 110.1NS  0.0V)
**+    160.0NS  0.0V 170.0NS  0.0V 180.0NS  0.0V 190.0NS  0.0V
**+    200.0NS  0.0V 220.0NS  0.0V 260.0NS  0.0V 280.0NS  0.0V
**+    300.0NS  0.0V 319.9NS  0.0V 320.0NS  1.8V 340.0NS  1.8V 340.1NS 0.0V
**+    360.0NS  0.0V 370.0NS  0.0V 380.0NS  0.0V 390.0NS  0.0V
**+    400.0NS  0.0V 420.0NS  0.0V 460.0NS  0.0V 480.0NS  0.0V
**+    500.0NS  0.0V 519.9NS  0.0V 520.0NS  1.8V 540.0NS  1.8V 540.1NS 0.0V
**+    560.0NS  0.0V 570.0NS  0.0V 580.0NS  0.0V 600.0NS  0.0V)


******************************
**********word line***********   
******************************
.end  
      
