Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbUGBKlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUGBKlR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 06:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUGBKlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 06:41:16 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:40118 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261914AbUGBKkU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 06:40:20 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Fri_Jul__2_10_40_16_UTC_2004_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040702104017.0934EC0D6B@merlin.emma.line.org>
Date: Fri,  2 Jul 2004 12:40:17 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please pull a new version of "shortlog"
from bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools

BK: Parent repository is http://bktools.bkbits.net/bktools

Tree change log:

ChangeSet@1.196, 2004-07-02 12:36:36+02:00, matthias.andree@gmx.de
  vita: five new addresses

ChangeSet@1.195, 2004-06-30 10:14:46+02:00, matthias.andree@gmx.de
  vita: added 12 addresses

ChangeSet@1.194, 2004-06-30 04:28:43+02:00, matthias.andree@gmx.de
  vita: 2 new addresses

ChangeSet@1.193, 2004-06-28 14:46:10+02:00, matthias.andree@gmx.de
  vita: one new address

ChangeSet@1.192, 2004-06-28 08:41:57+02:00, matthias.andree@gmx.de
  vita:
  added 6 new addresses; re-sorted

ChangeSet@1.191, 2004-06-25 13:23:14+02:00, matthias.andree@gmx.de
  vita: new addresses

ChangeSet@1.190, 2004-06-24 16:35:14+02:00, matthias.andree@gmx.de
  vita:
   - 8 new addresses
   - collect address translations from "Signed-off-by:" lines also;
     don't insist on colon in "From: name <address>" lines

ChangeSet@1.189, 2004-06-23 10:17:55+02:00, matthias.andree@gmx.de
  Four new addresses.

ChangeSet@1.188, 2004-06-22 16:12:38+02:00, matthias.andree@gmx.de
  vita: 2 new addresses

ChangeSet@1.187, 2004-06-21 09:56:53+02:00, matthias.andree@gmx.de
  vita: 33 new addresses

ChangeSet@1.186, 2004-06-17 12:12:26+02:00, matthias.andree@gmx.de
  vita: 3 new addresses.

ChangeSet@1.185, 2004-06-16 11:29:13+02:00, matthias.andree@gmx.de
  Change --mode=fixup so it also works without trailing colon.

ChangeSet@1.183, 2004-06-13 21:20:52+02:00, matthias.andree@gmx.de
  Update

ChangeSet@1.182, 2004-06-09 19:02:41+02:00, matthias.andree@gmx.de
  vita: 5 new addresses

ChangeSet@1.181, 2004-06-08 21:44:37+02:00, matthias.andree@gmx.de
  vita: Two new addresses.


Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |    7 ++++++-
# 1 files changed, 6 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/07/02 12:36:36+02:00 matthias.andree@gmx.de 
#   vita: five new addresses
# 
# shortlog
#   2004/07/02 12:36:36+02:00 matthias.andree@gmx.de +6 -1
#   vita: five new addresses
# 
diff -Nru a/shortlog b/shortlog
--- a/shortlog	2004-07-02 12:40:16 +02:00
+++ b/shortlog	2004-07-02 12:40:16 +02:00
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.306 2004/06/30 07:59:54 vita Exp $
+# $Id: lk-changelog.pl,v 0.307 2004/07/02 08:59:44 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -173,6 +173,7 @@
 'adobriyan:mail.ru' => 'Alexey Dobriyan',
 'adrian:humboldt.co.uk' => 'Adrian Cox',
 'adsharma:unix-os.sc.intel.com' => 'Arun Sharma',
+'adwol:polsl.gliwice.pl' => 'Adam Osuchowski',
 'aeb:cwi.nl' => 'Andries E. Brouwer',
 'aebr:win.tue.nl' => 'Andries E. Brouwer',
 'agk:redhat.com' => 'Alasdair G. Kergon',
@@ -195,6 +196,7 @@
 'airlied:pdx.freedesktop.org' => 'Dave Airlie',
 'airlied:starflyer.(none)' => 'Dave Airlie',
 'aj:andaco.de' => 'Andreas Jochens',
