Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbTJPO0r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 10:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbTJPO0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 10:26:47 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:52403 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262971AbTJPO0l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 10:26:41 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Thu_Oct_16_14_26_38_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20031016142638.9343D96DB2@merlin.emma.line.org>
Date: Thu, 16 Oct 2003 16:26:38 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can pull from bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no
trailing slash) or in cases of dire need, you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
ChangeSet@1.92, 2003-10-16 16:26:12+02:00, matthias.andree@gmx.de
  11 new addresses

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   22 +++++++++++++++++++++-
# 1 files changed, 21 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.91    -> 1.92   
#	            shortlog	1.64    -> 1.65   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/10/16	matthias.andree@gmx.de	1.92
# 11 new addresses
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Thu Oct 16 16:26:38 2003
+++ b/shortlog	Thu Oct 16 16:26:38 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.187 2003/10/08 21:56:22 emma Exp $
+# $Id: lk-changelog.pl,v 0.190 2003/10/16 12:33:28 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -193,6 +193,7 @@
 'alext:fc.hp.com' => 'Alex Tsariounov',
 'alfre:ibd.es' => 'Alfredo Sanjuán',
 'aliakc:web.de' => 'Ali Akcaagac', # lbdb
+'amalysh:web.de' => 'Alexander Malysh',
 'ambx1:com.rmk.(none)' => 'Adam Belay',
 'ambx1:neo.rr.com' => 'Adam Belay',
 'amir.noam:intel.com' => 'Amir Noam',
@@ -404,6 +405,7 @@
 'davidm:wailua.hpl.hp.com' => 'David Mosberger',
 'davids:youknow.youwant.to' => 'David Schwartz', # google
 'davidvh:cox.net' => 'David van Hoose',
+'dax:gurulabs.com' => 'Dax Kelson',
 'dbrownell:users.sourceforge.net' => 'David Brownell',
 'ddstreet:ieee.org' => 'Dan Streetman',
 'ddstreet:us.ibm.com' => 'Dan Streetman',
@@ -477,6 +479,7 @@
 'eric.piel:bull.net' => 'Eric Piel',
 'eric:lammerts.org' => 'Eric Lammerts',
 'erik:aarg.net' => 'Erik Arneson',
+'erik:harddisk-recovery.nl' => 'Erik Mouw',
 'erik_habbinga:hp.com' => 'Erik Habbinga',
 'erikj:subway.americas.sgi.com' => 'Erik Jacobson',
 'erlend-a:us.his.no' => 'Erlend Aasland',
@@ -633,6 +636,7 @@
 'jamie:shareable.org' => 'Jamie Lokier',
 'jan.oravec:6com.sk' => 'Jan Oravec',
 'jan:zuchhold.com' => 'Jan Zuchhold',
+'janetmor:us.ibm.com' => 'Janet Morgan',
 'jani:astechnix.ro' => 'Jani Monoses',
 'jani:iv.ro' => 'Jani Monoses',
 'janiceg:us.ibm.com' => 'Janice M. Girouard',
@@ -769,6 +773,7 @@
 'khali:linux-fr.org' => 'Jean Delvare', # lbdb
 'khalid:fc.hp.com' => 'Khalid Aziz',
 'khalid_aziz:hp.com' => 'Khalid Aziz',
+'khc:pc.waw.pl' => 'Krzysztof Halasa',
 'khc:pm.waw.pl' => 'Krzysztof Halasa',
 'kiran:in.ibm.com' => 'Ravikiran G. Thirumalai',
 'kisza:sch.bme.hu' => 'Andras Kis-Szabo', # google (netfilter-ext HOWTO)
@@ -993,6 +998,7 @@
 'nkiesel:tbdnetworks.com' => 'Norbert Kiesel',
 'nlaredo:transmeta.com' => 'Nathan Laredo',
 'nmiell:attbi.com' => 'Nicholas Miell',
+'noah:caltech.edu' => 'Noah J. Misch',
 'nobita:t-online.de' => 'Andreas Busch',
 'nstraz:sgi.com' => 'Nathan Straz',
 'ntfs:flatcap.org' => 'Richard Russon', # lbdb
@@ -1051,6 +1057,7 @@
 'peter:bergner.org' => 'Peter Bergner',
 'peter:cadcamlab.org' => 'Peter Samuelson',
 'peter:chubb.wattle.id.au' => 'Peter Chubb',
+'peterc:chubb.wattle.id.au' => 'Peter Chubb',
 'peterc:gelato.unsw.edu.au' => 'Peter Chubb',
 'peterm:remware.demon.co.uk' => 'Peter Milne',
 'peterm:uk.rmk.(none)' => 'Peter Milne',
@@ -1079,6 +1086,7 @@
 'pmanolov:lnxw.com' => 'Petko Manolov',
 'pmenage:ensim.com' => 'Paul Menage',
 'porter:cox.net' => 'Matt Porter',
+'pp:ee.oulu.fi' => 'Pekka Pietikäinen',
 'pp:netppl.fi' => 'Pekka Pietikäinen',
 'ppc64:brule.rchland.ibm.com' => 'Peter Bergner',
 'prom:berlin.ccc.de' => 'Ingo Albrecht',
