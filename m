Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272824AbTG3Iiw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 04:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272825AbTG3Iiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 04:38:52 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:2177 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S272824AbTG3Iiq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 04:38:46 -0400
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Wed_Jul_30_08_38_42_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030730083842.E1336CA94@merlin.emma.line.org>
Date: Wed, 30 Jul 2003 10:38:42 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can pull from bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no
trailing slash) or in cases of dire need, you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
ChangeSet@1.70, 2003-07-30 10:36:50+02:00, matthias.andree@gmx.de
  13 new addresses (upstream update 0.150->0.153)

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   24 +++++++++++++++++++++++-
# 1 files changed, 23 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.69    -> 1.70   
#	            shortlog	1.43    -> 1.44   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/07/30	matthias.andree@gmx.de	1.70
# 13 new addresses (upstream update 0.150->0.153)
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Wed Jul 30 10:38:42 2003
+++ b/shortlog	Wed Jul 30 10:38:42 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.150 2003/07/21 09:07:06 vita Exp $
+# $Id: lk-changelog.pl,v 0.153 2003/07/30 08:12:10 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -123,6 +123,7 @@
 'ac9410:attbi.com' => 'Albert Cranford',
 'ac9410:bellsouth.net' => 'Albert Cranford',
 'acher:in.tum.de' => 'Georg Acher',
+'achirica:telefonica.net' => 'Javier Achirica',
 'achirica:ttd.net' => 'Javier Achirica',
 'acme:brinquedo.oo.ps' => 'Arnaldo Carvalho de Melo',
 'acme:conectiva.com.br' => 'Arnaldo Carvalho de Melo',
@@ -241,6 +242,7 @@
 'bhavesh:avaya.com' => 'Bhavesh P. Davda',
 'bheilbrun:paypal.com' => 'Brad Heilbrun', # by himself
 'bjorn.andersson:erc.ericsson.se' => 'Björn Andersson', # google, guessed ö
+'bjorn.helgaas:hp.com' => 'Bjorn Helgaas',
 'bjorn.wesen:axis.com' => 'Bjorn Wesen',
 'bjorn_helgaas:hp.com' => 'Bjorn Helgaas',
 'bk:suse.de' => 'Bernhard Kaindl',
@@ -255,6 +257,7 @@
 'brm:murphy.dk' => 'Brian Murphy',
 'brownfld:irridia.com' => 'Ken Brownfield',
 'bryder:paradise.net.nz' => 'Bill Ryder',
+'buffer:antifork.org' => "Angelo Dell'Aera",
 'bunk:fs.tum.de' => 'Adrian Bunk',
 'buytenh:gnu.org' => 'Lennert Buytenhek',
 'bwa:us.ibm.com' => 'Bruce Allan',
@@ -557,6 +560,7 @@
 'jamey.hicks:hp.com' => 'Jamey Hicks',
 'jamey:crl.dec.com' => 'Jamey Hicks',
 'jamie:shareable.org' => 'Jamie Lokier',
+'jan:zuchhold.com' => 'Jan Zuchhold',
 'jani:astechnix.ro' => 'Jani Monoses',
 'jani:iv.ro' => 'Jani Monoses',
 'jasper:vs19.net' => 'Jasper Spaans',
@@ -605,6 +609,7 @@
 'jh:sgi.com' => 'John Hesterberg',
 'jhammer:us.ibm.com' => 'Jack Hammer',
 'jhartmann:addoes.com' => 'Jeff Hartmann',
+'jiho:c-zone.net' => 'Jim Howard',
 'jim.houston:attbi.com' => 'Jim Houston',
 'jkenisto:us.ibm.com' => 'James Keniston',
 'jkt:helius.com' => 'Jack Thomasson',
@@ -631,6 +636,7 @@
 'johnf:whitsunday.net.au' => 'John W. Fort',
 'johnpol:2ka.mipt.ru' => 'Evgeniy Polyakov',
 'johnstul:us.ibm.com' => 'John Stultz',
+'jones:ingate.com' => 'Jones Desougi',
 'josh:joshisanerd.com' => 'Josh Myer',
 'jsiemes:web.de' => 'Josef Siemes',
 'jsimmons:heisenberg.transvirtual.com' => 'James Simmons',
@@ -659,6 +665,7 @@
 'kai:vaio.(none)' => 'Kai Germaschewski',
 'kai:zephyr.physics.uiowa.edu' => 'Kai Germaschewski',
 'kala:pinerecords.com' => 'Tomas Szepe',
+'kambo77:hotmail.com' => 'Kambo Lohan',
 'kanoj:vger.kernel.org' => 'Kanoj Sarcar', # sent by Arnaldo Carvalho de Melo
 'kanojsarcar:yahoo.com' => 'Kanoj Sarcar',
 'kaos:ocs.com.au' => 'Keith Owens',
@@ -757,9 +764,11 @@
 'margitsw:t-online.de' => 'Margit Schubert-While',
 'marijnk:gmx.co.uk' => 'Marijn Kruisselbrink',
 'marius:citi.umich.edu' => 'Marius Aamodt Eriksen',
+'mark.fasheh:oracle.com' => 'Mark Fasheh',
 'mark:alpha.dyndns.org' => 'Mark W. McClelland',
 'mark:hal9000.dyndns.org' => 'Mark W. McClelland',
 'markh:osdl.org' => 'Mark Haverkamp',
+'martin.bene:icomedias.com' => 'Martin Bene',
 'martin.bligh:us.ibm.com' => 'Martin J. Bligh',
 'martin.schwidefsky:debitel.net' => 'Martin Schwidefsky',
 'martin:bruli.net' => 'Martin Brulisauer',
