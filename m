Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264014AbUDOQKn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 12:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264323AbUDOQKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 12:10:43 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:15804 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264014AbUDOQKU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 12:10:20 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Thu_Apr_15_16_10_14_UTC_2004_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040415161014.76E15B9365@merlin.emma.line.org>
Date: Thu, 15 Apr 2004 18:10:14 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:

ChangeSet@1.152, 2004-04-15 18:09:16+02:00, matthias.andree@gmx.de
  Add almost two dozen new addresses (vita, ma).

ChangeSet@1.151, 2004-04-15 04:24:04+02:00, matthias.andree@gmx.de
  Merge three addresses from Linus.

ChangeSet@1.149, 2004-04-03 13:08:38+02:00, matthias.andree@gmx.de
  vita: two new addresses

(only 1.152 contained in this mail, use BK pull to get the others)

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   24 +++++++++++++++++++++++-
# 1 files changed, 23 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/04/15 18:09:16+02:00 matthias.andree@gmx.de 
#   Add almost two dozen new addresses (vita, ma).
# 
# shortlog
#   2004/04/15 18:09:16+02:00 matthias.andree@gmx.de +23 -1
#   Add almost two dozen new addresses (vita, ma).
# 
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Thu Apr 15 18:10:13 2004
+++ b/shortlog	Thu Apr 15 18:10:13 2004
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.260 2004/04/15 02:24:00 emma Exp $
+# $Id: lk-changelog.pl,v 0.263 2004/04/15 08:37:42 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -199,6 +199,7 @@
 'albert:users.sourceforge.net' => 'Albert Cahalan',
 'albertogli:telpin.com.ar' => 'Alberto Bertogli',
 'alborchers:steinerpoint.com' => 'Al Borchers',
+'alessandro.zummo:towertech.it' => 'Alessandro Zummo',
 'alex.williamson:hp.com' => 'Alex Williamson',
 'alex:de.rmk.(none)' => 'Alexander Schulz',
 'alex:ssi.bg' => 'Alexander Atanasov',
@@ -226,6 +227,7 @@
 'andikies:t-online.de' => 'Andreas Kies',
 'andmike:us.ibm.com' => 'Mike Anderson', # lbdb
 'andre.breiler:null-mx.org' => 'André Breiler',
+'andre:linux-ide.org' => 'Andre Hedrick',
 'andrea:suse.de' => 'Andrea Arcangeli',
 'andrew.grover:intel.com' => 'Andy Grover', # "Andy" to match former entries
 'andrew.vasquez:qlogic.com' => 'Andrew Vasquez',
@@ -292,6 +294,7 @@
 'bdschuym:pandora.be' => 'Bart De Schuymer',
 'beattie:beattie-home.net' => 'Brian Beattie', # from david.nelson
 'bellucda:tiscali.it' => 'Daniele Bellucci',
+'ben-linux:org.rmk.(none)' => 'Ben Dooks',
 'bengen:hilluzination.de' => 'Hilko Bengen',
 'benh:kernel.crashing.org' => 'Benjamin Herrenschmidt',
 'benh:zion.wanadoo.fr' => 'Benjamin Herrenschmidt',
@@ -395,6 +398,7 @@
 'colin:gibbsonline.net' => 'Colin Gibbs', # whois
 'colpatch:us.ibm.com' => 'Matthew Dobson',
 'corbet:lwn.net' => 'Jonathan Corbet',
+'coreyed:linxtechnologies.com' => 'Corey Edwards',
 'corryk:us.ibm.com' => 'Kevin Corry',
 'cort:fsmlabs.com' => 'Cort Dougan',
 'coughlan:redhat.com' => 'Tom Coughlan',
@@ -558,6 +562,7 @@
 'eric:lammerts.org' => 'Eric Lammerts',
 'erik:aarg.net' => 'Erik Arneson',
 'erik:harddisk-recovery.nl' => 'Erik Mouw',
+'erik:rigtorp.com' => 'Erik Rigtorp',
 'erik_habbinga:hp.com' => 'Erik Habbinga',
 'erikj:subway.americas.sgi.com' => 'Erik Jacobson',
 'erlend-a:us.his.no' => 'Erlend Aasland',