@@ -1128,6 +1136,7 @@
 'rjweryk:uwo.ca' => 'Rob Weryk',
 'rl:hellgate.ch' => 'Roger Luethi',
 'rlievin:free.fr' => 'Romain Lievin',
+'rmk+lkml:arm.linux.org.uk' => 'Russell King',
 'rmk:arm.linux.org.uk' => 'Russell King',
 'rmk:flint.arm.linux.org.uk' => 'Russell King',
 'rml:tech9.net' => 'Robert Love',
@@ -1300,6 +1309,7 @@
 'thornber:sistina.com' => 'Joe Thornber',
 'thunder:ngforever.de' => 'Thunder From The Hill',
 'tigran:aivazian.name' => 'Tigran Aivazian',
+'tigran:veritas.com' => 'Tigran Aivazian',
 'tim:physik3.uni-rostock.de' => 'Tim Schmielau',
 'timw:splhi.com' => 'Tim Wright',
 'tinglett:vnet.ibm.com' => 'Todd Inglett',
@@ -1394,6 +1404,7 @@
 'xavier.bru:bull.net' => 'Xavier Bru',
 'xkaspa06:stud.fee.vutbr.cz' => 'Tomas Kasparek',
 'xose:wanadoo.es' => 'Xose Vazquez Perez', # lbdb
+'y.rutschle:com.rmk.(none)' => 'Yves Rutschle',
 'ya:slamail.org' => 'Yaacov Akiba Slama',
 'yinah:couragetech.com.cn' => 'Yin Aihua',
 'yokota:netlab.is.tsukuba.ac.jp' => 'Yokota Hiroshi',
@@ -2097,6 +2108,15 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.190  2003/10/16 12:33:28  vita
+# 3 new addresses
+#
+# Revision 0.189  2003/10/13 09:14:23  vita
+# 6 new addresses
+#
+# Revision 0.188  2003/10/10 08:49:34  vita
+# 2 new addresses
+#
 # Revision 0.187  2003/10/08 21:56:22  emma
 # Merge Linus' changes.
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.92
## Wrapped with gzip_uu ##


M'XL( )ZJCC\  [U576_;-A1]CG[%!5+ &U(S)&5]$7#1M G6U$T7>.O#'FGI
MQM)$209)^2/PS]T/&24E3N*U&+H-LP4!),^Y]YYSKZ13^&)0BY-*6IL7TA!9
M9QK1.X4/C;'B9%EM2=8MYTWCEN>F-7A>HJY1G;^;N6L\+,:V:93Q'/!6VC2'
M-6HC3ACQ#SMVMT)Q,K_ZZ<NGB[GG3:?P/I?U$G]!"].I9QN]EBHS;U=8+]NB
M)E;+VE1H)4F;:G_ [CFEW/T9]VD8)'N>A$&P1XY!D$Z87$1QA"GWCO2\'72\
M#.,S2F/.@G@2[UT\/O$N@9&$ _7/&3UG(;!0\% P?D:YH!2^'A3.&(RI]P[^
M8PGOO108@QHW(#.7SQ@TW@P89]2[?3+/&W_GS_.HI-Z;IW+SIL*C6DW>:*N:
MY5!JP&(:32(6[WT6)<'^#A-YET8TD10SN<B^8<R+*,YL%K()#QG?^WX8QOT(
M/")>3,"_KN=;W3^JY]#\210FK&]^&'QW\[GK/OO?NC]8]S.,]6;;7>.MFX5'
M7?]@%"Y=#N9=]_=3>'6="5#E..V+=1')2KU> R4LH="9]F@-%[XO> SKPDJX
MVJ[@E8N1!"[(2%92[4PN-KAP_HQ@^@9&%PJWSC;4<-,?CEY[UQ,:=O!,;L6R
MU:V2"],9-1 NY19FJ$Q3]] HZ:"HBU+D4F=98<JQQK1Q;YD=J=7 N7+'<-.T
MFXX2^GTQO\L:;=5HT1I2+*JG!!^[ X?62]FGB*+.@5&9IV*5DHW<..4#<J;O
M=^;>-G?P02II9(=.!JEU(W.12F4QS0EF[4#X[';A(X&;PJ2]4D8#OX.OT*).
M19JWBX5+8:U"4F1$/O!NNV/W7+O3@17W):U6 I$TK6K)7?&(+$L)MP7:HORC
MJ+%7P)A/.[RNRC-55DI(71%5U.V6.)6D+0?NO'63I!3,BGK9TWS*.YHMEFY>
MA7/4M?19)W[M]^&B6,O[8O"*^4G?NAW1K74:%0H')RXQ^:%N:OQQ8/ZV1@/S
M!T3'XS1)(.F^);@N3-'4#X/UU<GJ1\MA_:-'X/2('R?/^#[01+")X/Z!'_X=
I/W[&IT!C,4F$/SGP^5_XAR]:FF-:FK::^N[50WD4>'\",'R]:4X'    
 

