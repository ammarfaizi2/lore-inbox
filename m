Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263614AbUECJXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbUECJXP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 05:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263616AbUECJXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 05:23:15 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:42702 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263614AbUECJXI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 05:23:08 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon_May__3_09_23_04_UTC_2004_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20040503092304.51ABDB556C@merlin.emma.line.org>
Date: Mon,  3 May 2004 11:23:04 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:

ChangeSet@1.162, 2004-05-03 11:22:30+02:00, matthias.andree@gmx.de
  (vita) 5 new addresses

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |    7 ++++++-
# 1 files changed, 6 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/05/03 11:22:30+02:00 matthias.andree@gmx.de 
#   (vita) 5 new addresses
# 
# shortlog
#   2004/05/03 11:22:30+02:00 matthias.andree@gmx.de +6 -1
#   (vita) 5 new addresses
# 
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Mon May  3 11:23:04 2004
+++ b/shortlog	Mon May  3 11:23:04 2004
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.272 2004/05/01 14:57:38 emma Exp $
+# $Id: lk-changelog.pl,v 0.273 2004/05/03 09:05:17 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -413,6 +413,7 @@
 'corryk:us.ibm.com' => 'Kevin Corry',
 'cort:fsmlabs.com' => 'Cort Dougan',
 'coughlan:redhat.com' => 'Tom Coughlan',
+'coywolf:greatcn.org' => 'Coywolf Qi Hunt',
 'cpg:puchol.com' => 'Carlos Puchol',
 'cph:zurich.ai.mit.edu' => 'Chris Hanson',
 'cr:sap.com' => 'Christoph Rohland',
@@ -539,6 +540,7 @@
 'dtor_core:ameritech.net' => 'Dmitry Torokhov',
 'ducrot:poupinou.org' => 'Bruno Ducrot',
 'duncan.sands:math.u-psud.fr' => 'Duncan Sands',
+'dvrabel:com.rmk.(none)' => 'David Vrabel',
 'dwmw2:dwmw2.baythorne.internal' => 'David Woodhouse',
 'dwmw2:infradead.org' => 'David Woodhouse',
 'dwmw2:redhat.com' => 'David Woodhouse',
@@ -625,6 +627,7 @@
 'galak:blarg.somerset.sps.mot.com' => 'Kumar Gala',
 'ganadist:nakyup.mizi.com' => 'Cha Young-Ho',
 'gandalf:netfilter.org' => 'Martin Josefsson',
+'gandalf:winds.org' => 'Byron Stanoszek',
 'gandalf:wlug.westbo.se' => 'Martin Josefsson',
 'ganesh.venkatesan:intel.com' => 'Ganesh Venkatesan',
 'ganesh:tuxtop.vxindia.veritas.com' => 'Ganesh Varadarajan',
@@ -1286,6 +1289,7 @@
 'patmans:us.ibm.com' => 'Patrick Mansfield',
 'patrick.boettcher:desy.de' => 'Patrick Boettcher',
 'patrick:dreker.de' => 'Patrick Dreker', # lbdb
+'patrick:wildi.com' => 'Patrick Wildi',
 'paubert:iram.es' => 'Gabriel Paubert',
 'paul.clements:steeleye.com' => 'Paul Clements',
 'paul.mundt:timesys.com' => 'Paul Mundt', # google
@@ -1581,6 +1585,7 @@
 'stevef:linux-udp14619769uds.austin.ibm.com' => 'Steve French',
 'stevef:linux.local' => 'Steve French', # guessed
 'stevef:smfhome.smfdom' => 'Steve French',
+'stevef:smfhome.smfsambadom' => 'Steve French',
 'stevef:smfhome1.austin.rr.com' => 'Steve French',
 'stevef:smfhome2.austin.rr.com' => 'Steve French',
 'stevef:stevef95.austin.ibm.com' => 'Steve French',

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.162
## Wrapped with gzip_uu ##


M'XL( '@/ED   [U474_;,!1]KG_%E4 J")+:3MPTD8H8'QL5D\9 ;,]NXK91
M$[NRW;1,^?&SFP$"C0>V:8F5R/8]]YY[?.0]N#="9[V:6[LHN0FY++00: ^N
ME+%9;UYOP\)/;Y5RTX%9&S%8"BU%-3B[=B/H)H%5JC+(!=YPFR^@$=ID/1)&
M3ROV826RWNWEI_O/'VX1&H_A?,'E7-P)"^,QLDHWO"K,Z4K(^;J4H=5<FEI8
M'N:J;I]B6XHQ=2^A$1ZRM*7ID+%64,%8'A,^34:)R"EZU<]IU\?+-#%FF)"8
M)7'4NGP4HPL@(1E2P/$ LP&.@)",TBS"1YAF&,/OL\(1@0"C,_C'/9RC' Z:
MTO)#8"#%!GCAJAHC#+H&0C%#-\\:HN"=#T*88W3R3'JA:O&*L5DH;2LU[P@S
M,L))G)!1&Y$D9>U,I'R6)SCE6!1\6KPASXLL7O,(I]1U[C1/HV3GA,>(%T;X
M:SYOF> UG\X#M(U'*8L[#T3LW1X80D#^MP>\?E\@T)NM'\'6&>*QN3_PPP4A
M0-!D]]V#_4F10;4,\AUCES%<5<<-X) F$7CE?LF#TPRSC"3@6<+E=@7[:!(3
MYI+T<_6P4=4LFVOA[@ 9*CWOP_@$^N?=!GPMX6HM;?\835CLZ_:+1O.IJ#(G
M5JCK97@@E12''>J"-V4!WW8!'C*DB8?,W4EP5V53RL(\USA[T$K"G>52F1]B
MZ0&$CD8>L>)6E_G2(:JB].?2(6ZZ9?CNEW?Q;!3Y>&-%(V:9J6<[4[J_X?64
F%X_ .[\/'[60^<+AGNZ\?"'RI5G78W>N-)E.!?H)T(JHQW %    
 

