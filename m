Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTKYDVf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 22:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbTKYDVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 22:21:34 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:49812 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262009AbTKYDVb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 22:21:31 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue_Nov_25_03_21_28_UTC_2003_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20031125032128.72D9E9D889@merlin.emma.line.org>
Date: Tue, 25 Nov 2003 04:21:28 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
ChangeSet@1.98, 2003-11-25 04:20:54+01:00, matthias.andree@gmx.de
  New address for Arkadiusz Miskiewicz.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |    6 +++++-
# 1 files changed, 5 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.97    -> 1.98   
#	            shortlog	1.70    -> 1.71   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/11/25	matthias.andree@gmx.de	1.98
# New address for Arkadiusz Miskiewicz.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Tue Nov 25 04:21:28 2003
+++ b/shortlog	Tue Nov 25 04:21:28 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.198 2003/11/22 14:59:50 emma Exp $
+# $Id: lk-changelog.pl,v 0.199 2003/11/25 03:20:04 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -217,6 +217,7 @@
 'anton:superego.ozlabs.ibm.com' => 'Anton Blanchard',
 'apolkosnik:directvinternet.com' => 'Adam Polkosnik',
 'arashi:yomerashi.yi.org' => 'Matt Reppert',
+'arekm:pld-linux.org' => 'Arkadiusz Miskiewicz', # lbdb
 'aris:cathedrallabs.org' => 'Aristeu Sergio Rozanski Filho',
 'arjan:redhat.com' => 'Arjan van de Ven',
 'arjanv:redhat.com' => 'Arjan van de Ven',
@@ -2130,6 +2131,9 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.199  2003/11/25 03:20:04  emma
+# New address for Arkadiusz Miskiewicz.
+#
 # Revision 0.198  2003/11/22 14:59:50  emma
 # Add Andreas Beckmann's address.
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.98
## Wrapped with gzip_uu ##


M'XL( +C*PC\  \54:VO;,!3]'/V*"RGD0VM'#RNV#"Y]LH7N43+Z Q1;B4UL
M*TC.H\4_?G:\-*2DL&Z#24)PQ=6Y]QP=U(<GJTS8*V15I9FTKBP3HQ3JPV=M
MJ[ W+[9NTH83K9MP:%=6#1?*E"H?WCPTR^D"I](ZMZA)?)15G,):&1OVB,M>
M3ZKGI0I[D_M/3U^N)PA%$=RFLIRK'ZJ"*$*5-FN9)_9JJ<KY*BO=RLC2%JJ2
M;JR+^C6WIAC39A+*\(B+FHH1Y[6BBO/8(W+J![Z**7K#YZKC<0S#"*&4<,RH
M5S=XF*$[(*X( +,A(4/* 7LAQ2'WSC$),8;3H'!.P,'H!OXQA5L4PS>U 9DT
MQ:R%F39P;18RR5;V!;YF=I&I31:_N.@!""44/1X41<X'!T)88G1YX)#J0KTA
M8%-MJES/N_XY";#O^22H&?$%KV=*R%GL8R&Q2N0T>4>M(Y3V!5K],?=J%@B!
M=[[89QS9XJ_[><\2;_OI',%JZ@>L<X1//NP(#@[YOX[HY/P.CMELV^5L&W_L
MN?Z!/>X( 8+&N[T/9^,DA'SAQ#L&#:*[S"_6@%TB!+1"[N5BK5S8 U44$NZW
M2SA#8TI$ S*01BV*<)DG3IZ5JZVKS7P T24,3E$:7$ ?\FDR;:\S"NV_,E'K
HS&:Z_%7V9-U=X2;W]V3K'SZP.%7QPJZ*B,VP&/F,HY]6T<WZ*P4     
 

