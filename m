Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265014AbTFTWwk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 18:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265018AbTFTWwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 18:52:40 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:59400 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265014AbTFTWwd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 18:52:33 -0400
MIME-Version: 1.0
To: torvalds@transmeta.com
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Fri_Jun_20_23_06_32_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030620230632.A084680F32@merlin.emma.line.org>
Date: Sat, 21 Jun 2003 01:06:32 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use bk receive to patch this mail, you can pull from
bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no trailing slash)
or you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
7 new address -> name mappings.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   15 ++++++++++++++-
# 1 files changed, 14 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.60    -> 1.61   
#	            shortlog	1.34    -> 1.35   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/21	matthias.andree@gmx.de	1.61
# 7 new address -> name mappings.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Sat Jun 21 01:06:31 2003
+++ b/shortlog	Sat Jun 21 01:06:31 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.132 2003/06/17 14:53:29 emma Exp $
+# $Id: lk-changelog.pl,v 0.134 2003/06/20 09:15:01 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -162,6 +162,7 @@
 'alexander.schulz:com.rmk.(none)' => 'Alexander Schulz',
 'alexander.schulz:innominate.com' => 'Alexander Schulz',
 'alexey:technomagesinc.com' => 'Alex Tomas',
+'alext:fc.hp.com' => 'Alex Tsariounov',
 'alfre:ibd.es' => 'Alfredo Sanjuán',
 'ambx1:neo.rr.com' => 'Adam Belay',
 'amunoz:vmware.com' => 'Alberto Munoz',
@@ -266,6 +267,7 @@
 'ch:murgatroid.com' => 'Christopher Hoover',
 'chan:aleph1.co.uk' => 'Tak-Shing Chan',
 'charles.white:hp.com' => 'Charles White',
+'chas:cmd.nrl.navy.mil' => 'Chas Williams',
 'chas:cmf.nrl.navy.mil' => 'Chas Williams',
 'chas:locutus.cmf.nrl.navy.mil' => 'Chas Williams',
 'chessman:tux.org' => 'Samuel S. Chessman',
@@ -472,6 +474,7 @@
 'gwehrman:sgi.com' => 'Geoffrey Wehrman',
 'hadi:cyberus.ca' => 'Jamal Hadi Salim',
 'hannal:us.ibm.com' => 'Hanna V. Linder',
+'hanno:gmx.de' => 'Hanno Böck',
 'harald:gnumonks.org' => 'Harald Welte',
 'haveblue:us.ibm.com' => 'Dave Hansen',
 'hawkes:oss.sgi.com' => 'John Hawkes',
@@ -532,6 +535,7 @@
 'jani:astechnix.ro' => 'Jani Monoses',
 'jani:iv.ro' => 'Jani Monoses',
 'javaman:katamail.com' => 'Paulo Ornati',
+'jay.estabrook:compaq.com' => 'Jay Estabrook',
 'jb:jblache.org' => 'Julien Blache',
 'jbarnes:sgi.com' => 'Jesse Barnes',
 'jbglaw:lug-owl.de' => 'Jan-Benedict Glaw',
@@ -671,6 +675,7 @@
 'lee:compucrew.com' => 'Lee Nash', # lbdb
 'legoll:free.fr' => 'Vincent Legoll', # correction sent by himself
 'leigh:solinno.co.uk' => 'Leigh Brown', # lbdb
+'lenehan:twibble.org' => 'Jamie Lenehan',
 'lethal:linux-sh.org' => 'Paul Mundt',
 'levon:movementarian.org' => 'John Levon',
 'lfo:polyad.org' => 'Luis F. Ortiz',
@@ -900,6 +905,7 @@
 'ramune:net-ronin.org' => 'Daniel A. Nobuto',
 'randolph:tausq.org' => 'Randolph Chung',
 'randy.dunlap:verizon.net' => 'Randy Dunlap',
+'ranty:debian.org' => 'Manuel Estrada Sainz',
 'raul:pleyades.net' => 'Raul Nunez de Arenas Coronado',
 'ray-lk:madrabbit.org' => 'Ray Lee',
 'rbh00:utsglobal.com' => 'Richard Hitt', # asked him, he prefers Richard
@@ -1014,6 +1020,7 @@
 'srk:thekelleys.org.uk' => 'Simon Kelley',
 'srompf:isg.de' => 'Stefan Rompf',
 'stanley.wang:linux.co.intel.com' => 'Stanley Wang',
+'stefan.becker:nokia.com' => 'Stefan Becker',
 'stefan.eletzhofer:eletztrick.de' => 'Stefan Eletzhofer',
 'steiner:sgi.com' => 'Jack Steiner',
 'stekloff:w-stekloff.beaverton.ibm.com' => 'Daniel Stekloff',
@@ -1733,6 +1740,12 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.134  2003/06/20 09:15:01  vita
+# add 5 names for new addresses
+#
+# Revision 0.133  2003/06/18 05:59:12  vita
+# add 2 names for new addresses
+#
 # Revision 0.132  2003/06/17 14:53:29  emma
 # Rearrange Peter Milne's addresses.
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.61
## Wrapped with gzip_uu ##


begin 600 bkpatch13238
M'XL(`'>3\SX``\5576_3,!1]GG_%E8:T!TAJ)W'<6.H$@XF-#X$V$,]N<MN&
M)G:)W:Y%_=T\8Z=L9=.&Q(=$&U6Q?>ZYY]Y[FAS"1XN=/&B5<[-:V5CIJD,D
MAW!FK),'TW8=5V%Y88Q?#NS2XF".G<9F</+:7]%N$3EC&DL\\+URY0Q6V%EY
MP.+T9L=M%B@/+DY??GSS[(*0T0B>SY2>XB4Z&(V(,]U*-95]ND`]7=8Z=IW2
MMD6GXM*TVQOL-J$T\5^6I#3GQ38I<LZWF"#G9<;46`P%E@FY4\_371VW:3P!
M$RSC>9)O*1,I(R^`Q3D#F@YH/DC\#9.42RX>TT12"O>3PF,&$24G\(]+>$Y*
M$*#Q"E3ETUD+T3%HU:+7L5C4>FIC\AJ82`1YO^\EB7[S0PA5E!SOU<],BW>D
MVYGI7&.F.^6<#:G(!!MN4R8*OIU@H2:EH(6B6*EQ]4"?;K'XRGT+4LJYV-(L
MXTGOB&O$+4/\M9Z'S'!'SXT7THRRM/="RG_?"QE$['^9H6_D.XBZJW6XHK5W
MQG65?V",%XP!(^?][R$\.J\D-/.H[*5[QGC1/%D!C5F:06AAWR@*M)",2\I@
M53L%I^L%//(<>>9)CE2#:R<G93Q;A#8<P>@8CI[Y3?A@55>;I3:KHR?D/,F'
M`>Y365FV5:R[)M9JM8G;NMD%^09:^%0W3:U:&T(RT6?PXK21NVGLD&=A!TZ^
ME?,`XVD/^ZPV,5JGQITQ<^FE+-27O:)7:@.GUZ<A*A=IB&I0HT\@W54]'C<8
MFVYZ'=#6"&]VQR&@H$D(\#-W&UGAN%9ZCWZK]!*;D*%3E8)+5>NO(8A1EH<H
MZW#B\6,L_<-5:C.OU5[;97\()_UA'R6\3?/PB,95;6NC?XSDWIGT0_%8[R+@
MO8$L3$SWL[/0DL.[;.F>C0TA_`\\87*++?D%V\U+H)QYV7;9CI#EHBP*2KX#
(DLC^,X$&````
`
end

