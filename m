Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbTLTXiJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 18:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTLTXgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 18:36:51 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:3758 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261825AbTLTXgh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 18:36:37 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Sat_Dec_20_23_36_27_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20031220233627.F3FD09766C@merlin.emma.line.org>
Date: Sun, 21 Dec 2003 00:36:27 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.105, 2003-12-21 00:35:32+01:00, matthias.andree@gmx.de
  Marcus Alanen: Fix Kai Mäkisara's name spelling.
  Vitezslav Samel: Eight new mappings.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   25 +++++++++++++++++++++----
# 1 files changed, 21 insertions(+), 4 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.104   -> 1.105  
#	            shortlog	1.77    -> 1.78   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/12/21	matthias.andree@gmx.de	1.105
# Marcus Alanen: Fix Kai Mäkisara's name spelling.
# Vitezslav Samel: Eight new mappings.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Sun Dec 21 00:36:27 2003
+++ b/shortlog	Sun Dec 21 00:36:27 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.203 2003/12/06 16:40:13 emma Exp $
+# $Id: lk-changelog.pl,v 0.206 2003/12/20 23:32:45 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -234,6 +234,7 @@
 'aschultz:warp10.net' => 'Andreas Schultz',
 'asit.k.mallick:intel.com' => 'Asit K. Mallick', # by Kristian Peters
 'asl:launay.org' => 'Arnaud S. Launay',
+'aspicht:arkeia.com' => 'Arnaud Spicht',
 'atulm:lsil.com' => 'Atul Mukker',
 'atul.mukker:lsil.com' => 'Atul Mukker',
 'axboe:burns.home.kernel.dk' => 'Jens Axboe', # guessed
@@ -309,6 +310,9 @@
 'cananian:lesser-magoo.lcs.mit.edu' => 'C. Scott Ananian',
 'car.busse:gmx.de' => 'Carsten Busse',	# verified by Greg KH
 'cat:zip.com.au' => 'CaT',
+'cattelan:lupo.thebarn.com' => 'Russell Cattelan',
+'cattelan:naboo.americas.sgi.com' => 'Russell Cattelan',
+'cattelan:naboo.eagan' => 'Russell Cattelan',
 'cattelan:sgi.com' => 'Russell Cattelan', # google
 'ccaputo:alt.net' => 'Chris Caputo',
 'ccheney:cheney.cx' => 'Christopher L. Cheney',
@@ -740,7 +744,8 @@
 'jsimmons:kozmo.(none)' => 'James Simmons',
 'jsimmons:maxwell.earthlink.net' => 'James Simmons',
 'jsimmons:transvirtual.com' => 'James Simmons',
-'jsm:udlkern.fc.hp.com' => 'John Marvin',
+'jsm:fc.hp.com' => 'John S. Marvin',
+'jsm:udlkern.fc.hp.com' => 'John S. Marvin',
 'jsun:mvista.com' => 'Jun Sun',
 'jt:bougret.hpl.hp.com' => 'Jean Tourrilhes',
 'jt:hpl.hp.com' => 'Jean Tourrilhes',
@@ -754,7 +759,7 @@
 'kaber:trash.net' => 'Patrick McHardy',
 'kadlec:blackhole.kfki.hu' => 'Jozsef Kadlecsik',
 'kai-germaschewski:uiowa.edu' => 'Kai Germaschewski',
-'kai.makisara:kolumbus.fi' => 'Kai Makisara',
+'kai.makisara:kolumbus.fi' => 'Kai Mäkisara',
 'kai.reichert:udo.edu' => 'Kai Reichert',
 'kai:chaos.tp1.ruhr-uni-bochum.de' => 'Kai Germaschewski',
 'kai:germaschewski.name' => 'Kai Germaschewski',
@@ -813,6 +818,7 @@
 'kunihiro:ipinfusion.com' => 'Kunihiro Ishiguro',
 'kurt.robideau:comtrol.com' => 'Kurt Robideau',	# wild guess
 'kyle:debian.org' => 'Kyle McMartin',
+'kyle:engsoc.carleton.ca' => 'Kyle McMartin',
 'l.s.r:web.de' => 'René Scharfe',
 'ladis:psi.cz' => 'Ladislav Michl',
 'laforge:gnumonks.org' => 'Harald Welte',
@@ -873,7 +879,7 @@
 'maalanen:ra.abo.fi' => 'Marcus Alanen',
 'mac:melware.de' => 'Armin Schindler',
 'macro:ds2.pg.gda.pl' => 'Maciej W. Rozycki',
-'makisara:abies.metla.fi' => 'Kai Makisara',
+'makisara:abies.metla.fi' => 'Kai Mäkisara',
 'maloi:phota.to' => 'Andy Molloy',
 'malte.d:gmx.net' => 'Malte Doersam', # google
 'manand:us.ibm.com' => 'Mala Anand',
