Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTE2LNe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 07:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTE2LNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 07:13:33 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:50693 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262153AbTE2LNS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 07:13:18 -0400
MIME-Version: 1.0
To: torvalds@transmeta.com
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Thu_May_29_11_26_30_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030529112630.3015559DA5@merlin.emma.line.org>
Date: Thu, 29 May 2003 13:26:30 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use bk receive to patch this mail, you can pull from
bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no trailing slash)
or you can apply the patch below.

Patch description:
10 new addresses

Matthias
##### DIFFSTAT #####
# shortlog |   24 +++++++++++++++++++++++-
# 1 files changed, 23 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.52    -> 1.53   
#	            shortlog	1.26    -> 1.27   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/29	matthias.andree@gmx.de	1.53
# Add 10 new addresses
# (upstream update 0.116 -> 0.120)
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Thu May 29 13:26:27 2003
+++ b/shortlog	Thu May 29 13:26:28 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.116 2003/05/15 08:52:06 vita Exp $
+# $Id: lk-changelog.pl,v 0.120 2003/05/29 11:11:22 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -224,6 +224,7 @@
 'bjorn.andersson:erc.ericsson.se' => 'Björn Andersson', # google, guessed ö
 'bjorn.wesen:axis.com' => 'Bjorn Wesen',
 'bjorn_helgaas:hp.com' => 'Bjorn Helgaas',
+'bk:suse.de' => 'Bernhard Kaindl',
 'blaschke:blaschke3.austin.ibm.com' => 'Dave Blaschke',
 'blueflux:koffein.net' => 'Oskar Andreasson',
 'bmatheny:purdue.edu' => 'Blake Matheny', # google
@@ -374,6 +375,7 @@
 'ebrower:resilience.com' => 'Eric Brower',
 'ebrower:usa.net' => 'Eric Brower',
 'ecd:skynet.be' => 'Eddie C. Dost',
+'eddie.williams:steeleye.com' => 'Eddie Williams',
 'edv:macrolink.com' => 'Ed Vance',
 'edward_peng:dlink.com.tw' => 'Edward Peng',
 'efocht:ess.nec.de' => 'Erich Focht',
@@ -475,6 +477,7 @@
 'henning:meier-geinitz.de' => 'Henning Meier-Geinitz',
 'henrique2.gobbi:cyclades.com' => 'Henrique Gobbi',
 'henrique:cyclades.com' => 'Henrique Gobbi',
+'herbert:gondor.apana.org.au' => 'Herbert Xu',
 'hermes:gibson.dropbear.id.au' => 'David Gibson',
 'hirofumi:mail.parknet.co.jp' => 'Hirofumi Ogawa', # corrected by himself
 'hoho:binbash.net' => 'Colin Slater',
@@ -633,6 +636,7 @@
 'kronos:kronoz.cjb.net' => 'Luca Tettamanti',
 'kuba:mareimbrium.org' => 'Kuba Ober',
 'kuebelr:email.uc.edu' => 'Robert Kuebel',
+'kumarkr:us.ibm.com' => 'Krishna Kumar',
 'kunihiro:ipinfusion.com' => 'Kunihiro Ishiguro',
 'kuznet:mops.inr.ac.ru' => 'Alexey Kuznetsov',
 'kuznet:ms2.inr.ac.ru' => 'Alexey Kuznetsov',
@@ -658,6 +662,7 @@
 'lists:mdiehl.de' => 'Martin Diehl',
 'liyang:nerv.cx' => 'Liyang Hu',
 'lkml:shemesh.biz' => 'Shachar Shemesh',
+'lkml001:vrfy.org' => 'Kay Sievers',
 'lm:bitmover.com' => 'Larry McVoy',
 'lm:work.bitmover.com' => 'Larry McVoy',
 'lopezp:grupocp.es' => 'Jose A. Lopez',
@@ -716,6 +721,7 @@
 'mec:shout.net' => 'Michael Elizabeth Chastain',
 'meissner:suse.de' => 'Marcus Meissner',
 'mgreer:mvista.com' => 'Mark A. Greer', # lbdb
+'mhoffman:lightlink.com' => 'Mark M. Hoffman',
 'mhopf:innominate.com' => 'Mark-André Hopf',
 'michaelw:foldr.org' => 'Michael Weber', # google
 'michal:harddata.com' => 'Michal Jaegermann',
@@ -734,6 +740,7 @@
 'mingo:earth2.(none)' => 'Ingo Molnar',
 'mingo:elte.hu' => 'Ingo Molnar',
 'mingo:redhat.com' => 'Ingo Molnar',
+'minyard:acm.org' => 'Corey Minyard',
 'mitch:sfgoth.com' => 'Mitchell Blank Jr.',
 'miyazawa:linux-ipv6.org' => 'Kazunori Miyazawa',
 'mj:ucw.cz' => 'Martin Mares',
@@ -755,6 +762,7 @@
 'msdemlei:cl.uni-heidelberg.de' => 'Markus Demleitner',
 'msw:redhat.com' => 'Matt Wilson',
 'mufasa:sis.com.tw' => 'Mufasa Yang', # sent by himself
