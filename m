Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266991AbTBNThv>; Fri, 14 Feb 2003 14:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267300AbTBNThv>; Fri, 14 Feb 2003 14:37:51 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:54532 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S266991AbTBNThl>; Fri, 14 Feb 2003 14:37:41 -0500
Date: Fri, 14 Feb 2003 20:47:32 +0100
From: Matthias Andree <ma@dt.e-technik.uni-dortmund.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] Update BK-kernel-tools/shortlog
Message-ID: <20030214194732.GA31031@merlin.emma.line.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.32, 2003-01-13 15:14:33+01:00, matthias.andree@gmx.de
  Another 14 addresses have been dug out by Vitezslav Samel.


 shortlog |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)


diff -Nru a/shortlog b/shortlog
--- a/shortlog	Fri Feb 14 20:44:05 2003
+++ b/shortlog	Fri Feb 14 20:44:05 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.64 2003/01/08 14:48:50 emma Exp $
+# $Id: lk-changelog.pl,v 0.65 2003/01/13 14:12:09 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -149,6 +149,7 @@
 'bjorn.andersson@erc.ericsson.se' => 'Björn Andersson', # google, guessed ö
 'bjorn.wesen@axis.com' => 'Bjorn Wesen',
 'bjorn_helgaas@hp.com' => 'Bjorn Helgaas',
+'blueflux@koffein.net' => 'Oskar Andreasson',
 'bmatheny@purdue.edu' => 'Blake Matheny', # google
 'borisitk@fortunet.com' => 'Boris Itkis', # by Kristian Peters
 'braam@clusterfs.com' => 'Peter Braam',
@@ -192,6 +193,8 @@
 'danc@mvista.com' => 'Dan Cox', # some CREDITS patch found by google
 'daniel.ritz@gmx.ch' => 'Daniel Ritz',
 'dave@qix.net' => 'Dave Maietta',
+'davej@codemonkey.or' => 'Dave Jones',
+'davej@codemonkey.org.u' => 'Dave Jones',
 'davej@codemonkey.org.uk' => 'Dave Jones',
 'davej@suse.de' => 'Dave Jones',
 'davej@tetrachloride.(none)' => 'Dave Jones',
@@ -235,6 +238,7 @@
 'drow@false.org' => 'Daniel Jacobowitz',
 'drow@nevyn.them.org' => 'Daniel Jacobowitz',
 'dsaxena@mvista.com' => 'Deepak Saxena',
+'duncan.sands@math.u-psud.fr' => 'Duncan Sands',
 'dwmw2@infradead.org' => 'David Woodhouse',
 'dwmw2@redhat.com' => 'David Woodhouse',
 'dz@cs.unitn.it' => 'Massimo Dal Zotto',
@@ -258,6 +262,7 @@
 'felipewd@terra.com.br' => 'Felipe Damasio', # by self (did not ask to include the W.)
 'fenghua.yu@intel.com' => 'Fenghua Yu', # google
 'fero@sztalker.hu' => 'Bakonyi Ferenc',
+'filip.sneppe@cronos.be' => 'Filip Sneppe',
 'fischer@linux-buechse.de' => 'Jürgen E. Fischer',
 'fletch@aracnet.com' => 'Martin J. Bligh',
 'flo@rfc822.org' => 'Florian Lohoff',
@@ -272,6 +277,7 @@
 'fw@deneb.enyo.de' => 'Florian Weimer', # lbdb
 'fzago@austin.rr.com' => 'Frank Zago', # google
 'ganadist@nakyup.mizi.com' => 'Cha Young-Ho',
+'gandalf@wlug.westbo.se' => 'Martin Josefsson',
 'ganesh@tuxtop.vxindia.veritas.com' => 'Ganesh Varadarajan',
 'ganesh@veritas.com' => 'Ganesh Varadarajan',
 'ganesh@vxindia.veritas.com' => 'Ganesh Varadarajan',
