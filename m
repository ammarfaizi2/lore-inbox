Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTFDSuw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 14:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263837AbTFDSuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 14:50:52 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:59399 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263823AbTFDSur convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 14:50:47 -0400
MIME-Version: 1.0
To: torvalds@transmeta.com
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Wed_Jun__4_19_04_14_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030604190414.9B6FE89AEA@merlin.emma.line.org>
Date: Wed,  4 Jun 2003 21:04:14 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use bk receive to patch this mail, you can pull from
bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no trailing slash)
or you can apply the patch below.

Patch description:
10 new shiny address -> name mappings. No code changes. Please pull.

Matthias
##### DIFFSTAT #####
# shortlog |   24 +++++++++++++++++++++++-
# 1 files changed, 23 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.53    -> 1.54   
#	            shortlog	1.27    -> 1.28   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/04	matthias.andree@gmx.de	1.54
# Ten new address -> name mappings.
# (Upstream update from 0.120 to 0.124)
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Wed Jun  4 21:04:14 2003
+++ b/shortlog	Wed Jun  4 21:04:14 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.120 2003/05/29 11:11:22 vita Exp $
+# $Id: lk-changelog.pl,v 0.124 2003/06/04 10:31:18 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -208,6 +208,7 @@
 'bde:nwlink.com' => 'Bruce D. Elliott',
 'bdschuym:pandora.be' => 'Bart De Schuymer',
 'beattie:beattie-home.net' => 'Brian Beattie', # from david.nelson
+'bellucda:tiscali.it' => 'Daniele Bellucci',
 'benh:kernel.crashing.org' => 'Benjamin Herrenschmidt',
 'benh:zion.wanadoo.fr' => 'Benjamin Herrenschmidt',
 'bergner:brule.rchland.ibm.com' => 'Peter Bergner',
@@ -331,6 +332,7 @@
 'davidm:tiger.hpl.hp.com' => 'David Mosberger',
 'davidm:wailua.hpl.hp.com' => 'David Mosberger',
 'davids:youknow.youwant.to' => 'David Schwartz', # google
+'davidvh:cox.net' => 'David van Hoose',
 'dbrownell:users.sourceforge.net' => 'David Brownell',
 'ddstreet:ieee.org' => 'Dan Streetman',
 'ddstreet:us.ibm.com' => 'Dan Streetman',
@@ -461,6 +463,7 @@
 'hannal:us.ibm.com' => 'Hanna V. Linder',
 'harald:gnumonks.org' => 'Harald Welte',
 'haveblue:us.ibm.com' => 'Dave Hansen',
+'hawkes:oss.sgi.com' => 'John Hawkes',
 'hch:caldera.de' => 'Christoph Hellwig',
 'hch:com.rmk.(none)' => 'Christoph Hellwig',
 'hch:de.rmk.(none)' => 'Christoph Hellwig',
@@ -485,6 +488,7 @@
 'hpa:zytor.com' => 'H. Peter Anvin',
 'hugh:veritas.com' => 'Hugh Dickins',
 'hunold:convergence.de' => 'Michael Hunold',
+'hwahl:hwahl.de' => 'Hartmut Wahl',
 'ica2_ts:csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
 'info:usblcd.de' => 'Adams IT Services',
 'ink:jurassic.park.msu.ru' => 'Ivan Kokshaysky',
@@ -554,9 +558,11 @@
 'jh:sgi.com' => 'John Hesterberg',
 'jhammer:us.ibm.com' => 'Jack Hammer',
 'jhartmann:addoes.com' => 'Jeff Hartmann',
+'jim.houston:attbi.com' => 'Jim Houston',
 'jkenisto:us.ibm.com' => 'James Keniston',
 'jkt:helius.com' => 'Jack Thomasson',
 'jmcmullan:linuxcare.com' => 'Jason McMullan',
+'jmm:informatik.uni-bremen.de' => 'Moritz Mühlenhoff',
 'jmorris:intercode.com.au' => 'James Morris',
 'jmorros:intercode.com.au' => 'James Morris',	# it's typo IMHO
 'jo-lkml:suckfuell.net' => 'Jochen Suckfuell',
@@ -652,6 +658,7 @@
 'lee:compucrew.com' => 'Lee Nash', # lbdb
 'legoll:free.fr' => 'Vincent Legoll', # correction sent by himself
 'leigh:solinno.co.uk' => 'Leigh Brown', # lbdb
+'lethal:linux-sh.org' => 'Paul Mundt',
 'levon:movementarian.org' => 'John Levon',
 'lfo:polyad.org' => 'Luis F. Ortiz',
 'linux:brodo.de' => 'Dominik Brodowski',
@@ -799,6 +806,7 @@
 'oliver:neukum.name' => 'Oliver Neukum',
 'oliver:neukum.org' => 'Oliver Neukum',
 'oliver:oenone.homelinux.org' => 'Oliver Neukum',