@@ -767,6 +776,7 @@
 'martin:meltin.net' => 'Martin Schwenke',
 'mashirle:us.ibm.com' => 'Shirley Ma',
 'mason:suse.com' => 'Chris Mason',
+'mathieu:newview.com' => 'Mathieu Chouquet-Stringer',
 'matt_domsch:dell.com' => 'Matt Domsch', # sent by himself
 'matthew:wil.cx' => 'Matthew Wilcox',
 'matthias.andree:gmx.de' => 'Matthias Andree', # added by himself
@@ -932,6 +942,7 @@
 'pmanolov:lnxw.com' => 'Petko Manolov',
 'pmenage:ensim.com' => 'Paul Menage',
 'porter:cox.net' => 'Matt Porter',
+'pp:netppl.fi' => 'Pekka Pietikäinen',
 'ppc64:brule.rchland.ibm.com' => 'Peter Bergner',
 'prom:berlin.ccc.de' => 'Ingo Albrecht',
 'proski:gnu.org' => 'Pavel Roskin',
@@ -1051,6 +1062,7 @@
 'smb:smbnet.de' => 'Stefan M. Brandl',
 'smurf:osdl.org' => 'Nathan Dabney',
 'snailtalk:linux-mandrake.com' => 'Geoffrey Lee', # by himself
+'sneakums:zork.net' => 'Sean Neakums',
 'solar:openwall.com' => 'Solar Designer',
 'solt:dns.toxicfilms.tv' => 'Maciej Soltysiak',
 'soruk:eridani.co.uk' => 'Michael McConnell',
@@ -1150,6 +1162,7 @@
 'varenet:parisc-linux.org' => 'Thibaut Varene',
 'vberon:mecano.gme.usherb.ca' => 'Vincent Béron',
 'venkatesh.pallipadi:intel.com' => 'Venkatesh Pallipadi',
+'vherva:niksula.hut.fi' => 'Ville Herva',
 'vinay-rc:naturesoft.net' => 'Vinay K. Nallamothu',
 'viro:math.psu.edu' => 'Alexander Viro',
 'viro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
@@ -1796,6 +1809,15 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.153  2003/07/30 08:12:10  vita
+# 3 new addresses
+#
+# Revision 0.152  2003/07/28 06:47:23  vita
+# added 9 names for new addresses
+#
+# Revision 0.151  2003/07/25 12:39:21  vita
+# add 1 address
+#
 # Revision 0.150  2003/07/21 09:07:06  vita
 # resort address->name hash with LC_ALL=POSIX sort -u
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.70
## Wrapped with gzip_uu ##


begin 600 bkpatch24480
M'XL(`!*$)S\``\U5;6_;-A#^'/V*0U/`&UHII&A9%@$'39IN3=-M08+NP[XQ
MTME2+(F:2#EIX)_;'[(3Y3B.T:+8RX?9@FSQ[KF[Y^XA=0B?#+;RH%+6YH4R
M@:JS%M$[A/?:6'FPJ.Z#K'^\TIH>CTQG\&B);8WET>D%7?[PX%NM2^.1XZ6R
M:0XK;(T\X('8KMC/#<J#JW<_?_IX<N5YLQF\S56]P&NT,)MY5K<K56;F38/U
MHBOJP+:J-A5:%:2Z6F]]UR%C(7UY*-@D2M9A,HFB-8881>F8JYMX&F,:>GM\
MW@P\GH<1+`XY2[C@;,UX+$+O#'@0,V#BB,5'@@%G4DQDQ%ZQ4#(&7P\*KSCX
MS#N%_YC"6R\%+J#&.U`9Y3,&#?S0-<:VJ"KHFDQ9!!;PB/G'_8_XT;L`Q^/R
MJ;>>_S<_GL<4\XZ?V.2ZPCTJ)M>M+?5B8!+Q*8O',9^N!8^3:#W'1,W3F"6*
M8:9NLF_T[5D4FH5@;"HFXV0MQIR%3B&/'L\$\J_K^98X]NK9:D,D8AP[;8S'
M^]H8)]_11BC`Y_\7<0R=_0W\]NZ^O_Q[DLHC[7^@E#/.@7OG[GX(+\\S">72
M3QT7BA@TY>N5*T)`W]--Y]A4\E!R!JO"*GAWW\!+BA%&%&2DTKQHBU1)BR7.
M=4U_@QKM"&;',/J@5@6V<++Q&;WVSL.QZ&$WM[JM@QS+A5)&YDW?TP%SVEO@
M_6!QB"AVB&X^IX-/U;:8ZW89Z';A`"].7.UPAF4Y.L%6O2!,%"4]YE;5\J%+
M\UR7V5.&#ZJ&/S:K?8()<PENBUS+U'_0->XP*"HZ6.]4.W@*5_PMN1A9U`L:
MV4[8?I7*,+I;%,Y[TK=YM%35C8YCF6M;J:)\`EST!OBHJ?N]>SS47"DB-U<F
MQUSJ5J7E3HI?R`8_.9M#3,(-PI(^;[!&69`O9KVL=T%DAE,R#Z!-&E(_=I($
M23.ZVW5W!CJ0=/=GA]:_MBU1Q;8'T\;JP4U#.-LT93`O!M0E+I<*+@NTQ?)+
M4:-CQ%GD^F5J5,NN,O*A']RVM]=(@_AU,#EW'CD^JQQIZ\FZ6)JN5$'>V6V:
MWXNR1!('V1TB3J:0]"\[7!6FT/5&NU\5KU,O^>YM0N]P'Q\^X<,I,#HS8DFG
MPB.>D)A!`K6J:-ZDQ>_%XSOQ:,^$4B0RY+OQ@#_B";U]`:<YIM2":I9,<"RF
,2GE_`5")/N3]!P``
`
end

