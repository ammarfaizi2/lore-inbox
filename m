Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbUENUIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUENUIy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 16:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbUENUIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 16:08:54 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:3268 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262476AbUENUIt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 16:08:49 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Fri_May_14_20_08_44_UTC_2004_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20040514200844.AB83CBAF22@merlin.emma.line.org>
Date: Fri, 14 May 2004 22:08:44 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.169, 2004-05-14 22:07:25+02:00, matthias.andree@gmx.de
  Add address for Adam Radford. (Matthias Andree)
  Three new addresses. (Deepax Saxena)

These patches are not included and must be pulled from the address
above.

ChangeSet@1.168, 2004-05-14 02:17:33+02:00, matthias.andree@gmx.de
  Pull one downstream address into upstream (Jon Krueger).
  Vita: more than a dozen new addresses.

ChangeSet@1.166, 2004-05-10 00:29:59+02:00, matthias.andree@gmx.de
  New address for Josh Kwan.

ChangeSet@1.165, 2004-05-08 02:30:26+02:00, matthias.andree@gmx.de
  four new addresses (2 for 2.4, 2 for 2.6)

ChangeSet@1.164, 2004-05-07 20:28:55+02:00, matthias.andree@gmx.de
  (vita) one new address

ChangeSet@1.163, 2004-05-05 20:25:54+02:00, matthias.andree@gmx.de
  2 new addresses


Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |    6 +++++-
# 1 files changed, 5 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/05/14 22:07:25+02:00 matthias.andree@gmx.de 
#   Add address for Adam Radford. (Matthias Andree)
#   Three new addresses. (Deepax Saxena)
# 
# shortlog
#   2004/05/14 22:07:24+02:00 matthias.andree@gmx.de +5 -1
#   Add address for Adam Radford. (Matthias Andree)
#   Three new addresses. (Deepax Saxena)
# 
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Fri May 14 22:08:44 2004
+++ b/shortlog	Fri May 14 22:08:44 2004
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.279 2004/05/14 00:17:32 emma Exp $
+# $Id: lk-changelog.pl,v 0.281 2004/05/14 20:07:18 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -253,6 +253,7 @@
 'ap:cipherica.com' => 'Alex Pankratov',
 'apolkosnik:directvinternet.com' => 'Adam Polkosnik',
 'apw:shadowen.org' => 'Andy Whitcroft',
+'aradford:amcc.com' => 'Adam Radford',
 'arashi:yomerashi.yi.org' => 'Matt Reppert',
 'arekm:pld-linux.org' => 'Arkadiusz Miskiewicz', # lbdb
 'arief_m_utama:telkomsel.co.id' => 'Arief Mulya Utama',
@@ -540,6 +541,8 @@
 'dsaxena:mvista.com' => 'Deepak Saxena',
 'dsaxena:net.rmk.(none)' => 'Deepak Saxena',
 'dsaxena:plexity.net' => 'Deepak Saxena',
+'dsaxena:xanadu.(none)' => 'Deepak Saxena'
+'dsaxena:omelas.(none)' => 'Deepak Saxena'
 'dsd:gentoo.org' => 'Daniel Drake',
 'dsteklof:us.ibm.com' => 'Daniel E. F. Stekloff',
 'dth:dth.net' => 'Danny ter Haar', # guessed
@@ -1795,6 +1798,7 @@
 'xose:wanadoo.es' => 'Xose Vazquez Perez', # lbdb
 'xschmi00:stud.feec.vutbr.cz' => 'Michal Schmidt',
 'y.rutschle:com.rmk.(none)' => 'Yves Rutschle',
+'y.rutschle:indigovision.com' => 'Yves Rutschle',
 'ya:slamail.org' => 'Yaacov Akiba Slama',
 'yasuyuki.kozakai:toshiba.co.jp' => 'Yasuyuki Kozakai',
 'yinah:couragetech.com.cn' => 'Yin Aihua',

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.169
## Wrapped with gzip_uu ##


M'XL( $PGI4   ]5476^;,!1]CG_%E5HIC5J([>"2(*7JI[JHFU:EZ\,>77P3
MHH =89)2B1\_!Y)F;==-^W@9(/!%QY=SSCUB#^XMYE$KDT61S*3UI58Y(MF#
M#\8646N:E;Y:EV-C7-FU2XO=.>8:T^[YC;N\IO *8U)+'/!6%G$"*\QMU&)^
M[_E-\;3 J#6^NK[_>#8F9#B$BT3J*=YA <,A*4R^DJFRIPO4T^5,^T4NM<VP
MD'YLLNH96W%*N3L9[]%C,:CXX%B("CD*$0=,/H3]$&-.7NDY;72\;!-0P0)*
M6=CK5:X?"\@E,)\=#X &72JZ+ #.(QI&7!Q2MZ#PXZYPR,"CY!S^L88+$L.9
M4B"5^YBU,#&YJV4&8ZG<6OEP\&E#",YJ0AVWXTOB%J#Q<;L/K0->(BYD"7>R
M1"T[Y 88IP&YW<V >+]Y$$(E)2<[T8G)\)5BFYB\2,VT$2Q8GX9!R/I5CX4#
M44UP("=Q2 >2HI(/ZAU[7W2I9^:>(0^JP)G7JY.T1;P(TE_S>2]$;_AL,L1%
M/PR;# 7\38:"7V1(@,?^LPPU _@,7OY8KB^O=(G:NO,'@;ID#!@9U?<]V!^I
M"-*Y%]>274=_D1ZM@/J\SV!M_=9?NO:7]0&S3,)5N8!],N)"N"9MF3<R(YG%
M\=K -@Q/H/V] ^TC,A)N7IRTE:VE1:744BW] VTT=IH=M?;Y1GM[!W492]TL
M?P(=N6R%:RY/?KXL;)RD&,VTFDW-:F9G1N]8?5VAA?$&XV@]_SKC!..Y769#
0,1$3-V=.O@'.@V2\MP4     
 

