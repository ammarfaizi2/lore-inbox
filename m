Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264780AbTFQOsO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 10:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264784AbTFQOqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 10:46:03 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:53002 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264780AbTFQOn1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 10:43:27 -0400
MIME-Version: 1.0
To: torvalds@transmeta.com
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue_Jun_17_14_57_19_UTC_2003_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20030617145719.B5FAB8ADF0@merlin.emma.line.org>
Date: Tue, 17 Jun 2003 16:57:19 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use bk receive to patch this mail, you can pull from
bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no trailing slash)
or you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
Second step of BK <-> CVS resynchronization.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |    5 ++++-
# 1 files changed, 4 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.59    -> 1.60   
#	            shortlog	1.33    -> 1.34   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/17	matthias.andree@gmx.de	1.60
# Synchronize Matthias' CVS and Linus' BK trees.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Tue Jun 17 16:57:19 2003
+++ b/shortlog	Tue Jun 17 16:57:19 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.131 2003/06/16 10:49:57 vita Exp $
+# $Id: lk-changelog.pl,v 0.132 2003/06/17 14:53:29 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -1733,6 +1733,9 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.132  2003/06/17 14:53:29  emma
+# Rearrange Peter Milne's addresses.
+#
 # Revision 0.131  2003/06/16 10:49:57  vita
 # add 5 names for new addresses
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.60
## Wrapped with gzip_uu ##


begin 600 bkpatch11693
M'XL(`$\L[SX``\U4T6K;,!1]CK[B0@I]Z.Q(LF7'AHPN:=E*6A82NG?5OHU-
M;"M(2I8.?_QLIVE)21^Z[6&2$%QQ[]$]1P?UX=Z@CGNEM#;+I7%EE6I$TH=O
MRMBXMRQW;MJ&<Z6:<&`V!@<KU!46@_&T6<X^<*Q2A2%-XDS:)(,M:A/WF.N]
MG-BG-<:]^?77^]LO<T)&(YADLEKB`BV,1L0JO95%:B[76"TW>>5:+2M3HI5N
MHLKZ);?FE/)F,N[10$0UCP(A:N0H1.(S^1`.0TPX></G<L_C&*8!8"'S!1>L
MIBSD$;D"Y@84J#>@P8"%P()8!#$/+BB/*873H'#!P*%D#/^8PH0DL'BJDDRK
M*O^%</=\^SE,?BR@:0%N\VK3A.,IV*8=XY(IL-!C9/8J+7$^.`BADI+/KV0R
M5>(;)B93VA9JN2<BV)"&?LB&M<?"2-2/&,G')*21I)C*A_0=V8Y0#D\1\*#V
M?,J\SB"'C"-__'4_[WGC5#]<T)H/*?<[:WC^AZWA@\/^$VOL=?T.COZY:Y>S
M:XQR(/T'/KEB#!BYZ?8^G-VD,10K)^FH-(CNNOBT!>HRCT.KZ$$W/Q9>S"/`
MLI1PO5O#68,1>@+:KV*.V]SDJGJN.UG857:Y4NOV,IBA10UW>5'AN0&9-B]@
=3$NZ__HA)1DF*[,I1SY&3`2>(+\!=FW?"_L$````
`
end

