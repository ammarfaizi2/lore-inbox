Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUCIARC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 19:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbUCIAQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 19:16:54 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:7887 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261426AbUCIAQr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 19:16:47 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue_Mar__9_00_16_43_UTC_2004_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20040309001643.AA02BA0ABE@merlin.emma.line.org>
Date: Tue,  9 Mar 2004 01:16:43 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.132, 2004-03-09 01:16:27+01:00, matthias.andree@gmx.de
  vita: 3 new addresses; resort with "LC_ALL=POSIX sort -u"

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |    7 +++++--
# 1 files changed, 5 insertions(+), 2 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/03/09 01:16:27+01:00 matthias.andree@gmx.de 
#   vita: 3 new addresses; resort with "LC_ALL=POSIX sort -u"
# 
# shortlog
#   2004/03/09 01:16:27+01:00 matthias.andree@gmx.de +5 -2
#   vita: 3 new addresses; resort with "LC_ALL=POSIX sort -u"
# 
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Tue Mar  9 01:16:43 2004
+++ b/shortlog	Tue Mar  9 01:16:43 2004
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.241 2004/03/06 20:43:17 emma Exp $
+# $Id: lk-changelog.pl,v 0.242 2004/03/08 15:40:55 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -485,6 +485,7 @@
 'dmo:osdl.org' => 'Dave Olien',
 'doj:cubic.org' => 'Dirk Jagdmann',
 'dok:directfb.org' => 'Denis Oliver Kropp',
+'dolbeau:irisa.fr' => 'Romain Dolbeau',
 'domen:coderock.org' => 'Domen Puncer',
 'dougg:torque.net' => 'Douglas Gilbert',
 'drb:med.co.nz' => 'Ross Boswell',
@@ -669,6 +670,7 @@
 'hunold:convergence.de' => 'Michael Hunold',
 'hunold:linuxtv.org' => 'Michael Hunold',
 'hwahl:hwahl.de' => 'Hartmut Wahl',
+'i.palsenberg:jdirmedia.nl' => 'Igmar Palsenberg', # lbdb
 'ian.abbott:mev.co.uk' => 'Ian Abbott',
 'ianw:gelato.unsw.edu.au' => 'Ian Wienand', # lbdb
 'ica2_ts:csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
@@ -683,7 +685,6 @@
 'ionut:badula.org' => 'Ion Badulescu',
 'ionut:cs.columbia.edu' => 'Ion Badulescu',
 'ioshadij:hotmail.com' => 'Ishan O. Jayawardena',
-'i.palsenberg:jdirmedia.nl' => 'Igmar Palsenberg', # lbdb
 'irohlfs:irohlfs.de' => 'Ingo Rohlfs',
 'ishikawa:linux.or.jp' => 'Mutsumi Ishikawa',
 'ivangurdiev:linuxfreemail.com' => 'Ivan Gyurdiev',
@@ -721,6 +722,7 @@
 'jay.estabrook:hp.com' => 'Jay Estabrook',
 'jb:jblache.org' => 'Julien Blache',
 'jbarnes:sgi.com' => 'Jesse Barnes',
+'jbaron:redhat.com' => 'Jason Baron',
 'jbglaw:lug-owl.de' => 'Jan-Benedict Glaw',
 'jblack:linuxguru.net' => 'James Blackwell',
 'jbm:joshisanerd.com' => 'Josh Myer',
@@ -1072,6 +1074,7 @@
 'mlang:delysid.org' => 'Mario Lang', # google
 'mlindner:syskonnect.de' => 'Mirko Lindner',
 'mlocke:mvista.com' => 'Montavista Software, Inc.',
+'mlord:pobox.com' => 'Mark Lord',
 'mludvig:suse.cz' => 'Michal Ludvig',
 'mmagallo:debian.org' => 'Marcelo E. Magallon',
 'mmcclell:bigfoot.com' => 'Mark McClelland',

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.132
## Wrapped with gzip_uu ##


M'XL( .L,34   \U46V^;,!A]CG_%IZ92'EJ(;3"WB:J75%O63*U25=K;9, -
M-( CFUPF\>-G@M*JU?K0;0\#"[!]?#Z?PY&'\*"%B@85;YJ\X-KF=::$0$/X
M(G43#1;5SLZZ[EQ*TQWKM1;CI5"U*,>7-Z99?<=JI"PU,L [WJ0Y;(32T8#8
MSO-(\W,EHL'\^O/#[&*.4!S#5<[KA;@7#<0Q:J3:\#+3YRM1+]9%;3>*U[H2
M#;=36;7/V)9B3,U-J(,]%K8T]!AK!16,I2[AB1_X(J7HC9[S7L=K&A<;"HI=
MAP2MX2,.F@"QB4,!NV/LC'$(F$3$BZA_8CXPAM^SP@D!"Z-+^,<:KE *FZ+A
M$3A0BRWPS!356NA/8-Y2-; MFAR.9E<_+F:S^.[V?OH=]N/6^@C= #':T-V+
MS<CZX(40YAB=O>C*927>B-*Y*5C*1:^)D0#[KF\,=8@?LO91A/PQ]7'(L<AX
MDKWCX"N6[K>$&!./^BT-&,;[L!P0K[+RU_MY+R=O]W.("0FI[_4QP>S#,6%@
MT?\O)KW'MV"I[:YKULZ$YF# 'V1F0@@0--T_AW \S2(HEU:Z5V48[55YN@%L
M4Y="Y^[>P@ (BUP<,;:7 M>[%1RCJ1OXAF24R3(1?!T5JM#<?E0CB,]@-)<5
M+VJ8]).C4S3U_*[FJ+!7O-2B3H1:1$]9H2J1%=RNRW[==%%Q90ZE V1T"D,H
MDRQ!$R_PNJW[U.EXGA*N9!TID>6\Z7Y-O_XKU[*&RVZN*TI,P#IT54J512N9
ER-T+]AM72YB9"8-\/@G37*1+O:YB+TQ80#R&?@$$;3:7A@4     
 

