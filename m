Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267228AbTBNTiZ>; Fri, 14 Feb 2003 14:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267300AbTBNTiC>; Fri, 14 Feb 2003 14:38:02 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:55044 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267228AbTBNThq>; Fri, 14 Feb 2003 14:37:46 -0500
Date: Fri, 14 Feb 2003 20:47:37 +0100
From: Matthias Andree <ma@dt.e-technik.uni-dortmund.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] Update BK-kernel-tools/shortlog
Message-ID: <20030214194737.GA31063@merlin.emma.line.org>
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


ChangeSet@1.33, 2003-01-18 13:46:34+01:00, matthias.andree@gmx.de
  Add more addresses dug out by Vietzslav Samel.


 shortlog |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletion(-)


diff -Nru a/shortlog b/shortlog
--- a/shortlog	Fri Feb 14 20:44:05 2003
+++ b/shortlog	Fri Feb 14 20:44:05 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.65 2003/01/13 14:12:09 emma Exp $
+# $Id: lk-changelog.pl,v 0.66 2003/01/18 12:44:33 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -102,6 +102,7 @@
 'alan@irongate.swansea.linux.org.uk' => 'Alan Cox',
 'alan@lxorguk.ukuu.org.uk' => 'Alan Cox',
 'alan@redhat.com' => 'Alan Cox',
+'alex@ssi.bg' => 'Alexander Atanasov',
 'alex_williamson@attbi.com' => 'Alex Williamson', # lbdb
 'alex_williamson@hp.com' => 'Alex Williamson', # google
 'alexander.riesen@synopsys.com' => 'Alexander Riesen',
@@ -175,6 +176,9 @@
 'christopher.leech@intel.com' => 'Christopher Leech',
 'cip307@cip.physik.uni-wuerzburg.de' => 'Jochen Karrer', # from shortlog
 'ckulesa@as.arizona.edu' => 'Craig Kulesa',
+'cloos@jhcloos.com' => 'James H. Cloos Jr.',
+'cminyard@mvista.com' => 'Corey Minyard',
+'cobra@compuserve.com' => 'Kevin Brosius',
 'colin@gibbs.dhs.org' => 'Colin Gibbs',
 'colpatch@us.ibm.com' => 'Matthew Dobson',
 'cort@fsmlabs.com' => 'Cort Dougan',
@@ -182,9 +186,11 @@
 'cr@sap.com' => 'Christoph Rohland',
 'cruault@724.com' => 'Charles-Edouard Ruault',
 'ctindel@cup.hp.com' => 'Chad N. Tindel',
+'cubic@miee.ru' => 'Ruslan U. Zakirov',
 'cyeoh@samba.org' => 'Christopher Yeoh',
 'da-x@gmx.net' => 'Dan Aloni',
 'daisy@teetime.dynamic.austin.ibm.com' => 'Daisy Chang', # from shortlog
+'dale.farnsworth@mvista.com' => 'Dale Farnsworth',
 'dalecki@evision-ventures.com' => 'Martin Dalecki',
 'dalecki@evision.ag' => 'Martin Dalecki',
 'dan.zink@hp.com' => 'Dan Zink',
@@ -234,6 +240,7 @@
 'dmccr@us.ibm.com' => 'Dave McCracken',
 'dok@directfb.org' => 'Denis Oliver Kropp',
 'dougg@torque.net' => 'Douglas Gilbert',
+'drepper@redhat.com' => 'Ulrich Drepper',
 'driver@huey.jpl.nasa.gov' => 'Bryan B. Whitehead', # google
 'drow@false.org' => 'Daniel Jacobowitz',
 'drow@nevyn.them.org' => 'Daniel Jacobowitz',
@@ -357,6 +364,7 @@
 'jdr@farfalle.com' => 'David Ruggiero',
 'jdthood@yahoo.co.uk' => 'Thomas Hood',
 'jeb.j.cramer@intel.com' => 'Jeb J. Cramer',
+'jeff.wiedemeier@hp.com' => 'Jeff Wiedemeier',
 'jeffs@accelent.com' => 'Jeff Sutherland', # lbdb
 'jejb@mulgrave.(none)' => 'James Bottomley', # from shortlog
 'jejb@raven.il.steeleye.com' => 'James Bottomley',
@@ -378,6 +386,7 @@
 'jmorris@intercode.com.au' => 'James Morris',
 'jo-lkml@suckfuell.net' => 'Jochen Suckfuell',
 'jochen@jochen.org' => 'Jochen Hein',
+'jochen@scram.de' => 'Jochen Friedrich',
 'joe@fib011235813.fsnet.co.uk' => 'Joe Thornber',
 'joe@wavicle.org' => 'Joe Burks',
 'joergprante@netcologne.de' => 'Jörg Prante',
@@ -515,6 +524,7 @@
 'mochel@osdl.org' => 'Patrick Mochel',
 'mochel@segfault.osdl.org' => 'Patrick Mochel',
 'mostrows@speakeasy.net' => 'Michal Ostrowski',