@@ -689,6 +694,7 @@
 'horms:verge.net.au' => 'Simon Horman',
 'hpa:transmeta.com' => 'H. Peter Anvin',
 'hpa:zytor.com' => 'H. Peter Anvin',
+'hugh:com.rmk.(none)' => 'Hugh Dickins',
 'hugh:veritas.com' => 'Hugh Dickins',
 'hunold:convergence.de' => 'Michael Hunold',
 'hunold:linuxtv.org' => 'Michael Hunold',
@@ -700,6 +706,7 @@
 'icampbell:com.rmk.(none)' => 'Ian Campbell',
 'ilmari:ilmari.org' => 'Dagfinn Ilmari Mannsåker',
 'inaky.perez-gonzalez:intel.com' => 'Iñaky Pérez-González', # LK 20030829
+'info:gudeads.com' => 'Gude Analog- und Digitalsysteme GmbH',
 'info:usblcd.de' => 'Adams IT Services',
 'ink:jurassic.park.msu.ru' => 'Ivan Kokshaysky',
 'ink:ru.rmk.(none)' => 'Ivan Kokshaysky',
@@ -811,6 +818,7 @@
 'joe:fib011235813.fsnet.co.uk' => 'Joe Thornber',
 'joe:perches.com' => 'Joe Perches',
 'joe:wavicle.org' => 'Joe Burks',
+'joel.becker:oracle.com' => 'Joel Becker',
 'joel.buckley:sun.com' => 'Joel Buckley',
 'joergprante:netcologne.de' => 'Jörg Prante',
 'joern:infradead.org' => 'Jörn Engel',
@@ -819,6 +827,7 @@
 'johann.deneux:it.uu.se' => 'Johann Deneux',
 'johann.deneux:laposte.net' => 'Johann Deneux',
 'johannes:erdfelt.com' => 'Johannes Erdfelt',
+'john.l.byrne:hp.com' => 'John L. Byrne',
 'john:deater.net' => 'John Clemens',
 'john:fremlin.de' => 'John Fremlin',
 'john:grabjohn.com' => 'John Bradford',
@@ -973,6 +982,7 @@
 'lm:bitmover.com' => 'Larry McVoy',
 'lm:work.bitmover.com' => 'Larry McVoy',
 'lode_leroy:hotmail.com' => 'Lode Leroy',
+'loftin:ldl.fc.hp.com' => 'Terry Loftin',
 'lopezp:grupocp.es' => 'Jose A. Lopez',
 'lord:jen.americas.sgi.com' => 'Stephen Lord',
 'lord:laptop.americas' => 'Stephen Lord',
@@ -991,6 +1001,7 @@
 'lxiep:linux.ibm.com' => 'Linda Xie',
 'lxiep:ltcfwd.linux.ibm.com' => 'Linda Xie',
 'lxiep:us.ibm.com' => 'Linda Xie',
+'m.c.p:kernel.linux-systeme.com' => 'Marc-Christian Petersen',
 'm.c.p:wolk-project.de' => 'Marc-Christian Petersen',
 'm:mbsks.franken.de' => 'Matthias Bruestle',
 'maalanen:ra.abo.fi' => 'Marcus Alanen',
@@ -999,6 +1010,7 @@
 'macro:ds2.pg.gda.pl' => 'Maciej W. Rozycki',
 'maeda.naoaki:jp.fujitsu.com' => 'Maeda Naoaki',
 'mail:de.rmk.(none)' => 'Peter Teichmann',
+'mail:gude.info' => 'Gude Analog- und Digitalsysteme GmbH',
 'makisara:abies.metla.fi' => 'Kai Mäkisara',
 'maloi:phota.to' => 'Andy Molloy',
 'malte.d:gmx.net' => 'Malte Doersam', # google
@@ -1034,6 +1046,7 @@
 'marr:flex.com' => 'Bill Marr',
 'martin.bene:icomedias.com' => 'Martin Bene',
 'martin.bligh:us.ibm.com' => 'Martin J. Bligh',
+'martin.lubich:gmx.at' => 'Martin Lubich',
 'martin.schwidefsky:debitel.net' => 'Martin Schwidefsky',
 'martin:bruli.net' => 'Martin Brulisauer',
 'martin:mdiehl.de' => 'Martin Diehl',
@@ -1117,6 +1130,7 @@
 'mmagallo:debian.org' => 'Marcelo E. Magallon',
 'mmcclell:bigfoot.com' => 'Mark McClelland',
 'mochel:bambi.(none)' => 'Patrick Mochel',