+'oliver:vermuden.neukum.org' => 'Oliver Neukum',
 'olof:austin.ibm.com' => 'Olof Johansson',
 'orjan.friberg:axis.com' => 'Orjan Friberg',
 'os:emlix.com' => 'Oskar Schirmer', # sent by himself
@@ -882,6 +890,7 @@
 'rct:gherkin.frus.com' => 'Bob Tracy',
 'rddunlap:osdl.org' => 'Randy Dunlap',
 'reality:delusion.de' => 'Udo A. Steinberg',
+'reeja.john:amd.com' => 'Reeja John',
 'reiser:namesys.com' => 'Hans Reiser',
 'rem:osdl.org' => 'Bob Miller',
 'rgcrettol@datacomm.ch' => 'Roger Crettol',
@@ -945,6 +954,7 @@
 'sawa:yamamoto.gr.jp' => 'sawa',
 'scameron:quandary.cca.cpqcorp.net' => 'Steve Cameron',
 'schlicht:uni-mannheim.de' => 'Thomas Schlichter',
+'schlicht:uni-mannheimn.de' => 'Thomas Schlichter',	# it's typo IMHO
 'shmulik.hen:intel.com' => 'Shmulik Hen',
 'schoenfr:gaaertner.de' => 'Erik Schoenfelder',
 'schwab:suse.de' => 'Andreas Schwab',
@@ -1700,6 +1710,18 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.124  2003/06/04 10:31:18  vita
+# added 3 names for new addresses
+#
+# Revision 0.123  2003/06/03 05:49:53  vita
+# added 2 names for new addresses
+#
+# Revision 0.122  2003/06/02 09:11:21  emma
+# Fix umlaut in Moritz Mühlenhoff's name.
+#
+# Revision 0.121  2003/06/02 08:56:16  vita
+# added 5 names for new addresses
+#
 # Revision 0.120  2003/05/29 11:11:22  vita
 # added 2 names for new addresses
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.54
## Wrapped with gzip_uu ##


begin 600 bkpatch9001
M'XL(`*Y"WCX``\U576_;-A1]CG[%!5S`&QHI)"79%@$'79IVR;HL0=I@SXQT
M;3$624.D'+?P3]_#*#IUXK3=]\-LF;"H<\^]]_!0',"-Q98?*.%<+85-A*Y:
MQ&@`9\8Z?C!7ZZ3J;Z^-\;='MK-XM,!68W-T\LY?\?8F=L8T-O+`*^'*&E;8
M6GY`DW0WXSXND1]<O_GQYN<?KJ-H.H77M=!S?(\.IM/(F78EFLJ^6J*>=U(G
MKA7:*G0B*8W:[+`;1@CS7\I2,LJ+#2M&>;Y!AGE>9E3<CB=C+%GTK)]7VS[V
M:5*2LX)2EN5DD^=TPJ)3H$F>`4F/R.B(9,`H)RDGY"5A?H2OD\)+"C&)3N`_
M;N%U5,('U*#Q'D3E$UH+\3%HH=!7LEQ*/;>)QWQWL[2N1:&@6U;"(<Q:HX`D
ME!%?4OB3?1^]@[[%-+IZE#V*_^8GBH@@T?%CH[51^*Q+6YO6-6:^;=*G).-L
M3">;E(Z+?#/#0LS*,2D$P4K<5M^0=(_%BT0R6A#FI4I)-LZ">3XC]KSSK^OY
MEF_VZWFP3>;KR4B6!]NPR;YM&,^+/[$-2R&F_W_?;#6_A+B]7_=7O/8F^BS(
M/_#0*:5`H_,P#N#%><6A6<1EZ-(S)LOF<+7-#KW:#YI2PE/*Z016T@EXLU["
MB^B<4>))AK?8-%U9">ZD+44C$^F&,#V&X:G0$AN$DP`HY?`P.D_3M(^IQ$I6
MJYJ79IUHW.'])*R$]F\_8[&'9Z,`K\7]`BTWUB9V+OMUV4;\9&H/#@\#>C(.
MZ'M1-SR,?J6WR#/1.M4Y^-5/]M`\'_70.ZF2VG36&<V]3VZ?<DOEZPB/M@%%
M"%"*2STSK;>57"2=EO%MBPKU+M.%::7[!!>_U0WJVLQF??3(O]=\=(.N%@UO
MI.[6L:T3T\ZW05>B:^"BTY7KT1/2K\[0--*_R+G_J:[R&31VBTX]!EV&Y_!+
MF`YQDY#%N_Q.)'=>&RY4]=C1=3\/O68]N,B"6+:L&UG6CO>M**%UC5(]=O/!
M;VIAX?T#"MOAX<$`_`K;_D@Q<'YQ=NG=-"8,*.L/*EQ)*XU^L-!7/11,Y+%^
M>V`%:=@;%KRF3S<-VFCPG"]]PI<"R7E6\#Q]QL?^.A][PL>`%)Q2SB@`*M7S
MO95KZ%0CO&VDAB_7U89,R9>\=)]WPO,1IZ-G=>9_4.?NV"YK+!>V4U/B%<[*
,:A;]#OC..68S"```
`
end

