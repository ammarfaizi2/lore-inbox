Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbUCDRKL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 12:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbUCDRKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 12:10:11 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:52121 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262028AbUCDRJn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 12:09:43 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Thu_Mar__4_17_09_38_UTC_2004_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040304170938.B1036AA95D@merlin.emma.line.org>
Date: Thu,  4 Mar 2004 18:09:38 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.126, 2004-02-29 22:50:54+01:00, matthias.andree@gmx.de
  Update to upstream 0.236, new addresses.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   20 ++++++++++++++++----
# 1 files changed, 16 insertions(+), 4 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/02/29 22:50:54+01:00 matthias.andree@gmx.de 
#   Update to upstream 0.236, new addresses.
# 
# shortlog
#   2004/02/29 22:50:48+01:00 matthias.andree@gmx.de +16 -4
#   Update to upstream 0.236, new addresses.
# 
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Thu Mar  4 18:09:37 2004
+++ b/shortlog	Thu Mar  4 18:09:37 2004
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.224 2004/01/27 14:40:49 emma Exp $
+# $Id: lk-changelog.pl,v 0.236 2004/02/29 21:49:46 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -309,6 +309,7 @@
 'borisitk:fortunet.com' => 'Boris Itkis', # by Kristian Peters
 'boutcher:us.ibm.com' => 'Dave Boutcher',
 'braam:clusterfs.com' => 'Peter Braam',
+'brad:wasp.net.au' => 'Brad Campbell',
 'brazilnut:us.ibm.com' => 'Don Fry',
 'brett:bad-sports.com' => 'Brett Pemberton',
 'brian:rentec.com' => 'Brian Childs',
@@ -595,6 +596,7 @@
 'gibbs:overdrive.btc.adaptec.com' => 'Justin T. Gibbs',
 'gibbs:scsiguy.com' => 'Justin T. Gibbs',
 'gilbertd:treblig.org' => 'Dr. David Alan Gilbert',
+'giuseppe.furlan:systeam.it' => 'Giuseppe Furlan',
 'gj:pointblue.com.pl' => 'Grzegorz Jaskiewicz',
 'gkernel.adm:hostme.bitkeeper.com' => 'Jeff Garzik', # himself
 'gl:dsa-ac.de' => 'Guennadi Liakhovetski',
@@ -838,7 +840,7 @@
 'kare.sars:lmf.ericsson.se' => 'Kåre Särs',
 'karlis:mt.lv' => 'Karlis Peisenieks',
 'kartik_me:hotmail.com' => 'Kartikey Mahendra Bhatt',
-'kas:informatics.muni.cz' => 'Jan Kasprzak',
+'kas:informatics.muni.cz' => 'Jan Kasprzak', # lbdb
 'kasperd:daimi.au.dk' => 'Kasper Dupont',
 'kaz:earth.email.ne.jp' => 'Kazuto Miyoshi',
 'kazunori:miyazawa.org' => 'Kazunori Miyazawa',
@@ -886,6 +888,7 @@
 'kyle:debian.org' => 'Kyle McMartin',
 'kyle:engsoc.carleton.ca' => 'Kyle McMartin',
 'l.s.r:web.de' => 'René Scharfe',
+'ladis:linux-mips.org' => 'Ladislav Michl',
 'ladis:psi.cz' => 'Ladislav Michl',
 'laforge:gnumonks.org' => 'Harald Welte',
 'laforge:netfilter.org' => 'Harald Welte',
@@ -898,6 +901,7 @@
 'ldl:aros.net' => 'Lou Langholtz',
 'ldm.adm:hostme.bitkeeper.com' => 'Patrick Mochel', # self
 'ldm:flatcap.org' => 'Richard Russon',
+'leachbj:bouncycastle.org' => 'Bernard Leach',
 'lee:compucrew.com' => 'Lee Nash', # lbdb
 'legoll:free.fr' => 'Vincent Legoll', # correction sent by himself
 'leigh:solinno.co.uk' => 'Leigh Brown', # lbdb
@@ -951,8 +955,9 @@
 'm:mbsks.franken.de' => 'Matthias Bruestle',
 'maalanen:ra.abo.fi' => 'Marcus Alanen',
 'mac:melware.de' => 'Armin Schindler',
