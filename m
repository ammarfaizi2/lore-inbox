Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269909AbTGKL6X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 07:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269910AbTGKL6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 07:58:23 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:2835 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S269909AbTGKL6T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 07:58:19 -0400
MIME-Version: 1.0
To: torvalds@transmeta.com
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Fri_Jul_11_12_12_57_UTC_2003_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20030711121257.90B4584764@merlin.emma.line.org>
Date: Fri, 11 Jul 2003 14:12:57 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can pull from bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no
trailing slash) or in cases of dire need, you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
8 new addresses, hash re-sorted.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   21 +++++++++++++++++++--
# 1 files changed, 19 insertions(+), 2 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.66    -> 1.67   
#	            shortlog	1.40    -> 1.41   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/07/11	matthias.andree@gmx.de	1.67
# 8 new addresses, cleanup. upstream version 0.142 -> 0.145.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Fri Jul 11 14:12:56 2003
+++ b/shortlog	Fri Jul 11 14:12:56 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.142 2003/07/03 12:29:27 vita Exp $
+# $Id: lk-changelog.pl,v 0.145 2003/07/11 08:37:05 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -389,6 +389,8 @@
 'dsaxena:com.rmk.(none)' => 'Deepak Saxena',
 'dsaxena:mvista.com' => 'Deepak Saxena',
 'dsteklof:us.ibm.com' => 'Daniel E. F. Stekloff',
+'dtor_core:ameritech.net' => 'Dmitry Torokhov',
+'ducrot:poupinou.org' => 'Bruno Ducrot',
 'duncan.sands:math.u-psud.fr' => 'Duncan Sands',
 'dwmw2:dwmw2.baythorne.internal' => 'David Woodhouse',
 'dwmw2:infradead.org' => 'David Woodhouse',
@@ -563,6 +565,7 @@
 'jdike:uml.karaya.com' => 'Jeff Dike',
 'jdr:farfalle.com' => 'David Ruggiero',
 'jdthood:yahoo.co.uk' => 'Thomas Hood',
+'jean-luc.richier:imag.fr' => 'Jean-Luc Richier',
 'jeb.j.cramer:intel.com' => 'Jeb J. Cramer',
 'jef:linuxbe.org' => 'Jean-Francois Dive',
 'jeff.wiedemeier:hp.com' => 'Jeff Wiedemeier',
@@ -709,6 +712,7 @@
 'lkml:shemesh.biz' => 'Shachar Shemesh',
 'lm:bitmover.com' => 'Larry McVoy',
 'lm:work.bitmover.com' => 'Larry McVoy',
+'lode_leroy:hotmail.com' => 'Lode Leroy',
 'lopezp:grupocp.es' => 'Jose A. Lopez',
 'lord:jen.americas.sgi.com' => 'Stephen Lord',
 'lord:sgi.com' => 'Stephen Lord',
@@ -802,6 +806,7 @@
 'mochel:osdl.org' => 'Patrick Mochel',
 'mochel:segfault.osdl.org' => 'Patrick Mochel',
 'mochel:segfault.osdlab.org' => 'Patrick Mochel',
+'mort:green.i.bork.org' => 'Martin Hicks',
 'mort:wildopensource.com' => 'Martin Hicks',
 'mostrows:speakeasy.net' => 'Michal Ostrowski',
 'mostrows:watson.ibm.com' => 'Michal Ostrowski',
@@ -898,6 +903,7 @@
 'petkan:rakia.hell.org' => 'Petko Manolov',
 'petkan:tequila.dce.bg' => 'Petko Manolov',
 'petkan:users.sourceforge.net' => 'Petko Manolov',
+'petr:scssoft.com' => 'Petr Sebor',
 'petr:vandrovec.name' => 'Petr Vandrovec',
 'petri.koistinen:iki.fi' => 'Petri Koistinen',
 'petrides:redhat.com' => 'Ernie Petrides',
@@ -1057,6 +1063,7 @@
 'steve:chygwyn.com' => 'Steven Whitehouse',
 'steve:gw.chygwyn.com' => 'Steven Whitehouse',
 'steve:kbuxd.necst.nec.co.jp' => 'Steve Baur',
+'stevef:linux.local' => 'Steve French', # guessed
 'stevef:smfhome1.austin.rr.com' => 'Steve French',
 'stevef:stevef95.austin.ibm.com' => 'Steve French',
 'stevef:steveft21.austin.ibm.com' => 'Steve French',