+'mporter@cox.net' => 'Matt Porter',
 'msw@redhat.com' => 'Matt Wilson',
 'mufasa@sis.com.tw' => 'Mufasa Yang', # sent by himself
 'mulix@actcom.co.il' => 'Muli Ben-Yehuda', # sent by himself
@@ -620,6 +630,7 @@
 'rob@osinvestor.com' => 'Rob Radez',
 'robert.olsson@data.slu.se' => 'Robert Olsson',
 'rohit.seth@intel.com' => 'Rohit Seth',
+'rol@as2917.net' => 'Paul Rolland',
 'roland@redhat.com' => 'Roland McGrath',
 'roland@topspin.com' => 'Roland Dreier',
 'romieu@cogenit.fr' => 'François Romieu',
@@ -630,11 +641,13 @@
 'rth@are.twiddle.net' => 'Richard Henderson',
 'rth@dorothy.sfbay.redhat.com' => 'Richard Henderson',
 'rth@dot.sfbay.redhat.com' => 'Richard Henderson',
+'rth@kanga.twiddle.net' => 'Richard Henderson',
 'rth@splat.sfbay.redhat.com' => 'Richard Henderson',
 'rth@twiddle.net' => 'Richard Henderson',
 'rth@vsop.sfbay.redhat.com' => 'Richard Henderson',
 'rui.sousa@laposte.net' => 'Rui Sousa',
 'rusty@rustcorp.com.au' => 'Rusty Russell',
+'rvinson@mvista.com' => 'Randy Vinson',
 'rwhron@earthlink.net' => 'Randy Hron',
 'rz@linux-m68k.org' => 'Richard Zidlicky',
 'sabala@students.uiuc.edu' => 'Michal Sabala', # google
@@ -1294,6 +1307,9 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.66  2003/01/18 12:44:33  emma
+# New addresses found out by Vita.
+#
 # Revision 0.65  2003/01/13 14:12:09  emma
 # New addresses dug out by Vita.
 #

===================================================================


This BitKeeper patch contains the following changesets:
1.33
## Wrapped with gzip_uu ##


begin 600 bkpatch29740
M'XL(``9'33X``\U5VV[;.!!]#K]B@!3P0VN9U,62!;A0+FW39KL;N,@6Z!LM
MCBW5DFB0DNTL_/$[DA*[25HL=K</M04;Y)PSG#D\%$_AUJ*)3TI9UUDNK2,K
M91#9*5QI6\<GRW+GJ'8XTYJ&(]M8'*W05%B,SJ_I&?:#8:UU81D!;V2=9K!!
M8^,3X7B'F?INC?')[,V[V]_.9HQ-IW"1R6J)G["&Z935VFQDH6RRQFK9Y)53
M&UG9$FOII+K<'[![EW.7OL+U^#B8[-W).`CVZ&(0I+Z0\S`*,779DWZ2OH_'
M:3PNA"=\X7O>W@]<5[!+H(H]X-Z(BY&(0'BQ/XX]_R47,>?P_:3P4L"0LW/X
MR2U<L!3.E()2&P2I:$5KT8)JEJ";&N9W\&>.]5^VD!OX)$LL''8-U(?GL9NC
MMFSX+S^,<<G9ZV,WF2[Q22LVTZ8N]++O)!`1#_U01'M/A)-@O\")7*0AGTB.
M2L[5#W1[E*7=BTBX_ICV(O"CB'<.>4`\,LC_KN='YGA:3^\-=\_=*/([;XCG
MWO#^R1LA#,4O8HY>V#]@:+:[]AGNR"D/7?\'HUP*`8*][WY/X<5[%4.Q&J9=
M*Y3161>O-L"=\1A:11]T<V/?)]T`RU+"F]T:7E`*[E..@2QPEUB;._/E`*:O
M87!&$R0H&CBK926MW@Q>$3H,P6.#M-#:)E^S[K]5L>=\H'8M7#EPT<[#!^,0
M9Y"6>74GC4K*36Y[T7OX!2EX!Q_[:(?4<R,3BJ_I76<V>(1>XR:OX-QHFS>V
M*R3JRDZ;>9XF98[HF*:'SAJ2OH);![[(56[NZX["%JZH36<A366W)'WVK*)+
MBL/;0[QENMZX8QI<K]$D!E4FZR/CMC`YO6(O^W!+\())2_B*BX6SS5%AB3D1
ML_4W.E$,/A]B'2OB'4NG&5:)38TLR<3W\&X2WAIBM*NU^$!T#95KJI.RIWKG
M5%CW^(]T(."F"[30L>NV4*.+1%IW(L(C\D8V!=TO!0FF.JC70TF:%5E).O4V
M5XHT.S!FM#[M%EQAZPVKJY[6%6-HCVCFF:HSRMZ>BNH>+NAD07L]S6A7;:ZK
MWJG?M6KG58+^CMMO#MM"-Y4Z'C=:C)T>;T!2*UW9IIR*:+$0DR!@?P-`P[>A
$;`<`````
`
end
