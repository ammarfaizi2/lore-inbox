Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264478AbTK0LDT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 06:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbTK0LDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 06:03:19 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:64721 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264478AbTK0LDJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 06:03:09 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Thu_Nov_27_11_03_06_UTC_2003_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20031127110306.860C69869A@merlin.emma.line.org>
Date: Thu, 27 Nov 2003 12:03:06 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.102, 2003-11-27 12:02:45+01:00, matthias.andree@gmx.de
  three new addresses (by vita)

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |    8 +++++++-
# 1 files changed, 7 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.101   -> 1.102  
#	            shortlog	1.74    -> 1.75   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/11/27	matthias.andree@gmx.de	1.102
# three new addresses (by vita)
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Thu Nov 27 12:03:06 2003
+++ b/shortlog	Thu Nov 27 12:03:06 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.200 2003/11/25 10:45:02 emma Exp $
+# $Id: lk-changelog.pl,v 0.201 2003/11/27 10:59:51 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -845,6 +845,7 @@
 'linux:thorsten-knabe.de' => 'Thorsten Knabe',
 'lionel.bouton:inet6.fr' => 'Lionel Bouton',
 'lists:mdiehl.de' => 'Martin Diehl',
+'livio:ime.usp.br' => 'Livio Baldini Soares',
 'liyang:nerv.cx' => 'Liyang Hu',
 'lkml001:vrfy.org' => 'Kay Sievers',
 'lkml:mathfillsmewithgreatjoy.com' => 'Michael Plump',
@@ -865,6 +866,7 @@
 'luc.vanoostenryck:easynet.be' => 'Luc Van Oostenryck', # lbdb
 'lucasvr:terra.com.br' => 'Lucas Correia Villa Real', # google
 'lunz:falooley.org' => 'Jason Lunz',
+'lxiep:us.ibm.com' => 'Linda Xie',
 'm.c.p:wolk-project.de' => 'Marc-Christian Petersen',
 'm:mbsks.franken.de' => 'Matthias Bruestle',
 'maalanen:ra.abo.fi' => 'Marcus Alanen',
@@ -1008,6 +1010,7 @@
 'nicolas.mailhot:laposte.net' => 'Nicolas Mailhot',
 'nicolas:dupeux.net' => 'Nicolas Dupeux',
 'nikai:nikai.net' => 'Nicolas Kaiser',
+'nikkne:hotpop.com' => 'Nikola Knezevic',
 'niv:us.ibm.com' => 'Nivedita Singhvi',
 'nivedita:w-nivedita.beaverton.ibm.com' => 'Nivedita Singhvi',
 'nkbj:image.dk' => 'Niels Kristian Bech Jensen',
@@ -2137,6 +2140,9 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.201  2003/11/27 10:59:51  vita
+# 3 new addresses (1 new and 2 old from `bk changes` since 2.5.0)
+#
 # Revision 0.200  2003/11/25 10:45:02  emma
 # Merge Linus' additions.
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.102
## Wrapped with gzip_uu ##


M'XL( .K9Q3\  \54:VO;,!3]'/V*"REDI;4CR:_8D-+U05=:MI)2V,?*MA(+
MVY*QG#0=_O&3G:6A6<O8 V8;@Z[/O3KG^* A/&A>1X.2-4TFF+:93&O.T1 ^
M*=U$@T6YMM-N.5/*+,=ZJ?DXY[7DQ?CLQCS69F$U2A4:&> =:Y(,5KS6T8#8
MSDNE>:YX-)A=7CW<?IPA-)W"><;D@M_S!J93U*AZQ8I4GU9<+I9"VDW-I"YY
MP^Q$E>T+MJ484W,3ZF#?"UL:^I[7<LH]+W$)BX-)P!.*]O2<;G2\'N,00CV"
M71^[K9F' W0!Q":8 G;&A(QI (1&F$:N=X1)A#&\/16."%@8G<$_UG".$F@R
MLP](_@0L-5MJS35\B)]A)1IVB&X,04S0W<Y*9/WFA1!F&)WLN&>JY'O$=:;J
MIE"+#6^/3'#@!F32.B0(O7;.0S9/ APRS%,6I^^X]&I*9WU C-6NVY* XDD?
MB"WB51[^FL][6=CGLXV"[[J^TT<A\'Y*@ON+) 1@D?^4A-[&+V#53^ONL=8F
M%UN-?Q"+"T* H.O^/82#ZS2"(K>2GKF9:%?%\0JP;;A#9^#6)AQY8>21GA9<
MKBLX0-<3UWQ HT*LA(J$^9U+7=EQ/8+I"8QNNRJ<&;>$%'"OF-$V.C9-_J9I
M+7@5+;4MXK+S;MLD4P9?!>^0!!/<0:7(<\FC3#65JG;8SR)7!8,;R;_QE4BZ
M#DJ<$+JC:68J6BCY0\B;2GHI!NOLFT\V!9D"!56D,*]5"8]Q#AN3]"-H(1,.
?U/9L?(B&N],QR7B2ZV4Y#6+J!W/JH>\)]\!8B 4     
 