+'mochel:digitalimplant.org' => 'Patrick Mochel',
 'mochel:geena.pdx.osdl.net' => 'Patrick Mochel',
 'mochel:hera.kernel.org' => 'Patrick Mochel',
 'mochel:kernel.bkbits.net' => 'Patrick Mochel',
@@ -1210,6 +1224,7 @@
 'patch:luckynet.dynu.com' => '"Lightweight Patch Manager"', # lbdb
 'patmans:ibm.com' => 'Patrick Mansfield',
 'patmans:us.ibm.com' => 'Patrick Mansfield',
+'patrick.boettcher:desy.de' => 'Patrick Boettcher',
 'patrick:dreker.de' => 'Patrick Dreker', # lbdb
 'paubert:iram.es' => 'Gabriel Paubert',
 'paul.clements:steeleye.com' => 'Paul Clements',
@@ -1241,6 +1256,7 @@
 'per.winkvist:telia.com' => 'Per Winkvist',
 'per.winkvist:uk.com' => 'Per Winkvist',
 'perex:perex.cz' => 'Jaroslav Kysela',
+'perex:petra.perex-int.cz' => 'Jaroslav Kysela', # guessed
 'perex:pnote.perex-int.cz' => 'Jaroslav Kysela',
 'perex:suse.cz' => 'Jaroslav Kysela',
 'perrye:linuxmail.org' => 'Perry Gilfillan', # lbdb
@@ -1262,6 +1278,7 @@
 'petkan:users.sourceforge.net' => 'Petko Manolov',
 'petr:scssoft.com' => 'Petr Sebor',
 'petr:vandrovec.name' => 'Petr Vandrovec',
+'petri.koistinen:fi.rmk.(none)' => 'Petri Koistinen',
 'petri.koistinen:iki.fi' => 'Petri Koistinen',
 'petrides:redhat.com' => 'Ernie Petrides',
 'pfg:sgi.com' => 'Pat Gefre',
@@ -1315,6 +1332,7 @@
 'rbt:mtlb.co.uk' => 'Robert Cardell',
 'rbultje:ronald.bitfreak.net' => 'Ronald Bultje',
 'rct:gherkin.frus.com' => 'Bob Tracy',
+'rddunlap:org.rmk.(none)' => 'Randy Dunlap',
 'rddunlap:osdl.org' => 'Randy Dunlap',
 'reality:delusion.de' => 'Udo A. Steinberg',
 'redbliss:libero.it' => 'Leopoldo Cerbaro',
@@ -1371,6 +1389,7 @@
 'rth:dot.sfbay.redhat.com' => 'Richard Henderson',
 'rth:eeyore.twiddle.net' => 'Richard Henderson',
 'rth:fidel.sfbay.redhat.com' => 'Richard Henderson',
+'rth:heffalump.twiddle.home' => 'Richard Henderson',
 'rth:kanga.(none)' => 'Richard Henderson',
 'rth:kanga.twiddle.home' => 'Richard Henderson',
 'rth:kanga.twiddle.net' => 'Richard Henderson',
@@ -1533,6 +1552,7 @@
 'thoffman:arnor.net' => 'Torrey Hoffman',
 'thomas:bender.thinknerd.de' => 'Thomas Walpuski',
 'thomas:habets.pp.se' => 'Thomas Habets',
+'thomas:horsten.com' => 'Thomas Horsten',
 'thomas:osterried.de' => 'Thomas Osterried',
 'thomas:stewarts.org.uk' => 'Thomas Stewart',
 'thomas:winischhofer.net' => 'Thomas Winischhofer', # whois
@@ -1548,6 +1568,7 @@
 'tinglett:vnet.ibm.com' => 'Todd Inglett',
 'tiwai:suse.de' => 'Takashi Iwai',
 'tlnguyen:snoqualmie.dp.intel.com' => 'Tom L. Nguyen',
+'tmattox:engr.uky.edu' => 'Tim Mattox',
 'tmcreynolds:nvidia.com' => 'Tom McReynolds',
 'tmolina:cablespeed.com' => 'Thomas Molina',
 'tmolina:cox.net' => 'Thomas Molina',
