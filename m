Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264411AbUFGLgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbUFGLgl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 07:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264402AbUFGLgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 07:36:40 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:55180 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264414AbUFGLgh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:36:37 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon_Jun__7_11_36_27_UTC_2004_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20040607113627.5DD38C086B@merlin.emma.line.org>
Date: Mon,  7 Jun 2004 13:36:27 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.179, 2004-06-07 13:35:47+02:00, matthias.andree@gmx.de
  Merge Linus' und Matthias' version. Adds two mappings to BK (vita),
  corrects one in CVS.

(other patches not shown here, get them via BK pull to resynch)

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |    4 +++-
# 1 files changed, 3 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/07 13:35:47+02:00 matthias.andree@gmx.de 
#   Merge Linus' und Matthias' version. Adds two mappings to BK (vita),
#   corrects one in CVS.
# 
# shortlog
#   2004/06/07 13:35:47+02:00 matthias.andree@gmx.de +3 -1
#   Merge Linus' und Matthias' version. Adds two mappings to BK (vita),
#   corrects one in CVS.
# 
diff -Nru a/shortlog b/shortlog
--- a/shortlog	2004-06-07 13:36:27 +02:00
+++ b/shortlog	2004-06-07 13:36:27 +02:00
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.287 2004/06/03 14:17:25 vita Exp $
+# $Id: lk-changelog.pl,v 0.289 2004/06/07 11:35:46 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -725,6 +725,7 @@
 'habanero:us.ibm.com' => 'Andrew Theurer',
 'hadi:cyberus.ca' => 'Jamal Hadi Salim',
 'hadi:shell.cyberus.ca' => 'Jamal Hadi Salim',
+'hadi:zynx.com' => 'Jamal Hadi Salim',
 'hall:vdata.com' => 'Jeff Hall',
 'hammer:adaptec.com' => 'Jack Hammer',
 'hannal:us.ibm.com' => 'Hanna V. Linder',
@@ -1033,6 +1034,7 @@
 'kronos:kronoz.cjb.net' => 'Luca Tettamanti',
 'kuba:mareimbrium.org' => 'Kuba Ober',
 'kuebelr:email.uc.edu' => 'Robert Kuebel',
+'kumar.gala:freescale.com' => 'Kumar Gala',
 'kumarkr:us.ibm.com' => 'Krishna Kumar',
 'kunihiro:ipinfusion.com' => 'Kunihiro Ishiguro',
 'kurt.robideau:comtrol.com' => 'Kurt Robideau',	# wild guess

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.179
## Wrapped with gzip_uu ##


M'XL( #M3Q$   ]5474_;,!1]KG_%E4#J)DAJ.]^1BO@4L(*&BMB[22Y)U,2N
M8K>4*3]^;KNV L$#VUX66Y%N[O7Q/><>90\>-+9IKQ'&E)70KI!YBTCVX$II
MD_:*9N'FRW"LE T'>J9Q,,%68CTX'=GMK /'*%5K8@OOA,E*F&.KTQYSO>T7
M\S+%M#>^N'RX.1D3,AS"62ED@?=H8#@D1K5S4>?Z>(JRF%72-:V0ND$CW$PU
MW;:VXY1RNQCW:!@D'4_"(.B08Q!D/A./41QAQLD;/L=K'J]A?!K2B#'/IW%G
M\1@GY\!<%B5 _0$-!S0"YJ5>D/K1 >4II? ^*APP<"@YA7_,X8QD<(MM@7!3
MR9GNPTSF</N[A?Y*XDI)%T[R7(-Y5K:]Z;22A0T4G([@R[PRXNNA1<E4VV)F
M-"B)4$DX^W'ODA$PSBFYV\V!.)]\"*&"DJ,=\5(U^(:U+E5K:E6L20<LII$?
ML;CSK-!!]X2)>,HBF@B*N7C,/Y#X%<IF;H$?==3WDWCEIDW%*S/]=3\?&>F]
M?CP[Q-#C@;_V4< _[2,/'/8?^F@U@^_@M,^+Y786UE0;@?[ 4^>, 2/7J_<>
M[%_G*=03)UNQMHCNM#Z< W5YG,!2_8W$;"5Q"-@T BX64]@GUQ&W"=(O15ZE
M/U_D8JE?'X9'T/\F&E'#E4W O:BKIG]H;Z1>L"R?S!K1NH6H1?IDQZ,S4>/N
AY&B9A4N;M6>VO[>LQ&RB9\W0\T*,8L[)+QQ*U 1;!0  
 