+'ajgrothe:yahoo.com' => 'Aaron Grothe',
 'ajm:sgi.com' => 'Alan Mayer',
 'ajoshi:kernel.crashing.org' => 'Ani Joshi',
 'ajoshi:shell.unixbox.com' => 'Ani Joshi',
@@ -296,6 +298,7 @@
 'async:cc.gatech.edu' => 'Rob Melby',
 'atul.mukker:lsil.com' => 'Atul Mukker',
 'atulm:lsil.com' => 'Atul Mukker',
+'augustus:linuxhardware.org' => 'Kris Kersey',
 'aurelien:aurel32.net' => 'Aurelien Jarno', # lbdb
 'aviro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
 'awagger:web.de' => 'Axel Waggershauser',
@@ -1438,6 +1441,7 @@
 'pablo:menichini.com.ar' => 'Pablo Menichini',
 'pam.delaney:lsil.com' => 'Pamela Delaney',
 'panagiotis.issaris:mech.kuleuven.ac.be' => 'Panagiotis Issaris',
+'panto:intracom.gr' => 'Pantelis Antoniou',
 'paschal:rcsis.com' => 'David Paschal',
 'pasky:ucw.cz' => 'Petr Baudis',
 'pat:computer-refuge.org' => 'Patrick Finnegan',
@@ -1544,6 +1548,7 @@
 'proski:gnu.org' => 'Pavel Roskin',
 'proski:org.rmk' => 'Pavel Roskin',
 'proski:org.rmk.(none)' => 'Pavel Roskin',
+'psimmons:flash.net' => 'Patrick Simmons',
 'purna:jcom.home.ne.jp' => 'Yusuf Wilajati Purna',
 'pwaechtler:mac.com' => 'Peter Wächtler',
 'q:kampsax.dtu.dk' => 'Dennis Jørgensen',

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.196
## Wrapped with gzip_uu ##


M'XL( ) [Y4   [U4VVKC,!!]CKYBH(4\;.U(OD:"E%[IEBRTM/0#5%NQO;&E
M(,E)"O[X5>RF)67[T-UE[<$PTIRC,^.#CN#)",U&#;>VK+CQN<RU$.@(OBMC
MV:AHMGZ^2Q^4<NG$M$9,ED)+44\NYBZ\(?&L4K5!KO">VZR$M="&C8@?OJW8
MEY5@HX?KFZ<?YP\(S69P67)9B$=A839#5NDUKW-SMA*R:"OI6\VE:83E?J::
M[JVV"S .W$N"$"<Q[0*:Q'$G A''643X<SI-11:@#_V<#7T<TD0X"3&>DBA*
M.L='*+H"XA.: (XF.)W@ $C PL3%-QPPC.'WK/"-@(?1!?SC'BY1!NO*<@:+
M:BU B@WPW)UKC#!H[K1ABN[?IXB\+SX(88[1Z;OL4C7B@V93*FUK50R28S+%
M:922:1>2E,;=0E"^R%),.18Y?\X_&= !2X13'! <)F'2!3&A8>^%?<6!%?Y:
MSV<V.-2S=T'<X9C2:'!!0K_L@@0\\M]=,(SP#CR]V>["VSI/[/O[ TM<$0($
MW?;?(SB^S1G42R_K13M&?U6?K '[(4YA-[S7">$IBRF+HEXI7&]7<.PXTMB1
MC'F^435;N>NA]HNZVE29<"QCF)W"^#SG#=R9-BO5QBRK\8E#T;1'_2RTLJ5@
M+[Q4:C>Y5P372L)-O[<K#^BT+V^+UMC6L+J2[;;D.M]P+7REBP$VUY6!N;N4
MQ$M_2!3A'6S%I56LDNX7N1/\0@_5]VY9U YQ[K9EI=H>$T=)CS%5TRAIV*+F
GIO2EL'N0U56VA,=AVT'>[KZL%-G2M,TLGSJ]A,?H%SM'YPEX!0  
 

