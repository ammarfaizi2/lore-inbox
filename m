Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbUCWLwC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 06:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbUCWLwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 06:52:02 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:47805 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262521AbUCWLvx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 06:51:53 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue_Mar_23_11_51_49_UTC_2004_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040323115149.585BAA7784@merlin.emma.line.org>
Date: Tue, 23 Mar 2004 12:51:49 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
(only mentioning the most recent commit, use bk changes -Rm to find
 previous commits)
ChangeSet@1.142, 2004-03-23 12:51:20+01:00, matthias.andree@gmx.de
  Vita has added five new addresses.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |    7 ++++++-
# 1 files changed, 6 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/03/23 12:51:20+01:00 matthias.andree@gmx.de 
#   Vita has added five new addresses.
# 
# shortlog
#   2004/03/23 12:51:20+01:00 matthias.andree@gmx.de +6 -1
#   Vita has added five new addresses.
# 
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Tue Mar 23 12:51:49 2004
+++ b/shortlog	Tue Mar 23 12:51:49 2004
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.251 2004/03/22 11:14:06 emma Exp $
+# $Id: lk-changelog.pl,v 0.252 2004/03/23 09:55:23 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -418,6 +418,7 @@
 'damien.morange:hp.com' => 'Damien Morange',
 'dan.zink:hp.com' => 'Dan Zink',
 'dan:debian.org' => 'Daniel Jacobowitz',
+'dan:geefour.netx4.com' => 'Dan Malek',
 'dan:reactivated.net' => 'Daniel Drake',
 'dana.lacoste:peregrine.com' => 'Dana Lacoste',
 'danc:mvista.com' => 'Dan Cox', # some CREDITS patch found by google
@@ -669,6 +670,7 @@
 'helgaas:hp.com' => 'Bjorn Helgaas', # guessed
 'henk:god.dyndns.org' => 'Henk Vergonet',
 'henning:meier-geinitz.de' => 'Henning Meier-Geinitz',
+'henning:wh9.tu-dresden.de' => 'Henning Schild',
 'henrique2.gobbi:cyclades.com' => 'Henrique Gobbi',
 'henrique:cyclades.com' => 'Henrique Gobbi',
 'herbert:13thfloor.at' => 'Herbert Pötzl', # lbdb
@@ -1103,6 +1105,7 @@
 'mlindner:syskonnect.de' => 'Mirko Lindner',
 'mlocke:mvista.com' => 'Montavista Software, Inc.',
 'mlord:pobox.com' => 'Mark Lord',
+'mlotek:foobar.pl' => 'Michal Mlotek',
 'mludvig:suse.cz' => 'Michal Ludvig',
 'mmagallo:debian.org' => 'Marcelo E. Magallon',
 'mmcclell:bigfoot.com' => 'Mark McClelland',
@@ -1164,6 +1167,7 @@
 'noah:caltech.edu' => 'Noah J. Misch',
 'nobita:t-online.de' => 'Andreas Busch',
 'normalperson:yhbt.net' => 'Eric Wong',
+'not:just.any.name' => 'John Fremlin',
 'nstraz:sgi.com' => 'Nathan Straz',
 'ntfs:flatcap.org' => 'Richard Russon', # lbdb
 'nuno:itsari.org' => 'Nuno Monteiro',
@@ -1384,6 +1388,7 @@
 'samel:mail.cz' => 'Vitezslav Samel',
 'samuel.thibault:ens-lyon.fr' => 'Samuel Thibault',
 'samuel.thibault:fnac.net' => 'Samuel Thibault', # lbdb
+'samuel:ibrium.se' => 'Samuel Rydh',
 'sandeen:sgi.com' => 'Eric Sandeen',
 'santiago:newphoenix.net' => 'Santiago A. Nullo', # sent by self
 'santil:us.ibm.com' => 'Santiago Leon',

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.142
## Wrapped with gzip_uu ##


M'XL( -4D8$   \5476^;,!1]CG_%E5HI#RW$-A@2I%1=/[9F7;4J5??NP$U@
M ;O")DTE?OQ,Z(=:K0_=)@TLQ+6/#^<>CKP'MP;K9%!):_-"&E^JK$8D>W"A
MC4T&JVKK9UTYU]J5(],8'*VQ5EB.3B[=\/K"LUJ7ACC@M;1I#ANL33)@?O \
M8Q_N,!G,S[_<?OLT)V0ZA=-<JA7>H(7IE%A=;V29F>,[5*NF4+ZMI3(56NFG
MNFJ?L2VGE+N;\8!&8M+R221$BQR%2$,F%_$XQI23-_T<]WV\I@EIP#EC+*1Q
MZ_@H(V? ?!9RH.&(!B,> ..)8 FG!Y0EE,+O6>& @4?)"?SC'DY)"C\**R&7
M!F2680;+8H.@\+XK:S0&C4\NG4H:D>L7/XGWP8L0*BDY>FD@UQ6^46]R7=M2
MKWKQ@HUI',9LW 8LGHAVB1.Y3&,ZD10SN<C>L>H52^=_P)AP\ML@%/%XEXHG
MQ*M0_+6>]P+Q5L]3'E@<"=KG@8D/YR$"C_W'//1F?@>OOM]VP]NZ=#QU^@?A
M.&,,&)GMGGNP/\L2*-=>NI/O&/V[\G #U.>"0V?CHU=TD@B1N)=-I_E\>P?[
M9!9RZDB&F53)"G&IF]I7:+=A9\@0ID<P/),*KF2)Z^$AF45Q]\UACDH5:I7<
MYQ/?-E[7:H;*6=UON>B7X2;-BS+K]C%&1;>Q*K7%=;+4>B%KI[/'7Q5.>PE7
MN\4>'D4=7+DS[F=CK/N?#[Z2U2/_5YTK^%QC519J!P_&.[B158-E4BSJHJE\
D\XB^V<W"_"'+'?CY_$MS3->FJ:9INHQB7(;D%[682DQ\!0  
 

