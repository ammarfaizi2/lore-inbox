Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUDTLOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUDTLOS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 07:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbUDTLOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 07:14:18 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:49076 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262574AbUDTLON convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 07:14:13 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue_Apr_20_11_14_02_UTC_2004_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20040420111402.EAB442C2B@merlin.emma.line.org>
Date: Tue, 20 Apr 2004 13:14:02 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.154, 2004-04-20 13:13:22+02:00, matthias.andree@gmx.de
  Five new address mappings.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |    7 ++++++-
# 1 files changed, 6 insertions(+), 1 deletion(-)

##### GNUPATCH #####
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/04/20 13:13:22+02:00 matthias.andree@gmx.de 
#   Five new address mappings.
# 
# shortlog
#   2004/04/20 13:13:22+02:00 matthias.andree@gmx.de +6 -1
#   Five new address mappings.
# 
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Tue Apr 20 13:14:02 2004
+++ b/shortlog	Tue Apr 20 13:14:02 2004
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.263 2004/04/15 08:37:42 vita Exp $
+# $Id: lk-changelog.pl,v 0.265 2004/04/20 11:13:21 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -287,6 +287,7 @@
 'bart.de.schuymer:pandora.be' => 'Bart De Schuymer',
 'bart:samwel.tk' => 'Bart Samwel',
 'bbosch:iphase.com' => 'Bradley A. Bosch',
+'bbuesker:qualcomm.com' => 'Brian Buesker',
 'bcollins:debian.org' => 'Ben Collins',
 'bcrl:bob.home.kvack.org' => 'Benjamin LaHaise',
 'bcrl:redhat.com' => 'Benjamin LaHaise',
@@ -815,6 +816,7 @@
 'jholmes:psu.edu' => 'Jason Holmes',
 'jiho:c-zone.net' => 'Jim Howard',
 'jim.houston:attbi.com' => 'Jim Houston',
+'jim.houston:comcast.net' => 'Jim Houston',
 'jkenisto:us.ibm.com' => 'James Keniston',
 'jkt:helius.com' => 'Jack Thomasson',
 'jlcooke:certainkey.com' => 'Jean-Luc Cooke',
@@ -1178,14 +1180,17 @@
 'mzyngier:freesurf.fr' => 'Marc Zyngier',
 'n0ano:n0ano.com' => 'Don Dugger',
 'nahshon:actcom.co.il' => 'Itai Nahshon',
+'nathanl:austin.ibm.com' => 'Nathan Lynch',
 'nathans:bruce.melbourne.sgi.com' => 'Nathan Scott',
 'nathans:sgi.com' => 'Nathan Scott',
 'naveenb:cisco.com' => 'Naveen Burmi', # lbdb
+'ncunningham:users.sourceforge.net' => 'Nigel Cunningham',
 'neilb:cse.unsw.edu.au' => 'Neil Brown',
 'neilt:slimy.greenend.org.uk' => 'Neil Turton',
 'nemosoft:smcc.demon.nl' => 'Nemosoft Unv.',
 'netfilter:interlinx.bc.ca' => 'Brian J. Murrell',
 'nick.holloway:pyrites.org.uk' => 'Nick Holloway',
+'nickpiggin:yahoo.com.au' => 'Nick Piggin',
 'nico:cam.org' => 'Nicolas Pitre',
 'nico:org.rmk' => 'Nicolas Pitre',
 'nico:org.rmk.(none)' => 'Nicolas Pitre',

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.154
## Wrapped with gzip_uu ##


M'XL( /H%A4   \54VT[<,!!]7G_%2"#M R1K._=(B^@";;<@BJCX *]CDG03
M.XV399'R\742=KE(/-!6:F)%<F;.S)FCHSF .RWJ>%*RILERIFTFDUH(= !?
ME6[B25IN[:2_WBIEKC/=:C%;BUJ*8K:X-,<:+U:C5*&12;QA#<]@(VH=3XCM
M[/\TCY6()[<77^ZN/MTB-)_#6<9D*GZ(!N9SU*AZPXI$GU9"IFTN[:9F4I>B
M83979;?/[2C&U+R$.MCWHHY&ON=U@@K/XRYAJR ,!*<ORE4\"K"M=%+8JDY?
M%W*Q2SSB$]\-.TP<ZJ-S(#;Q7,#NS!R*@3BQ.90>81IC#&]T.AWU@2,"%D8+
M^,=3G"$.G_.- "D>@"6FH]:&0E7E,M4VN@1"L8MNGI5$U@<?A###Z.29>*9*
M\8:USE3=%"H=27LDQ($;D+!S2!!YW;V(V#T/<,2P2-@J>4>B5U6,[F9V8A2G
MG>=$3C#X89?QR@Y_S>=]*[QAM'>"X_@X')U @P\[P0>+_ <GC#)^!ZM^V/;'
MVAI?[";\ UN<$P($+8?O 1PNDQB*M<4'VJ:B717'&\ V]3WHY=MI1 :-"(BR
M9'"QK> 0+6D8F2+3U:H5VFR+^%?+"J-!V0LQA?D)3!=USB0LQOCT&"U#$O20
MGWEI9ZK5C9*Q2>9,-[84S0CZEI=F20W!'D*,#WJ,9(TA6<3,1(SL^>I%G^LA
M!E>/DF=/&&? \%9*HV3&RM@LN%K;6K4U%_?&)N*YXW5N9H>S?>Y3B7 HD?-U
ME:=I+N-'EBG5-[59NP/R-=P,48/9KT2>";[6;3GW"5Z%H8O1;_&01AR/!0  
 