@@ -398,6 +404,7 @@
 'k-suganuma@mvj.biglobe.ne.jp' => 'Kimio Suganuma',
 'k.kasprzak@box43.pl' => 'Karol Kasprzak', # by Kristian Peters
 'kaber@trash.net' => 'Patrick McHardy',
+'kadlec@blackhole.kfki.hu' => 'Jozsef Kadlecsik',
 'kai-germaschewski@uiowa.edu' => 'Kai Germaschewski',
 'kai.makisara@kolumbus.fi' => 'Kai Makisara',
 'kai.reichert@udo.edu' => 'Kai Reichert',
@@ -463,6 +470,7 @@
 'marcelo@conectiva.com.br' => 'Marcelo Tosatti',
 'marcelo@freak.distro.conectiva' => 'Marcelo Tosatti', # guessed
 'marcelo@plucky.distro.conectiva' => 'Marcelo Tosatti',
+'marcus@ingate.com' => 'Marcus Sundberg',
 'marekm@amelek.gda.pl' => 'Marek Michalkiewicz',
 'mark@alpha.dyndns.org' => 'Mark W. McClelland',
 'mark@hal9000.dyndns.org' => 'Mark W. McClelland',
@@ -510,6 +518,7 @@
 'msw@redhat.com' => 'Matt Wilson',
 'mufasa@sis.com.tw' => 'Mufasa Yang', # sent by himself
 'mulix@actcom.co.il' => 'Muli Ben-Yehuda', # sent by himself
+'mulix@mulix.org' => 'Muli Ben-Yehuda',
 'mw@microdata-pos.de' => 'Michael Westermann',
 'mzyngier@freesurf.fr' => 'Marc Zyngier',
 'n0ano@n0ano.com' => 'Don Dugger',
@@ -517,6 +526,7 @@
 'nathans@sgi.com' => 'Nathan Scott',
 'neilb@cse.unsw.edu.au' => 'Neil Brown',
 'nemosoft@smcc.demon.nl' => 'Nemosoft Unv.',
+'netfilter@interlinx.bc.ca' => 'Brian J. Murrell',
 'nico@cam.org' => 'Nicolas Pitre',
 'nicolas.aspert@epfl.ch' => 'Nicolas Aspert',
 'nicolas.mailhot@laposte.net' => 'Nicolas Mailhot',
@@ -541,6 +551,7 @@
 'p_gortmaker@yahoo.com' => 'Paul Gortmaker',
 'pasky@ucw.cz' => 'Petr Baudis',
 'patmans@us.ibm.com' => 'Patrick Mansfield',
+'paubert@iram.es' => 'Gabriel Paubert',
 'paul.mundt@timesys.com' => 'Paul Mundt', # google
 'paulkf@microgate.com' => 'Paul Fulghum',
 'paulus@au1.ibm.com' => 'Paul Mackerras',
@@ -609,6 +620,7 @@
 'rob@osinvestor.com' => 'Rob Radez',
 'robert.olsson@data.slu.se' => 'Robert Olsson',
 'rohit.seth@intel.com' => 'Rohit Seth',
+'roland@redhat.com' => 'Roland McGrath',
 'roland@topspin.com' => 'Roland Dreier',
 'romieu@cogenit.fr' => 'François Romieu',
 'romieu@fr.zoreil.com' => 'François Romieu',
@@ -642,7 +654,8 @@
 'scott_anderson@mvista.com' => 'Scott Anderson',
 'scottm@somanetworks.com' => 'Scott Murray',
 'sct@redhat.com' => 'Stephen C. Tweedie',
-'sds@tislabs.com' => 'Stephen Smalley',
+'sds@epoch.ncsc.mil' => 'Stephen D. Smalley',
+'sds@tislabs.com' => 'Stephen D. Smalley',
 'sebastian.droege@gmx.de' => 'Sebastian Dröge',
 'sfbest@us.ibm.com' => 'Steve Best',
 'sfr@canb.auug.org.au' => 'Stephen Rothwell',
@@ -719,6 +732,7 @@
 'uzi@uzix.org' => 'Joshua Uziel',
 'valko@linux.karinthy.hu' => 'Laszlo Valko',
 'vandrove@vc.cvut.cz' => 'Petr Vandrovec',
