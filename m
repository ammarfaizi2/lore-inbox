Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264770AbTFQOmN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 10:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264769AbTFQOmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 10:42:09 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:50698 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264761AbTFQOkc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 10:40:32 -0400
MIME-Version: 1.0
To: torvalds@transmeta.com
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue_Jun_17_14_54_25_UTC_2003_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20030617145425.3C5BB89D0D@merlin.emma.line.org>
Date: Tue, 17 Jun 2003 16:54:25 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use bk receive to patch this mail, you can pull from
bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no trailing slash)
or you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
Merge Linus' BK changes and Vita's CVS changes together.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   15 +++++++++++++--
# 1 files changed, 13 insertions(+), 2 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.58    -> 1.59   
#	            shortlog	1.32    -> 1.33   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/17	matthias.andree@gmx.de	1.59
# Merge new addresses.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Tue Jun 17 16:54:24 2003
+++ b/shortlog	Tue Jun 17 16:54:24 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.128 2003/06/09 10:20:37 emma Exp $
+# $Id: lk-changelog.pl,v 0.131 2003/06/16 10:49:57 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -144,6 +144,7 @@
 'aia21:cus.cam.ac.uk' => 'Anton Altaparmakov',
 'ajoshi:kernel.crashing.org' => 'Ani Joshi',
 'ajoshi:shell.unixbox.com' => 'Ani Joshi',
+'ak:colin.muc.de' => 'Andi Kleen',
 'ak:muc.de' => 'Andi Kleen',
 'ak:suse.de' => 'Andi Kleen',
 'akpm:digeo.com' => 'Andrew Morton',
@@ -223,7 +224,7 @@
 'berny.f:aon.at' => 'Bernhard Fischer',
 'bero:arklinux.org' => 'Bernhard Rosenkraenzer',
 'bfennema:falcon.csc.calpoly.edu' => 'Ben Fennema',
-'bfields:citi.umich.edu' => 'Bruce Fields',
+'bfields:citi.umich.edu' => 'J. Bruce Fields',
 'bgerst:didntduck.org' => 'Brian Gerst',
 'bhards:bigpond.net.au' => 'Brad Hards',
 'bhavesh:avaya.com' => 'Bhavesh P. Davda',
@@ -310,6 +311,7 @@
 'dan:debian.org' => 'Daniel Jacobowitz',
 'dana.lacoste:peregrine.com' => 'Dana Lacoste',
 'danc:mvista.com' => 'Dan Cox', # some CREDITS patch found by google
+'daniel.ritz:ch.rmk.(none)' => 'Daniel Ritz',
 'daniel.ritz:gmx.ch' => 'Daniel Ritz',
 'daniel:osdl.org' => 'Daniel McNeil',
 'dank:kegel.com' => 'Dan Kegel',
@@ -1731,6 +1733,15 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.131  2003/06/16 10:49:57  vita
+# add 5 names for new addresses
+#
+# Revision 0.130  2003/06/12 15:27:32  vita
+# add 5 names for new addresses
+#
+# Revision 0.129  2003/06/10 16:10:48  vita
+# add 3 names for new addresses
+#
 # Revision 0.128  2003/06/09 10:20:37  emma
 # Merge Linus' additions in. Resort address->name hash with LANG=C sort -u.
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.33
## Wrapped with gzip_uu ##


begin 600 bkpatch11445
M'XL(`*`K[SX``\U5;6^;,!#^'/^*4[H/>RE@C`T$*=/:9NJBKFJ4JC_`P"5!
MX27"3K=)_/@9HB1=U:5MMDGC39Q]=SR^YSES`G<*ZZA72*T7F52V+-,:D9S`
METKIJ#<OOMMI:TZKRIB.6BMTEEB7F#OG5^:R-H:EJRI7Q#A.I$X6<(^UBGJN
M[>U&](\51KWIY\N[KV=30H9#N%C(<HZWJ&$X)+JJ[V6>JD\K+.?KK+1U+4M5
MH)9V4A7-SK=AE#)SNLRCOA@T;.`+T2!#(1+NRC@(`TS8/MVB*O!0+H^ZW4VY
M:(0(`DI&8&![0#V'N@YEX`81%1'S+1I&E,*!S/"!@47).?SEQ5R0!"YRE"6L
M5W`MESC+<CP%F:;0CY=UWWP/\DQIJ&;03JEV(&D#3DU$*C5"-B^K&KM9FUR!
M$)QS,ME30*Q7'H102<G'YY9ZGNDKQ!76#NK$V:!XO&K/\UC82'3CQ`]P$%,9
M>[/D4*%_FW;+IF!^0[G/_.<1;NOY$%7`@\98S&N\4"*RA`GFQ7$8^`=1/4SU
M"Y)0N(-.\D_A?H'ZCZ_BGV8.*&VHZP]$UQ;LN*[@_ZPK[C;J[F^`]SM]&WEW
MS-^`57_K+J/6R9.E/T+U8P:<F*8CA<QRM<HS3=)L-MN\%<L.0,OT5@LO8/=U
M"CRXM3VE0,IYX_(P8!V%_&@*_?]I8VLWL:ZK'K&\37($LR,.+AFWC\GTYG)Z
M=GT[W'$,.XYAPS&T$ACYP,@X,!$RSR-X\W8;^(Z,!N"1L>L:APYO1'IU`=;L
>H1.\MZO]'S-98+)4ZV+(,31\AS'Y"45H@U*<!P``
`
end