@@ -1081,6 +1088,7 @@
 'tausq:debian.org' => 'Randolph Chung',
 'tcallawa:redhat.com' => "Tom 'spot' Callaway",
 'tetapi:utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
+'tgraf:suug.ch' => 'Thomas Graf',
 'th122948:scl1.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie
 'th122948:scl3.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie
 'thiel:ksan.de' => 'Florian Thiel', # lbdb
@@ -1152,9 +1160,9 @@
 'whydoubt:yahoo.com' => 'Jeff Smith',
 'will:sowerbutts.com' => 'William R. Sowerbutts',
 'willschm:us.ibm.com' => 'Will Schmidt',
-'willy:org.rmk.(none)' => 'Matthew Wilcox',
 'willy:debian.org' => 'Matthew Wilcox',
 'willy:fc.hp.com' => 'Matthew Wilcox',
+'willy:org.rmk.(none)' => 'Matthew Wilcox',
 'willy:w.ods.org' => 'Willy Tarreau',
 'wilsonc:abocom.com.tw' => 'Wilson Chen', # google
 'wim:iguana.be' => 'Wim Van Sebroeck',
@@ -1769,6 +1777,15 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.145  2003/07/11 08:37:05  vita
+# add 4 names for new addresses; resort address->name hash
+#
+# Revision 0.144  2003/07/10 12:27:51  vita
+# 2 new addresses
+#
+# Revision 0.143  2003/07/08 10:05:55  vita
+# 2 new addresses
+#
 # Revision 0.142  2003/07/03 12:29:27  vita
 # 3 new addresses
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.67
## Wrapped with gzip_uu ##


begin 600 bkpatch28727
M'XL(`,BI#C\``\U56V_;-AA]#G_%![B`-S2B24FT;`X.NC2]I$VQ(&FQQX*A
M:$FS)!HDY3B`?_Q(J;'GM-VPR\-LP3;)<[[+^8ZE$7RRRO"31CA75L)BT>9&
M*32"M]HZ?E(T6YR'Y8W6?CFQG563E3*MJB?G[_T5#8O(:5U;Y('7PLD2-LI8
M?D)QLM]Q#VO%3VY>O?ET]?,-0HL%O"Q%6ZA;Y6"Q0$Z;C:AS^V*MVJ*K6NR,
M:&VCG,!2-[L]=A<3$OLWC1,R9?-=/)\RME.Q8DRF5-QELTS)&#WIY\70QW&8
MA&1D&M,T3K,=H5E"T`50/,V`)!.232@%FG)*.<N>DY@3`M\."L\I1`2=PW_<
MPDLD80:MN@>1^W36*GL*LE:B[=88NK5U1HFF5[K2+1#L.X'HK/_!,'H/-*,S
M='V0&45_\X40$02='1HK=:.>=&5+;5RMBZ$I1F<D2WW>74*S.=LMU5PL94;F
M@JA<W.7?D?`HBA\+I32FE*6[:4ICTIOE$7'DE7]=S_=\\J2>+S9)=W3&TL$F
M*?W*)NE?V60.4?P_],D@\B\0F?MMN**M=\VC`O_`-!=!$G39?X[@V67.H5Y%
MLF_+1\3K^G0S9(<@[Q<1R8PG&2<,-I43\&J[AF?H,IE3B-$X]Y)]EMHH+AIE
M*J=DB5OEQK`X@_%%4SGS`!^UT:M2;\:G'M])XV]7:]VMJU9W6)MBP)Z;KM5P
MT1][X"6;,E_D^#<O5E1W$IM*EI6_'U:-*/#2#*1WX?2JDW`SG`9BUG<WKG6N
M/M?*Z`=>:M>(J@XC'&A7_@RNPED@S$@:"(U7E1?>%2VN\)TVJT-M'X1Q50MO
M*[FR@3'W5O*,M7*&6VFM7KI#\&N_"[?*1PA02M@\8*U3&[7D==5V6UQK*>H!
M?1OVX;51K2S'IS""H@L^R0-SE@2F*XQ8<MMU!?:0GO31_[N$A3?^P.?P0V5L
M&"O+`N.^JNL'[JO'IEGA'UK=JA\?&_'^]W;\M:JEWO;U91F%>7B*J$VU=R&#
M;\Z_-X#'>C=#"JV?N(6E-L<._PG\M]?R<2<Z"T`HA2W1Z&FB]`^)O*8QCS/.
MZ#Y1?!SZ:WYRX),94.*KY(S]"7__T).E\M/LFL4R3J:49#GZ'4KO0TAQ!P``
`
end