@@ -1587,6 +1608,7 @@
 'uaca:alumni.uv.es' => 'Ulisses Alonso Camaró',
 'urban.widmark:enlight.net' => 'Urban Widmark',
 'urban:teststation.com' => 'Urban Widmark',
+'uwe.koziolek:gmx.net' => 'Uwe Koziolek',
 'uzi:uzix.org' => 'Joshua Uziel',
 'valdis.kletnieks:vt.edu' => 'Valdis Kletnieks',
 'valko:linux.karinthy.hu' => 'Laszlo Valko',

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.152
## Wrapped with gzip_uu ##


M'XL( .6S?D   \U6VV[;.!!]CKYB@!1(BT:,*%F612!%<T/238H-LMN7?:/%
ML:6U1!H2%=N!/[Y#RKGU\M#=?5A;L"W..:.9,\.A]^%+AZW8:Z2U924[)K5J
M$8-]N#*=%7OS9LV4N[TSAFZ/NK[#HP6V&NNCTVNZPN$FM,;474# 6VF+$NZQ
M[<0>9\G3BMTL4>S=75Q^N3FY"X+C8S@KI9[C'VCA^#BPIKV7M>H^+E'/^THS
MVTK=-6@E*TRS?<)NXRB*Z<WC)!JG^3;.QVFZQ1C3M!AQ.<TF&19Q\$T^'X<\
M7KL912.>1G%,W]N(\SP+SH$SGL80C8[HXBGPB8ARP<?OHUA$$?S8*[SG$$;!
M*?S'.9P%!9PH!;)NJ!9@5P:4>4 -&E<@%470==C!V_O*RD.*[1T+KH''<1+<
M/FL;A+_X"H)(1L&'YV1*T^ WF72E:6UMYD,B*9]$V2CCDVW"LSS=SC"7LR*+
M<AFADE/U$]E>>?&UX.,HY^-MFHV3B>^01\2K!OG7\?RL.;Z+Q_=&LDWB<<*'
MWHC37^Z-.(&0_T^:8U#V=PC;U=I=X9I:Y3'M?] IYYP##S[YSWUX\TD)J!=A
MX5,ACVQ9']Y#Q$@_<)KNA(LF(LG$* 87&URLE_ F^$0)DY,#65/<3D'#'OJF
M,<*:%;86BY)5]@"./\#!R1,$_G*0@T-BQQ//=M*+NM+].JP4,M/.=QQG@"M4
M;54L/"$?.<(4=>CA@J"L;1;LK38:WPVL4Y+SW)A%YQA)GCE&85K<H'(/6;NP
MM*%$*^Q<$0?6F4/ A5K)5GEF.HX<$]MJ(=IJ3HVP?$9?T"K<#:L./,Z]#F4_
M+P6!OHOIB@QP3EE4VCO/HMCA*STS8MXKE.I%*)>T "=:4H@A]%H1<4Z:U]VF
ML]@@7#;3*^=DPA/GY&^#-9MB02.=])!%C<^N?B,;G'J;9\1\8)2:$6=#9X H
MER_AI88;!J?.X@AYECI";6:VTJ)6-9L5["7C3VS;#=QXNR?D/J:&%6PIAD.&
M#97=1?],_2S;(CPKVZJSE=1PBY9.'_1>>#3T52.KVNO#G%*_I@Z/DO'@HZ78
M6-U/JZ(4;G]+^Q0 6>#&6SR%CA-/,46)M5"#XZI9UE+;Y[:DD]$U)'SV,$^,
MN:_G<K"PJ4%+IR<51&&WH8'RFGCZ:!ZX(R_9$EM<BR72@&'^=UC10XN'765D
M:[I:WL/UIL-:'AS"/LQ[-RV4<S$>#2[(/UL8IZA&+6;5=XUXZR!P_0CQ ="\
M=>Q6J5[7<OG#375'FW0#YQXPD#(?=6M+4>)L)NN^63*[JI2B_G/#?L<C:6E'
MT2;6BLIKAB>FB6\K2SC9"9ID5#K]HJG\.OV7\>L#(_6[T;IY;=:"AG'+^L6&
MH>IWG*J!S]XXX">^DOT*28^'RM2X\+77N"O^EQ62#(.%&$]_>*@LQ:+KF^-"
/SM*IRF7P%8^"RFMM"0  
 