+'macro:ds2.pg.dga.pl' => 'Maciej W. Rozycki',
 'macro:ds2.pg.gda.pl' => 'Maciej W. Rozycki',
-'maeda.naoaki:jp.fujitsu.com' => 'MAEDA Naoaki',
+'maeda.naoaki:jp.fujitsu.com' => 'Maeda Naoaki',
 'mail:de.rmk.(none)' => 'Peter Teichmann',
 'makisara:abies.metla.fi' => 'Kai Mäkisara',
 'maloi:phota.to' => 'Andy Molloy',
@@ -1024,13 +1029,14 @@
 'mgreer:mvista.com' => 'Mark A. Greer', # lbdb
 'mhoffman:lightlink.com' => 'Mark M. Hoffman',
 'mhopf:innominate.com' => 'Mark-André Hopf',
+'michael.krauth:web.de' => 'Michael Krauth',
 'michael:metaparadigm.com' => 'Michael Clark',
 'michael_e_brown:dell.com' => 'Michael E. Brown', # lbdb
 'michaelw:foldr.org' => 'Michael Weber', # google
 'michal:harddata.com' => 'Michal Jaegermann',
 'michal:logix.cz' => 'Michal Ludvig',
 'michel:daenzer.net' => 'Michel Dänzer',
-'miguel:cetuc.puc-rio.br' => 'Miguel Freitas',
+'miguel:cetuc.puc-rio.br' => 'Miguel Freitas', # lbdb
 'mikael.starvik:axis.com' => 'Mikael Starvik',
 'mikal:stillhq.com' => 'Michael Still',
 'mike.miller:hp.com' => 'Mike Miller',
@@ -1206,6 +1212,7 @@
 'petri.koistinen:iki.fi' => 'Petri Koistinen',
 'petrides:redhat.com' => 'Ernie Petrides',
 'pfg:sgi.com' => 'Pat Gefre',
+'phil.el:wanadoo.fr' => 'Philippe Elie',
 'philipc:snapgear.com' => 'Philip Craig',
 'philipp:void.at' => 'Philipp Friedrich',
 'phillim2:comcast.net' => 'Mike Phillips',
@@ -1279,6 +1286,7 @@
 'rmk:arm.linux.org.uk' => 'Russell King',
 'rmk:flint.arm.linux.org.uk' => 'Russell King',
 'rml:tech9.net' => 'Robert Love',
+'rml:ximian.com' => 'Robert Love',
 'rnp:paradise.net.nz' => 'Richard Procter',
 'rob:landley.net' => 'Rob Landley',
 'rob:osinvestor.com' => 'Rob Radez',
@@ -1414,6 +1422,7 @@
 'steve:chygwyn.com' => 'Steven Whitehouse',
 'steve:gw.chygwyn.com' => 'Steven Whitehouse',
 'steve:kbuxd.necst.nec.co.jp' => 'Steve Baur',
+'steve:navaho.co.uk' => 'Steve Hill',
 'steved:redhat.com' => 'Steve Dickson',
 'stevef:linux.local' => 'Steve French', # guessed
 'stevef:smfhome1.austin.rr.com' => 'Steve French',
@@ -1492,6 +1501,7 @@
 'trini:mvista.com' => 'Tom Rini',
 'trini:opus.bloom.county' => 'Tom Rini',
 'trini:org.rmk.(none)' => 'Tom Rini',
+'tritol:trilogic.cz' => 'Lubomír Bláha',
 'trivial:rustcorp.com.au' => 'Rusty Russell',
 'trond.myklebust:fys.uio.no' => 'Trond Myklebust',
 'tsk:ibakou.com' => 'Kawazoe Tomonori',
@@ -1535,6 +1545,7 @@
 'wahrenbruch:kobil.de' => 'Thomas Wahrenbruch',
 'waltabbyh:comcast.net' => 'Walt Holman',
 'walter.harms:informatik.uni-oldenburg.de' => 'Walter Harms',
