Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUCDRKk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 12:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbUCDRKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 12:10:40 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:53145 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262029AbUCDRJr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 12:09:47 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Thu_Mar__4_17_09_44_UTC_2004_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20040304170944.2B588AA95E@merlin.emma.line.org>
Date: Thu,  4 Mar 2004 18:09:44 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.128, 2004-03-04 18:05:50+01:00, matthias.andree@gmx.de
  2 new addresses, 2 corrections.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |    8 +++++---
# 1 files changed, 5 insertions(+), 3 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/03/04 18:05:50+01:00 matthias.andree@gmx.de 
#   2 new addresses, 2 corrections.
# 
# shortlog
#   2004/03/04 18:05:45+01:00 matthias.andree@gmx.de +5 -3
#   2 new addresses, 2 corrections.
# 
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Thu Mar  4 18:09:43 2004
+++ b/shortlog	Thu Mar  4 18:09:43 2004
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.236 2004/02/29 21:49:46 emma Exp $
+# $Id: lk-changelog.pl,v 0.238 2004/03/04 16:53:25 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -236,7 +236,7 @@
 'aris:cathedrallabs.org' => 'Aristeu Sergio Rozanski Filho',
 'arjan:redhat.com' => 'Arjan van de Ven',
 'arjanv:redhat.com' => 'Arjan van de Ven',
-'armcc2000:com.rmk.(none)' => 'Andre',
+'armcc2000:com.rmk.(none)' => 'Andre McCurdy',
 'armin:melware.de' => 'Armin Schindler',
 'arnaud.quette:mgeups.com' => 'Arnaud Quette',
 'arnd:arndb.de' => 'Arnd Bergmann',
@@ -280,6 +280,7 @@
 'bdschuym:pandora.be' => 'Bart De Schuymer',
 'beattie:beattie-home.net' => 'Brian Beattie', # from david.nelson
 'bellucda:tiscali.it' => 'Daniele Bellucci',
+'bengen:hilluzination.de' => 'Hilko Bengen',
 'benh:kernel.crashing.org' => 'Benjamin Herrenschmidt',
 'benh:zion.wanadoo.fr' => 'Benjamin Herrenschmidt',
 'berentsen:sent5.uni-duisburg.de' => 'Martin Berentsen',
@@ -1483,7 +1484,7 @@
 'timw:splhi.com' => 'Tim Wright',
 'tinglett:vnet.ibm.com' => 'Todd Inglett',
 'tiwai:suse.de' => 'Takashi Iwai',
-'tlnguyen:snoqualmie.dp.intel.com' => 'long (tlnguyen)',
+'tlnguyen:snoqualmie.dp.intel.com' => 'Tom L. Nguyen',
 'tmcreynolds:nvidia.com' => 'Tom McReynolds',
 'tmolina:cablespeed.com' => 'Thomas Molina',
 'tmolina:cox.net' => 'Thomas Molina',
@@ -1597,6 +1598,7 @@
 'yoshfuji:linux-ipv6.org' => 'Hideaki Yoshifuji', # lbdb
 'yoshfuji:nuts.ninka.net' => 'Hideaki Yoshifuji',
 'ysato:users.sourceforge.jp' => 'Yoshinori Sato', # lbdb
+'ysauyuki.kozakai:toshiba.co.jp' => 'Yasuyuki Kozakai', # typo
 'yuasa:hh.iij4u.or.jp' => 'Yoichi Yuasa',
 'yuri:acronis.com' => 'Yuri Per', # lbdb
 'zaitcev:redhat.com' => 'Pete Zaitcev',

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.128
## Wrapped with gzip_uu ##


M'XL( -AB1T   \546VO;,!A]CG[%!REDH[$BR59B&U)Z25E+NZUTZ\,>%5N-
M/5^467*:%/_XR39M:6D9N\!L8R%QSJ?S'1TTA!LMJW!0"&.25&@LRKB2$@WA
M3&D3#E;%%L?M]%HI.YWH6LM))JM2YI/C"_LY_<0Q2N4:6>"5,%$"&UGI<$"Q
M^[AB=FL9#JY//]Q<'ETC-)_#22+*E?PB#<SGR*AJ(_)8'ZYEN:K3$IM*E+J0
M1N!(%<TCMF&$,/M2YI(I#QH63#EO)).<1QX5RYD_DQ%#+_HY[/MX7L8C+O'H
MC' R;6P]1M$"**;,!^)-B#LA'E _)#SD9)_0D!!XO2KL4W (.H9_W,,)BH!!
M*>] Q'8[K:4>VX5(596,3*I*C=$%4$8"=/5D)G)^\T&("((.GM0GJI OI.M$
M5297JUXYISZ9>3/J-RZ=!;RYE8&XC68D$$3&8AF_X=.S*H_F>[PAS/=X%XD'
MQ+-$_+6>M]+PJAX;!NY[@=^'@="78?#X+\+ P7'_5Q@Z(S^#4]UMV\_9VF0\
M=/D'P5A0"A2==_\A[)W'(>29$W72;46\SL<;()BY/K06/O@T#;D;,@Z;U @X
MW:YA#RV8&[2E^F$DJB**+(6$U@M<%1E^5ZI2OA_!_ !&1ZVA\#$ZJ:MX-QI;
MEL]:UM(Z*<LP2?.\OD]+T;9M+>])9VF>*3CN():SH)X_[<3WX\CD]AAVEJY+
M]:,6>9%*'*]Q6AJ9MR?25_FJ"KC$\*F#MEM3'G2*=UK4NSI+<:;N12;2T"B=
MI,OV,/'W=4_^)G2'@8L>,QK#L+WWU-.]&"4RRG1=S#V/,Y_R&/T$I?0-CX(%
"    
 