@@ -998,6 +1004,7 @@
 'mzyngier:freesurf.fr' => 'Marc Zyngier',
 'n0ano:n0ano.com' => 'Don Dugger',
 'nahshon:actcom.co.il' => 'Itai Nahshon',
+'nathans:bruce.melbourne.sgi.com' => 'Nathan Scott',
 'nathans:sgi.com' => 'Nathan Scott',
 'neilb:cse.unsw.edu.au' => 'Neil Brown',
 'neilt:slimy.greenend.org.uk' => 'Neil Turton',
@@ -1412,6 +1419,7 @@
 'wensong:linux-vs.org' => 'Wensong Zhang',
 'wes:infosink.com' => 'Wes Schreiner',
 'wesolows:foobazco.org' => 'Keith M. Wesolowski',
+'wessmith:sgi.com' => 'Wesley Smith',
 'wg:malloc.de' => 'Wolfram Gloger', # lbdb
 'whitney:math.berkeley.edu' => 'Wayne Whitney',
 'whydoubt:yahoo.com' => 'Jeff Smith',
@@ -2142,6 +2150,15 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.206  2003/12/20 23:32:45  emma
+# Resolve conflict with Linus' version.
+#
+# Revision 0.205  2003/12/11 14:08:38  vita
+# new translations to cover 2.4.24-pre1
+#
+# Revision 0.204  2003/12/07 18:30:25  emma
+# Fix Kai Mäkisara's name. Patch by Marcus Alanen.
+#
 # Revision 0.203  2003/12/06 16:40:13  emma
 # Add two addresses, three still nknown since 2.4.23.
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.105
## Wrapped with gzip_uu ##


M'XL( /O<Y#\  ]5576_;-A1]#G_%!5+ #ZUI4A^63,!%TR3;O#1;$:/;,TW3
M%F=*%$3*20;_W/V07<E)#*<)BFY[F2U(D'C.N;SW'I*G\,7K1IR4,H3"2$]E
MM6RT)J?PD_-!G*S+.[KL7F^<P]>1;[T>;713:3OZ>(77</\R#,Y93Q#X6095
MP%8W7IQP&C]]"?>U%B<WES]^^71V0\AT"N>%K-9ZK@-,IR2X9BOMTG^H=;5N
M345#(RM?ZB"I<N7N";N+&(OPSZ.8C=/)+IJ,TW2G(YVF*N%RD>695A%YEL^'
M?1[',C&/4"F.69+M4(^-R05PRED*+![Q:!1Q8$S$J8BCMXP+QN!E57C+8<C(
M1_B/<S@G"JYEHUH/9U96NA+P@[F#*VG@^J^-\;*1 P^5+#7X6EMKJC5%RF\F
MZ#^]E5N8XY 5<&G618!*W^+\ZQI1GI(KP(1S\OG0!#+\SA\A3#+R_I!UX4K]
M+&5?N"98M]YGG/*<94G&\UW,LTFZ6^F)7*F,32332[E8OE+?(Y7'IJ4QWT7C
M),MZ*STBCISTK^?SFHM>F@]+QKN$)7G6FRC+O_(0_X:'$#E,_F\FVG?@5Q@V
MMW?=-;Q#2SV6YQ\XZH)SX&36WT_AS6PIP&Z&JL\9%6EMWVV!45RKT-6^KS"#
M*,8E*I(4=%E*N+RKX0V91?$810;2UT850<AFHTU?P@%,W\/@K*EDNX1Y/SIX
M1V8Q!HW)0&%[-!9*V+9V-!1Z(9OJ0+MIO<<JP?D##)D'2B47SE&L5V,4-MBO
MS7<1M5SC]]?0%UD2=[7I'A$9_.%+L5*TJ \A?G9%!7/:M7MK^@ =J%W:;HNF
MWP)?9&G6Z_>/P48:6LJ]0<3&V;9<M)ZNS)Y]9!\L7L[3GG1OM4#;>J>HDHW5
MP6'MY ,'!^%:8<"P#YAG78=F^\?@*9A<&.TI&M[*5^-QABL)294,Z TO%DVK
M-'+LPK5X'!V7_I<>!'/E0M]IGO"D(]]J[TL3"G&$_EU[J^]AWHUTZ(@G"4RZ
M$U!OC3>N>O#?BP;L'=ACO;-;#<I5*VM4@%M4@T^F:OV@/QM1AY+3YZKI0;5;
M HE@N8AS@*T)G6JW^OK=P,J %(][!49 .8AH0J-D6#>:?ZV:'%09]A8EF8@.
H<WUE.Z /Y_;B_GC_Z*;]=*BK0JN-;\MIFK-XS-()^1N3+\(+40@     
 