+'wang:ai.mit.edu' => 'Edward Wang',
 'warlord:mit.edu' => 'Derek Atkins',
 'warp:mercury.d2dc.net' => 'Zephaniah E. Hull',
 'wayne:stallion.oz.au' => 'Wayne Piekarski',
@@ -1581,6 +1592,7 @@
 'yoshfuji:linux-ipv6.org' => 'Hideaki Yoshifuji', # lbdb
 'yoshfuji:nuts.ninka.net' => 'Hideaki Yoshifuji',
 'ysato:users.sourceforge.jp' => 'Yoshinori Sato', # lbdb
+'yuasa:hh.iij4u.or.jp' => 'Yoichi Yuasa',
 'yuri:acronis.com' => 'Yuri Per', # lbdb
 'zaitcev:redhat.com' => 'Pete Zaitcev',
 'zdzichu:irc.pl' => 'Tomasz Torcz',

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.126
## Wrapped with gzip_uu ##


M'XL( -%B1T   \55VV[;.!!]CKZ"0 KXH3%#4I)M$7#1S:5MFG0W2!$4?1Q1
MC$5;$@62LIW /[L?L/^PI!0G38!BL1=@;<$$.>>,9LX<T(?HUDK##VIPKE1@
M,32%D3(Z1)^T=?Q@46]Q$;8W6OOML>VL/%Y)T\CJ^.32/^-A,W9:5S;RP&MP
MHD1K:2P_H#A^.G'WK>0'-^<?;Z]^N8FB^1R=EM LY%?IT'P>.6W64!7V?2N;
M1:<:[ PTMI8.L-#U[@F[8X0P_Z4L)I,TV[%LDJ8[R62:BH1"/IU-I6 _I&M%
M-B58VZ+"VBQ>)DH(8U/&T@F=[@B-V20Z0Q13-D$D.2;LF&6(,9X2GB9O">6$
MH%<ZO1_T06\I&I/H!/W'79Q& MVV!3CI,Z.NM<Y(J!'!+)X<H49N$!2^#&NE
MQ=$EHHS2Z/I9UVC\-S]11(!$[Y[;*'4M7_5@2VU<I1=#"RF=D6DRI;-=3*=9
MNKN3&=R)*<F R +RXB>"O<@2II QFI)DMDNH'T;OCCWBA3G^=3T_-\;KBO:^
MF,23).Y]D66O;9',_LH6$S1._G=?#*+^AL9FLPW/>.M=LN_W'YCDC%)$HXO^
M]Q"]N2@XJE9CT3?A,^*V.EH/Q: @YEXRRI.,)Q,DZQK0^;9%;Z*+N$\RR@T4
M? .VQ8UT&+H1FK]#HQ-_BDZA;G-95:.CZ"+-I@&]4/X6:EN)[SI30</MO76^
M?ZS<P/OX&$<?^KAGGLV2ON1A&:W <M7<:>/GIH3%==<H+!X&]F=HT*4OQ3S 
M:G2$#E&5%[FGSF:!6D&A+*]4TVW'M6IM\,[ NPJ1"M;HBQ)E7V[FG1$H$D29
M+WFNNT;<"["NDL^T$W]_@BG054#UK#0.K!J$T;RP#+<+7"S JSH0OH!0<HF^
M87\G/]R+E0K]96D:^AL6S_5FQPUH6"F^;+U.2^5L%[RVS^$!Z-<>$-Y)B;_S
M M&7#K+"*P.=*_E&YM[&CY0AA"[[4'@G)7'<^V!8/7G1R8H+Z3J!VTZ,C=(X
M-WMZ"*(/1BH']@==*2.]L&VI*NSI&VB@T!K?/1*O_;D*PSROE.QK9;-^B*:N
M^%;5"IKGOFYT+HU#5WH]0!/:M^7ML9:\@364VH-QMQK@7\,Y^J0&=]$D2P+:
M&>5TQ?WBS:S$DS&NNES7?QAT4OU>0D](X]Z/ON0%!X5KY; L'LU[7FS"6+_Y
MV("=]2+==V"!ER56:IETW@9XV0Z$[]HKK-#W /",IS].44JQLET]I[)(&,QH
*]">VDZ19M0<     
 

