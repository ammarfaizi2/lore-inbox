Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317026AbSGCP3L>; Wed, 3 Jul 2002 11:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317030AbSGCP3K>; Wed, 3 Jul 2002 11:29:10 -0400
Received: from mail4.messagelabs.com ([212.125.75.12]:10501 "HELO
	mail4.messagelabs.com") by vger.kernel.org with SMTP
	id <S317026AbSGCP3J>; Wed, 3 Jul 2002 11:29:09 -0400
X-VirusChecked: Checked
Message-ID: <ABDA876D71F9D211B39D0090274EA8E20BC913E7@Floyd.logica.co.uk>
From: "Taylor, Neville" <TaylorNE@logica.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: /proc/pci
Date: Wed, 3 Jul 2002 16:31:32 +0100 
X-MS-TNEF-Correlator: <ABDA876D71F9D211B39D0090274EA8E20BC913E7@Floyd.logica.co.uk>
X-Mailer: Internet Mail Service (5.5.2653.19)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Anyone got any ideas why all the devices in my /proc/pci file show the rev,
Latency, Min Gnt and Max Lat as 255.

eg.

> Bus 0, device 8, function 0:
> Class ffff: Adaptec AHA-294x / AIC- 7871 ( rev 255)
>     IRQ 11
>     Master Capable. Latency=255. Min Gnt=255.Max Lat=255
>     I/O at 0xfc00 [0xfcff]
>     Non-prefetchable 32 bit memory at 0x3efff000 [0x3effffff]

begin 600 winmail.dat
M>)\^(B8/`0:0"``$```````!``$``0>0!@`(````Y`0```````#H``$(@`<`
M&````$E032Y-:6-R;W-O9G0@36%I;"Y.;W1E`#$(`0D`!``"``````````$(
M``4`!`````````````$%@`,`#@```-('!P`#`!``'P`@``,`-0$!((`#``X`
M``#2!P<``P`0`!\`)``#`#D!`0F``0`A````-34S-49&-#`V-$)!1#0T0T%$
M.4(U148P0T9&0D)"-3``B`<!!(`!``L````@+W!R;V,O<&-I`&X#`0V`!``"
M`````@`"``$#D`8`N`8``#`````#``&`""`&``````#`````````1@````!2
MA0``/W$!`!X``H`((`8``````,````````!&`````%2%```!````!````#DN
M,``+``.`""`&``````#`````````1@`````&A0````````,`!(`((`8`````
M`,````````!&``````&%````````"P`%@`@@!@``````P````````$8`````
M`X4````````+``:`""`&``````#`````````1@`````.A0````````,`!X`(
M(`8``````,````````!&`````!"%`````````P`(@`@@!@``````P```````
M`$8`````$84````````#``F`""`&``````#`````````1@`````8A0``````
M``(!"1`!````PP$``+\!``"P`@``3%I&=?FHJL@#``H`<F-P9S$R->(R`T-T
M97@%00$#`??_"H`"I`/D!Q,"@`_S`%`$5C\(50>R$24.40,!`@!C:.$*P'-E
M=#(&``;#$27V,P1&$[<P$BP1,PCO"?>V.Q@?#C`U$2(,8&,`4/,+"0%D,S86
M4`NF"N,*A!$*@$%N>0(@92!G1F\%0`!P>2!I`0!A.00@=V@>@`=``R!T:#L>
M``$`=@W@!Y$+@"!M*1Z`+W`#8&,@H&-IC"!F`Q`>`'-H;P?@@Q^"&"!V+"!,
M80ZPJ&YC>2)032!!1P(PY1Y19`7087@B8AY0!"`E&E$N'/IE9R2K/B`T0G4$
M(#`B4!_$(#C)(E!F=2*P=&D"(":P>CHF!D,+8`01`2`!(#HY$,!D804P!9`0
MP$A!4"TR.30CX"\0P$D`0RT@-S@W,2`V*"(2)&(I)@8L8DE2N%$@,1KS+#8C
MP',.L%T%P$,IH`&@(6`N(F8]/R1R(O8O0R/%+T(K^R]/4QY0!4`P>!/`,!90
M6ZLR0@$@72OZ3@(@+2"P3P$0%"`3T2Z!(#,40&)N:05`!X`$8'(?(3(B,[\!
M$0$P,H0V,RDA,R5]-_``'@!P``$````*````+W!R;V,O<&-I`````@%Q``$`
M```;`````<(BIE2)<&S\#/'`3Y:V&+TF"=)'-@``"DL@``,`+@``````"P`"
M``$````+`!<,``````,`74```````P`)60$````#`-X_KV\``$``.0#0W*NU
MIB+"`0,`\3\)!```'@`Q0`$````)````5$%93$]23D4``````P`:0``````>
M`#!``0````D```!405E,3U).10`````#`!E```````,`_3_D!````P`F````
M```#`#8```````,`@!#_____`@%'``$````U````8SU'0CMA/4%45$UA:6P[
M<#U,;V=I8V$[;#U&3$]91"TP,C`W,#,Q-3,Q,S):+38P,C8T-0`````"`?D_
M`0```$H`````````W*=`R,!"$!JTN0@`*R_A@@$`````````+T\]3$]'24-!
M+T]5/55++T-./4580TA!3D=%(%5315)3+T-./51!64Q/4DY%````'@#X/P$`
M```0````5&%Y;&]R+"!.979I;&QE`!X`.$`!````"0```%1!64Q/4DY%````
M``(!^S\!````2@````````#<IT#(P$(0&K2Y"``K+^&"`0`````````O3SU,
M3T=)0T$O3U4]54LO0TX]15A#2$%.1T4@55-%4E,O0TX]5$%93$]23D4````>
M`/H_`0```!````!487EL;W(L($YE=FEL;&4`'@`Y0`$````)````5$%93$]2
M3D4`````0``',':\<7ZF(L(!0``(,&*-R[>F(L(!'@`]``$````!````````
M`!X`'0X!````"P```"`O<')O8R]P8VD``!X`-1`!````/@```#Q!0D1!.#<V
M1#<Q1CE$,C$Q0C,Y1#`P.3`R-S1%03A%,C!"0SDQ,T4W0$9L;WED+FQO9VEC
M82YC;RYU:SX````+`"D```````L`(P```````P`&$,+0Q4L#``<0#P$```,`
M$!```````P`1$`$````>``@0`0```&4```!!3EE/3D5'3U1!3EE)1$5!4U=(
M64%,3%1(141%5DE#15-)3DU9+U!23T,O4$-)1DE,15-(3U=42$52158L3$%4
M14Y#62Q-24Y'3E1!3D1-05A,051!4S(U-45'0E53,"Q$159)``````(!?P`!
M````/@```#Q!0D1!.#<V1#<Q1CE$,C$Q0C,Y1#`P.3`R-S1%03A%,C!"0SDQ
<,T4W0$9L;WED+FQO9VEC82YC;RYU:SX```!Q6`==
`
end

This e-mail and any attachment is for authorised use by the intended recipient(s) only.  It may contain proprietary material, confidential information and/or be subject to legal privilege.  It should not be copied, disclosed to, retained or used by, any other party.  If you are not an intended recipient then please promptly delete this e-mail and any attachment and all copies and inform the sender.  Thank you.
