Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbTJ0MJN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 07:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTJ0MJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 07:09:12 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:29132 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261585AbTJ0MJG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 07:09:06 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon_Oct_27_12_09_03_UTC_2003_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20031027120903.9725A97EAE@merlin.emma.line.org>
Date: Mon, 27 Oct 2003 13:09:03 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
ChangeSet@1.95, 2003-10-27 13:05:53+01:00, matthias.andree@gmx.de
  Resynch CVS and BK trees, adding two addresses.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   13 ++++++++++++-
# 1 files changed, 12 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.94    -> 1.95   
#	            shortlog	1.67    -> 1.68   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/10/27	matthias.andree@gmx.de	1.95
# Resynch CVS and BK trees, adding two addresses.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Mon Oct 27 13:09:03 2003
+++ b/shortlog	Mon Oct 27 13:09:03 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.190 2003/10/16 12:33:28 vita Exp $
+# $Id: lk-changelog.pl,v 0.193 2003/10/27 12:04:27 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -408,6 +408,7 @@
 'davidm:wailua.hpl.hp.com' => 'David Mosberger',
 'davids:youknow.youwant.to' => 'David Schwartz', # google
 'davidvh:cox.net' => 'David van Hoose',
+'davis_g:com.rmk.(none)' => 'George G. Davis',
 'dax:gurulabs.com' => 'Dax Kelson',
 'dbrownell:users.sourceforge.net' => 'David Brownell',
 'ddstreet:ieee.org' => 'Dan Streetman',
@@ -1224,6 +1225,7 @@
 'shaggy:shaggy.austin.ibm.com' => 'Dave Kleikamp', # lbdb
 'sheilds:msrl.com' => 'Michael Shields', # typo
 'shemminger:osdl.org' => 'Stephen Hemminger',
+'shep:alum.mit.edu' => 'Tim Shepard',
 'shields:msrl.com' => 'Michael Shields',
 'shingchuang:via.com.tw' => 'Shing Chuang',
 'shmulik.hen:intel.com' => 'Shmulik Hen',
@@ -2115,6 +2117,15 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.193  2003/10/27 12:04:27  emma
+# Merge upstream changes.
+#
+# Revision 0.192  2003/10/24 08:13:10  vita
+# 5 new addresses
+#
+# Revision 0.191  2003/10/21 12:20:32  vita
+# 2 new addresses
+#
 # Revision 0.190  2003/10/16 12:33:28  vita
 # 3 new addresses
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.95
## Wrapped with gzip_uu ##


M'XL( -\*G3\  \U474_;,!1]KG_%E8K431#7=N*FB53$^! @-@V5L=?)))<T
M:A)7L5N*E!\_IUT+A?' MH<E5F3']YY[S_&1NW!KL(X[I;)VDBM#5976B*0+
M%]K8N).52YJVR['6;MDW<X/]*=85%OWC*S>\]<*S6A>&N,!K99,)++ V<8=3
M?_O'/LXP[HS/SF\_?QH3,AK!R415&=Z@A=&(6%TO5)&:HQE6V3ROJ*U594JT
MBB:Z;+:QC6!,N)<+GPUDU(AH(&6# J5, J[NPF&(B7B"F^@2J39I076=[<+X
MG G)N(QDV#B\,""GP&DD@?E]SOHB!.['3,;2WV<\9@Q>B'2T%@?V.7B,',,_
MIG!"$ABC>:R<>"??;\ 5A>,KL*ZR.0"5IGF5@7W0[;1&8]!0<@5<L)!</VE+
MO'<^A##%R"'L*KA+Q4QT;0N=K9E(/F1A$/)AX_,PDLT]1NH^"5FD&*;J+GU#
MMQV4]BQ"U[N4?L-EZ,N50S81.P;YZW[>,L?+?C;>&+!H$*Z\,1B^WQL"//[?
MF&.E[%?PZH=E.[REL\J&]A\XY91SX.1R]>W"WF4:0S'UDA47ATAGQ<$"&.61
M#ZVF&^5$S(+83; L%9PM9[!'+@/.'$@O58O<_,ABIPFMRRG]4.D*/_9@= B]
M<W2GA'!.X;2-ZAVXRD(,VC0SP5FLBGE)R]Q23.?KC&]Y"3=N2]5I&RTX#R%J
M+S-T^;FN?O7VV^96W;G8+]@6G<^,TU:5L";GU.R^Q!'/< )@P]@YQ)&"16Y;
M' D5/CP=Q^M\_BR?MWT(%OMBFR]>Y6^OUF2"R=3,RY%24D0B2,A/@K5E@=<%
"    
 

