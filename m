Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbTKVPFU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 10:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTKVPFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 10:05:20 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:63212 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262315AbTKVPFF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 10:05:05 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Sat_Nov_22_15_05_02_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20031122150502.EEB2E999AA@merlin.emma.line.org>
Date: Sat, 22 Nov 2003 16:05:02 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Well, I cannot reach the parent directory. Is that a matter of the
ongoing BK troubles^Wcoroning after the break-in or has the tree moved?
I see kernel.bkbits.net and linux.bkbits.net have distinct addresses and
don't share their subnet.

Patch description:
ChangeSet@1.97, 2003-11-22 16:03:24+01:00, matthias.andree@gmx.de
  Two more addresses.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   15 +++++++++++++--
# 1 files changed, 13 insertions(+), 2 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.96    -> 1.97   
#	            shortlog	1.69    -> 1.70   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/11/22	matthias.andree@gmx.de	1.97
# Two more addresses.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Sat Nov 22 16:05:01 2003
+++ b/shortlog	Sat Nov 22 16:05:02 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.195 2003/11/19 16:08:02 emma Exp $
+# $Id: lk-changelog.pl,v 0.198 2003/11/22 14:59:50 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -416,6 +416,7 @@
 'ddstreet:ieee.org' => 'Dan Streetman',
 'ddstreet:us.ibm.com' => 'Dan Streetman',
 'dean:arctic.org' => 'Dean Gaudet',
+'debian:abeckmann.de' => 'Andreas Beckmann',
 'defouwj:purdue.edu' => 'Jeff DeFouw',
 'deller:gmx.de' => 'Helge Deller',
 'dent:cosy.sbg.ac.at' => "Thomas 'Dent' Mirlacher",
@@ -786,7 +787,8 @@
 'kisza:sch.bme.hu' => 'Andras Kis-Szabo', # google (netfilter-ext HOWTO)
 'kkeil:isdn4linux.de' => 'Karsten Keil',
 'kkeil:suse.de' => 'Karsten Keil',
-'klassert:mathematik.ru-chemnitz.de' => 'Steffen Klassert',
+'klassert:mathematik.ru-chemnitz.de' => 'Steffen Klassert', # typo, leave in
+'klassert:mathematik.tu-chemnitz.de' => 'Steffen Klassert',
 'kml:patheticgeek.net' => 'Kevin Lahey',
 'kmsmith:umich.edu' => 'Kendrick M. Smith',
 'knan:mo.himolde.no' => 'Erik Inge Bolsø',
@@ -2128,6 +2130,15 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.198  2003/11/22 14:59:50  emma
+# Add Andreas Beckmann's address.
+#
+# Revision 0.197  2003/11/21 21:13:59  emma
+# Re-add Steffen Klassert's typoed address, bug report by Vita.
+#
+# Revision 0.196  2003/11/20 23:30:18  emma
+# Fix Steffen Klassert's address.
+#
 # Revision 0.195  2003/11/19 16:08:02  emma
 # Add 2nd address of Atul Mukker of LSI Logic.
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.97
## Wrapped with gzip_uu ##


M'XL( !Y[OS\  [U4VV[:0!!]9K]B)"+Q$&SV@K&]$E&N;5$J-2)-W]?V !:^
M(.]"2.6/[P*!)$#4JVJOUEI[?.;,F:-IPH/&2C9R9<PD5=I515(ADB9\*K61
MC7&^=)/5<5B6]MC1<XV=*58%9IW+6[N<S<$Q99EI8@/OE(DGL,!*RP9SQ>Z-
M>9JA; QO/CY\OA@2TN_#U4058[Q' _T^,66U4%FBSV=8C.=IX9I*%3I'H]RX
MS.M=;,TIY?9F7-">%]8\['E>C1P]+^XR%?F!CS$G>_6<;^IX"R,88R'K,=KU
M:HM' W(-S U]H*+#6(=S8#U)A>3=4\HDI7 <%$X9.)1<PC\NX8K$\/6QA+RL
M$%1B,VJ-VB6W8+D*<O>B'W%^\R*$*DK.7AA/RASWZ.I)69FL'&_8>BR@?M=G
M02V8'WKU"$,UBGT:*HJ)BI)WM'F#8O7FG'E4<%%S/Q!B[8)MQ!L3_#6?]PRP
MQV?7_YZ@+%SWWZ<'_1<_Z[\ A_]/ VS4^P).];A<+6=I[; M[0_<<,T8,#)8
M[TTX&202LJD3K_E:1'>6M1= 718&L-)MJTY7>J'T*&">*[A9SN"$#+HLL""M
M!*-4%5)%&$]S5116IQ;TSZ!UL9).:;A\_M!JDVL_"%?I5P].6M-,V3HK(ZW<
M$[1;.G6KN66#>9&:[SND>X.C$19P^QS?:D-S-67*-F2H%@AI<1S,_!(8&7 F
M*(2KV8>+5*=E\2S!40W6(MC8BR2!@QKUMGTN:>[C^:_P&' FF;"0.[PA.O9?
M.."GUZ5BLD5N0S0?0X4S:P*(GN!;:EUWF*WW*AL%+J2@TG9LF^U#NCR6ZA7[
9W3RW$L93/<_[E-$HBA4C/P#B^L U3 8     
 

