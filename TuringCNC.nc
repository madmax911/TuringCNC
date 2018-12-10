

%
O6666 ( Name:  TuringCNC )

      ( Description:  Proof-of-concept cnc g-code program to break )
      ( up a job into smaller pieces [operations] and make each    )
      ( segment into multiple choices.  So, you can choose which   )
      ( Op 2 to use for a job.  The original and the one I'm       )
      ( testing for the sake of example. )

( Last modified Date:   5-8-2017   )
(             Reason:   Creation   )
(             Editor:   Max        )
(           Checksum:   7798       ) ( <--- Md5 Microhash )



( Microhash explaination.  A four-character change-indicator code - reduced down from md5 )

(                            MD5--------------------------MD5 )
( javascript:document.write("ce4d645d77f298bc0f149426be47e8b3".match(/.{1,8}/g).reduce((a, v) => a + v.split("").reduce( (a2, v2) => a2 + parseInt(v2, 16), 0 ).toString(16).charAt(1), "").toUpperCase()) )
( Browse to the above URL to calculate the Md5 Microhash )

( Yields: 7798 )

(=============Md5_comes_from_everything_BELOW_but_NOT_INCLUDING_this_line===========)

(Ops # 1234 - Example:                     )
#100 = 3241 ( xxxx - digits are operations )
            ( |||\___Op1                   )
            ( ||\___Op2                    )
            ( |\___Op3                     )
            ( \___Op4                      )

#101 = FIX[  #100                                          / 1000]( [3] )
#102 = FIX[ [#100 - [#101*1000]                          ] /  100]( [2] )
#103 = FIX[ [#100 - [#101*1000] - [#102*100]             ] /   10]( [4] )
#104 =       #100 - [#101*1000] - [#102*100] - [#103*10](           [1] )

          (  3241                                          / 1000 = [3].241 )
          ( [3241 -     3*1000]                            /  100 = [2].41  )
          ( [3241 -     3*1000  -     2*100]               /   10 = [4].1   )
          (  3241 -     3*1000  -     2*100  -     4*10           = [1]     )

                                                  (In example,  3241               )
                                                        (#101 = 3     Op1    = N13 )
                                                        (#102  = 2     Op2   = N22 )
                                                        (#103   = 4     Op3  = N34 )
                                                        (#104    = 1     Op4 = N41 )

#199 = 0    ( Loop? [1/0]:  1 = yes, 0 = no )

N1(---------------------------------------------------------Operation_1--)
GOTO [10 + #101] (10 + 3 = 13)

 N11(==========================Operation_1_Option_1=)

 GOTO 2
 N12(==========================Operation_1_Option_2=)

 GOTO 2
 N13(==========================Operation_1_Option_3=)

  (              Define some parameters )
  #191 =  1.5  ( Z depth )
  #192 =  0.05 ( Feed rate )
 
 GOTO 2
 N14(==========================Operation_1_Option_4=)
 
 GOTO 2
N2(---------------------------------------------------------Operation_2--)
GOTO [20 + #102] (20 + 2 = 22)

 N21(==========================Operation_2_Option_1=)
 
 GOTO 3
 N22(==========================Operation_2_Option_2=)

 (SAFTY initialization codes)

  G20     (Inches)
  G28 B0  (Home B axis to 0)
  G90     (Absolute positioning)

  M8      (Coolant on)

 GOTO 3
 N23(==========================Operation_2_Option_3=)

 GOTO 3
 N24(==========================Operation_2_Option_4=)

 GOTO 3
N3(---------------------------------------------------------Operation_3--)
GOTO [30 + #103] (30 + 4 = 34)
 
 N31(==========================Operation_3_Option_1=)

 GOTO 4
 N32(==========================Operation_3_Option_2=)

 GOTO 4
 N33(==========================Operation_3_Option_3=)

 GOTO 4
 N34(==========================Operation_3_Option_4=)

  G0
    Z0.1
  G1
    Z[-1 * #191] F[#192]

  M85(-------------------Eject)

 GOTO 4
N4(---------------------------------------------------------Operation_4--)
GOTO [40 + #104] (40 + 1 = 41)
 
 N41(==========================Operation_4_Option_1=)

  G91
  G28
     X0
     Z0

 GOTO 5
 N42(==========================Operation_4_Option_2=)

 GOTO 5
 N43(==========================Operation_4_Option_3=)

 GOTO 5
 N44(==========================Operation_4_Option_4=)

 GOTO 5
N5(---------------------------------------------------Final_Operation_5--)
  
 M30(-----------------Stop prog)

 IF[#199 EQ 1] GOTO 1
 GOTO 99

N99(------------------------------------End)

%

