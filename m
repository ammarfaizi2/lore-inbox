Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264810AbTFQOsN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 10:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264780AbTFQOq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 10:46:27 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:52490 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264779AbTFQOnO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 10:43:14 -0400
MIME-Version: 1.0
To: torvalds@transmeta.com
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue_Jun_17_14_57_07_UTC_2003_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20030617145707.B13958401A@merlin.emma.line.org>
Date: Tue, 17 Jun 2003 16:57:07 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use bk receive to patch this mail, you can pull from
bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no trailing slash)
or you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
First step of BK and CVS resynchronization. (Ignore previous mail, it
was a resend of an old diff.)

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |    5 ++++-
# 1 files changed, 4 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.59    -> 1.60   
#	            shortlog	1.33    -> 1.34   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/17	matthias.andree@gmx.de	1.60
# Synchronize Matthias' CVS and Linus' BK trees.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Tue Jun 17 16:57:07 2003
+++ b/shortlog	Tue Jun 17 16:57:07 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.131 2003/06/16 10:49:57 vita Exp $
+# $Id: lk-changelog.pl,v 0.132 2003/06/17 14:53:29 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -1733,6 +1733,9 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.132  2003/06/17 14:53:29  emma
+# Rearrange Peter Milne's addresses.
+#
 # Revision 0.131  2003/06/16 10:49:57  vita
 # add 5 names for new addresses
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.59
## Wrapped with gzip_uu ##


begin 600 bkpatch11626
M'XL(`$,L[SX``[54;6_3,!#^7/^*DSJIH"VI[<1-8JG37CJ@%,14-+Y[R;6-
MFI<J3KJ"\N-Q$O;2`0,&)%:L\]T]OGORV'VXTEC(7JK*<A4K;:LL*A!)'][D
MNI2]9;JSH\:<Y[DQA[K2.%QCD6$R/)N9876&5>9YHHD)O%1EN((M%EKVF.W<
MK92?-RA[\XO75^].YX2,QW"^4MD2/V()XS$I\V*KDDB?;#!;5G%FEX7*=(JE
MLL,\K>]B:TXI-R_C#AV)H.;!2(@:.0H1NDQ=>[Z'(;^'6^4I/H5E4-C(S-3E
M->4.HV0"S!8!4&=(1T/F`1M)P:5@AY1+2N$14R<=0W#(P*+D#/YQ'^<DA/=8
M+!$RO`$5F2VU1FV3&3"/!^3RGD5B_>%#"%64',-37.E57I1)ONS*%<RGGNLQ
MOW:8%XAZ@8%:A!X-%,5(74<_(6</I2'<8Z[@@M;<I]QMM7`;L2>%OZ[GMZ'N
M5<!JZOJ^:%7@.-^I@/Y*!0Y8_'_*X%-<JH&&L`5H=="1^`&LXF;7#&MG5'';
MW#-$,6$,&)FVWSX<3",)R=KJ-C2(]B8YV@*UF<.@8:[E9P2,2C>0PH.M*1`N
M=ALX,!BN<9"!6LLP3PP):14:E@8P/H;!:1;%,$L0L\$1F7#>1$Z[:7"]B-&0
M)\.XC.TJC<.5C5'5Y;VUX:RH0H17;8Q)GCJ,-UF1RLR27<3E%VDRBG1MO\CR
M#%]VB9/6#7/C;I*89WYOT-QLN(UUG&??>OIA4VU7)M8<0!"0J10U+/)B_U"2
M_F,T^@#-E"@D]Z3#GXG&@P=HM!%D4YZ_A^8\@79W$X<K#->Z2L>,NDI1&I"O
([+L_*P8&````
`
end