+'vanl@megsinet.net' => 'Martin H. VanLeeuwen',
 'varenet@parisc-linux.org' => 'Thibaut Varene',
 'vberon@mecano.gme.usherb.ca' => 'Vincent Béron',
 'venkatesh.pallipadi@intel.com' => 'Venkatesh Pallipadi',
@@ -1280,6 +1294,9 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.65  2003/01/13 14:12:09  emma
+# New addresses dug out by Vita.
+#
 # Revision 0.64  2003/01/08 14:48:50  emma
 # New addresses by Vita.
 #

===================================================================


This BitKeeper patch contains the following changesets:
1.32
## Wrapped with gzip_uu ##


begin 600 bkpatch29704
M'XL(``5'33X``\U5VV[;.!1\CKZ"0`KXH35#ZF);!ERH:;IIDF9;Q&B!?:2H
M8TMKBC1(RG$*?WP/Y23>9%,L]O*PMB"#XLPA9\[0.B9?'=CI42N\KQOAJ-"5
M!8B.R4?C_/1HV6YI%88WQN#PQ'4.3E9@-:B3TRN\AOO!T!NC7(3`+\++FFS`
MNND1I\GC$W^WANG1S8?SKY_>W431;$;>UT(O80Z>S&:1-W8C5.6*->AEUVCJ
MK="N!2^H-.WN$;N+&8OQR^.$C;)\%^>C+-M!#%DF4R[*\60,,HZ>Z2GV.IZ6
M21AG.4M2QK)=FL5Q')T1W'%,6'+"^`E/",^F/)TFR6O&IXR1EXN2UYP,671*
M_F,)[R-)WFGC:["$IT14N*9SX$@M-D!*`$VJ;DE,YTEY1[XU'KX[)39D+EI0
M-+HB01./OAQ\CH9_\Q-%3+#H[4%9;5IX)LO5QGIEEGM5&9^P<3KFDUW"QWFV
M6T`N%G+,<L&@$F7U$P^?5,&^\(2G/$WB'8LGD[1/RP/B25C^]7Y^%I1G^[G/
M2;IC^23E?4[XGW,2_U5.<C*,_X=!Z3W^3(;V=ANNX19#\V#`/\C,&>>$1Q?]
M_9B\NJBF1*V&LE>%%>E:O=D01D<9">8^6)A.>3QE.8&V%>3#=DU>88DLU!B4
MJH.%ZK;%RBP6@'YI\`,R>TL&G]U*6!2/BH5S1@_>("E/21P-*A3_>R%-!:W1
M*[BCQNXY9\&52Z/!(?HEV))V+R`OXF0<-E-U6@I-'?;6%=CIFG;#M>LJNGBH
MWP/0703TO!$+O$6CFC5U&M9K**0UVCA:PI[R2Y@C\WZNIXS30%EB":$6Q:WJ
MEO06G"\-=?>4:V%]HW%W#A8/RC&A@;82E0)9E$K(56T4T-5BU=#Z7M2E^8X4
M<M6#7+/JB=@+)+;"RLX5C5X*#R&*CTOA8S+O=%6"709"AND/A$XUVZ*_!]_N
MX3@DIZ"'OT'=56(/SP,<VX8N>+"X!-Y5H[>TE%2*/?'4-NC;)277G;6@5,],
MD\!<BPZ7]D5C14NQ'3W^7)2V`87OEWXRP$=]Z`;6*+2NL%#5PA^$W/2/R;4\
MM]@WQ)^-TB#\(OQ@9!QV%-9&UE1+)VG;J#UO[F%=XRDZHV3>"J7@+B0GH'V#
M)ZETAR5>A%Z,XWY;&Z%5T<+2->C$(<3WK?Q(R3>A/P%TM[`/<CR)27B!WL"F
M<8W1^T/SXJGICPU"?X7;/_P!/#WV@D;'AS>TK$&N7-?.9"Y':9G+Z`?^-.?%
$#`@`````
`
end
