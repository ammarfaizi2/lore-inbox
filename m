Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbUAPOls (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 09:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264981AbUAPOlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 09:41:47 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:33694 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264446AbUAPOlo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 09:41:44 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Fri_Jan_16_14_41_39_UTC_2004_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20040116144140.60B9597BA9@merlin.emma.line.org>
Date: Fri, 16 Jan 2004 15:41:40 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.114, 2004-01-16 15:39:29+01:00, matthias.andree@gmx.de
  Add Richard Procter's address.

Previous patches, not included in this mail:
ChangeSet@1.113, 2004-01-13 01:54:41+01:00, matthias.andree@gmx.de
  Three new addresses.

ChangeSet@1.112, 2004-01-07 12:40:31+01:00, matthias.andree@gmx.de
  Drop $History$ section.

ChangeSet@1.111, 2004-01-07 12:28:55+01:00, matthias.andree@gmx.de
  vita: 34 new addresses
  vita: re-sorted with LC_COLLATE=POSIX

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |    3 ++-
# 1 files changed, 2 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/01/16 15:39:29+01:00 matthias.andree@gmx.de 
#   Add Richard Procter's address.
# 
# shortlog
#   2004/01/16 15:39:28+01:00 matthias.andree@gmx.de +2 -1
#   Add Richard Procter's address.
# 
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Fri Jan 16 15:41:38 2004
+++ b/shortlog	Fri Jan 16 15:41:38 2004
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.215 2004/01/12 12:24:48 vita Exp $
+# $Id: lk-changelog.pl,v 0.216 2004/01/16 14:37:56 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -1209,6 +1209,7 @@
 'rmk:arm.linux.org.uk' => 'Russell King',
 'rmk:flint.arm.linux.org.uk' => 'Russell King',
 'rml:tech9.net' => 'Robert Love',
+'rnp:paradise.net.nz' => 'Richard Procter',
 'rob:landley.net' => 'Rob Landley',
 'rob:osinvestor.com' => 'Rob Radez',
 'robert.olsson:data.slu.se' => 'Robert Olsson',

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.114
## Wrapped with gzip_uu ##


M'XL( "+X!T   \64:VO;,!2&/T>_XD *^=#:D>2[P:57MM+!0D9_@"J=Q"&^
M(2E=5OSCIR2D(=G*V 5F">%C#J_?\_*@(3P9U/F@%M:6"V%\T2B-2(;PL34V
M'\SKM:\VY;1M73DV*X/C)>H&J_'-H]O>KO!LVU:&N,:)L+*$%]0F'S _>/MB
MOW68#Z;W'YX^74\)*0JX+44SQR]HH2B(;?6+J)2YZK"9KQ:-;[5H3(U6^+*M
M^[?>GE/*W6(\H'&4]3R+HZA'CE$D0R:>DS1!R<G)/%>[.8YE0LI80&D4AJQW
MKUE&[H#YC(5 PS%E8Q8#B_(@RWEV3EE.*?Q<%<X9>)3<P#^>X99(N%8*I@M9
M"JU@HEMI48\,".5^;XQ/'H%Q&I/)(4OB_>9#"!647![,EVV-)\Y-V6I;M?.=
M\8BE- D3EO8!2[*HGV$F9C*AF:"HQ+-Z)Z8CE4WV,0N#C*<N^XCS+1'[CB,@
M_MK/>S"<^MFQ0/LX<#I;%M+D!Q327Z# P6/_"X5-C)_!TU_7F^VM'1?[&?\ 
MBSO&@)&'[3F$LP>50[7TY-:Y4_2[ZN(%J,]=-IL ]S&%>9#D40Q8UP+NUQV<
M.0V^51GIILL[H85:&/0;M'[S.H+B$D:G<UT<;A)9HER:55TH-5,AEPGY#L1 
&R4ZT!   
 

