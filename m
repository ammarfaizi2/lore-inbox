Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbUCORNL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 12:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbUCORNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 12:13:11 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:16044 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262704AbUCORND convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 12:13:03 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon_Mar_15_17_12_46_UTC_2004_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040315171247.772AAAAE5A@merlin.emma.line.org>
Date: Mon, 15 Mar 2004 18:12:47 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.133, 2004-03-12 23:59:32+01:00, matthias.andree@gmx.de
  Five new addresses.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |    7 ++++++-
# 1 files changed, 6 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/03/12 23:59:32+01:00 matthias.andree@gmx.de 
#   Five new addresses.
# 
# shortlog
#   2004/03/12 23:59:32+01:00 matthias.andree@gmx.de +6 -1
#   Five new addresses.
# 
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Mon Mar 15 18:12:45 2004
+++ b/shortlog	Mon Mar 15 18:12:45 2004
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.242 2004/03/08 15:40:55 vita Exp $
+# $Id: lk-changelog.pl,v 0.243 2004/03/12 22:59:31 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -839,6 +839,7 @@
 'kai:zephyr.physics.uiowa.edu' => 'Kai Germaschewski',
 'kala:pinerecords.com' => 'Tomas Szepe',
 'kambo77:hotmail.com' => 'Kambo Lohan',
+'kaneshige.kenji:jp.fujitsu.com' => 'Kenji Kaneshige', # lbdb
 'kanoj:vger.kernel.org' => 'Kanoj Sarcar', # sent by Arnaldo Carvalho de Melo
 'kanojsarcar:yahoo.com' => 'Kanoj Sarcar',
 'kaos:ocs.com.au' => 'Keith Owens',
@@ -1041,6 +1042,7 @@
 'michael.krauth:web.de' => 'Michael Krauth',
 'michael:metaparadigm.com' => 'Michael Clark',
 'michael_e_brown:dell.com' => 'Michael E. Brown', # lbdb
+'michaelc:cs.wisc.edu' => 'Mike Christie', # lbdb
 'michaelw:foldr.org' => 'Michael Weber', # google
 'michal:harddata.com' => 'Michal Jaegermann',
 'michal:logix.cz' => 'Michal Ludvig',
@@ -1112,6 +1114,7 @@
 'nahshon:actcom.co.il' => 'Itai Nahshon',
 'nathans:bruce.melbourne.sgi.com' => 'Nathan Scott',
 'nathans:sgi.com' => 'Nathan Scott',
+'naveenb:cisco.com' => 'Naveen Burmi', # lbdb
 'neilb:cse.unsw.edu.au' => 'Neil Brown',
 'neilt:slimy.greenend.org.uk' => 'Neil Turton',
 'nemosoft:smcc.demon.nl' => 'Nemosoft Unv.',
@@ -1174,6 +1177,7 @@
 'paubert:iram.es' => 'Gabriel Paubert',
 'paul.clements:steeleye.com' => 'Paul Clements',
 'paul.mundt:timesys.com' => 'Paul Mundt', # google
+'paul:kungfoocoder.org' => 'Paul Wagland', # lbdb
 'paulkf:microgate.com' => 'Paul Fulghum',
 'paulm:routefree.com' => 'Paul Mielke',
 'paulus:au1.ibm.com' => 'Paul Mackerras',
@@ -1242,6 +1246,7 @@
 'pp:ee.oulu.fi' => 'Pekka Pietikäinen',
 'pp:netppl.fi' => 'Pekka Pietikäinen',
 'ppc64:brule.rchland.ibm.com' => 'Peter Bergner',
+'prasanna:in.ibm.com' => 'Prasanna S. Panchamukhi', # lbdb
 'prom:berlin.ccc.de' => 'Ingo Albrecht',
 'proski:gnu.org' => 'Pavel Roskin',
 'proski:org.rmk' => 'Pavel Roskin',

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.133
## Wrapped with gzip_uu ##


M'XL(  WD54   [U476^;,!1]CG_%E5(I#RV.;2 $I%1=/]95V4?4JMJS S= 
M 1-A2#.)'S^3+$E3K0_=IH&%9/N>>\\]/K@/CQJKH%?(NDY2J:E4485(^O"I
MU'70BXLUC;KI?5F:Z5 W&H<95@KSX>74#&L[L>JRS#4Q@3-9APFLL-)!CU-[
MOU+_6&+0N[^Y??S\X9Z0R02N$JEB?, :)A-2E]5*YI&^6***FU31NI)*%UA+
M&I9%NX]M!6/"O%S8;.3ZK?!'KMNB0-<-'2[GWMC#4)!7_5QL^SA.XS";^8SQ
MD?!:DX\YY!HXY;8-S!DR>\@%"#MP_< 6IXP'C,'OL\(I!XN12_C'/5R1$#ZF
M*P2%SR C4U%KU)1,P9#UR.P@(+'>^1#")"/G!\9)6> KNCHIJSHOXRU;EX^9
MYWA\W-K<\]UV@;Y<A![S)<-(SJ,WM#G*8@3G0@C7MT7K,H^Y&QOL(HY<\-=\
MWG+ *SY[ XBQR]C6 &ST;@.,P.+_TP!;];Z!53VONV&MC1UVK?V!&ZXY!T[N
M-M\^G-Q% >29%6[XFHQTF9^M@%'AV-#IMA-';,3A@$4AX6:]A!-R-W:Z)(-,
M*M1)&B/-4#VEP=.2+IJGM-9-)\4 )N<PF'8[,-U%#LZ@#_D\FALBS%0R68K4
M<, \#$)-GU,=4HR:+?9+FJ'Y :I4U^D1DG.G0RJY0E3S(#2H\E#RZV89+INJ
M2(]0WJA#+663!UFCXD59AF6$%2VK>(N<F2WX+N/<'/U+I' V]9:5U%(I&9A3
M3^?%H>+LUP8\4',3*M-/T63)B^+[&S),,,QT4TPBMK#'OB?(3RD&2E.>!0  
 