+'muizelaar:rogers.com' => 'Jeff Muizelaar',
 'mulix:actcom.co.il' => 'Muli Ben-Yehuda', # sent by himself
 'mulix:mulix.org' => 'Muli Ben-Yehuda',
 'mw:microdata-pos.de' => 'Michael Westermann',
@@ -937,6 +945,7 @@
 'sawa:yamamoto.gr.jp' => 'sawa',
 'scameron:quandary.cca.cpqcorp.net' => 'Steve Cameron',
 'schlicht:uni-mannheim.de' => 'Thomas Schlichter',
+'shmulik.hen:intel.com' => 'Shmulik Hen',
 'schoenfr:gaaertner.de' => 'Erik Schoenfelder',
 'schwab:suse.de' => 'Andreas Schwab',
 'schwidefsky:de.ibm.com' => 'Martin Schwidefsky',
@@ -1062,6 +1071,7 @@
 'vs:tribesman.namesys.com' => 'Vladimir Saveliev',
 'wa:almesberger.net' => 'Werner Almesberger',
 'wahrenbruch:kobil.de' => 'Thomas Wahrenbruch',
+'walter.harms:informatik.uni-oldenburg.de' => 'Walter Harms',
 'warlord:mit.edu' => 'Derek Atkins',
 'warp:mercury.d2dc.net' => 'Zephaniah E. Hull',
 'wayne:stallion.oz.au' => 'Wayne Piekarski',
@@ -1690,6 +1700,18 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.120  2003/05/29 11:11:22  vita
+# added 2 names for new addresses
+#
+# Revision 0.119  2003/05/26 13:45:55  vita
+# added 2 names for new addresses
+#
+# Revision 0.118  2003/05/23 11:07:37  vita
+# added 5 names for new addresses
+#
+# Revision 0.117  2003/05/23 09:31:17  emma
+# Add Bernhard Kaindl's address.
+#
 # Revision 0.116  2003/05/15 08:52:06  vita
 # added 4 names for new addresses
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.53
## Wrapped with gzip_uu ##


begin 600 bkpatch12703
M'XL(`&3NU3X``\U586_;-A#]'/V*`U(@&UK))"5*%@$';=*@R=R@18*B^TI;
M9TNP2!FDY,2#?_Q(*8X;H\6V;A]F"X9)OGO'=WQ'G<(7BT:<*-FV925M)'5A
M$(-3N&YL*TZ6ZC$J_/"N:=QP9#N+HQ4:C?7H8NJ><!B$;=/4-G#`S[*=E[!!
M8\4)C>+GF7:[1G%R=_7AR\=W=T$PF<!E*?42[[&%R21H&[.1=6'?KE$ONTI'
MK9':*FQE-&_4[AF[8X0P]Z4L)BG/=RQ/.=\A0\[G"96S;)SAG`5'>MX..E[2
MQ(133A-*"=MQ3M-Q\!YHQ&,@\8CP$<N!QH(E@I/7A`E"X/ND\)I"2((+^(\E
M7`9S>%<40`EH?`!9N)S6HG73OW1KVQJ4"KIU(5L$$E&:0GCN_S#R:S`%)VC,
M@L^'(@?A/_P$`9$D.#_(*AN%1YILV9BV;I:#))>29$E&Q[N89CG?+3"7BWE&
M<DFPD+/B!P5\P>(.A>64LB3)=W%"$MY;98]XX91_O9\?N>1H/\\FB?,D)KU)
M6'9LDB3_"Y.P&$+Z?W/)4.%/$)J'1_^$C\XR>_D_X9CWE`(-;OK?4WAU4PBH
M5^&\U^08HW7]9C-D!U_;?06I<`]CL*E:"5>/:W@5W#"6.I*SV4KX.\>5\`PF
MYW!VX:Z;4IH"IK+217WV)KB)LQZ)15%A]%#5=265%;9%K'&+OJI#Z)4'P-<G
M@(],LLQ'EFAF:%JQ;'31F$BNI9918Y:1[(;(ZP$`OW<^*HVYCUIU2IJ5$9V-
MJIDZI)F:RI9:PM2O]_B4>'R]4C4A5&S,8NO9G]!R"_<5^OO28YU9/5:5S6*A
MI!9UM2S;NM*K`_^MRPJWD;N@>T@?%?<54)7>NM((.5>'!)>-P2W<#DL]F/>B
M55?]@;641IAFZ;(?$OR&BP7<[I=]2![G/L26JJNK552B%I5NL3[$W`]+<(W]
MABA)$Q_Q(.L63>0.S)U(I1>-<>WA&#I=A4U=H)YUKLS[L_W:H^':HWN6-&=`
MF7_[X*:R5:.?O/-=\_3N<5C7`E@``RT56G`ICQKC](B/YM_PI;Z=$RXX_WF^
M\3=\L=\?R42<'?'QO\^7O>`CN8B=9#>)2GD^W_W'76'W?)&C>WX%STN<KVRG
1)BF7>3Q.TN!/TC&55?\'````
`
end

