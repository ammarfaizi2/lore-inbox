Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbUFCIA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUFCIA0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 04:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUFCIA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 04:00:26 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:7351 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261712AbUFCIAX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 04:00:23 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Thu_Jun__3_08_00_19_UTC_2004_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20040603080019.6EE4ABB758@merlin.emma.line.org>
Date: Thu,  3 Jun 2004 10:00:19 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.175, 2004-06-03 09:59:17+02:00, matthias.andree@gmx.de
  Synch up both ways.

(BK and CVS went out of synch, with this patch, they're back in synch,
thanks to Vita.)

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |    4 ++--
# 1 files changed, 2 insertions(+), 2 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/03 09:59:17+02:00 matthias.andree@gmx.de 
#   Synch up both ways.
# 
# shortlog
#   2004/06/03 09:59:17+02:00 matthias.andree@gmx.de +2 -2
#   Synch up both ways.
# 
diff -Nru a/shortlog b/shortlog
--- a/shortlog	2004-06-03 10:00:19 +02:00
+++ b/shortlog	2004-06-03 10:00:19 +02:00
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.281 2004/05/14 20:07:18 emma Exp $
+# $Id: lk-changelog.pl,v 0.285 2004/06/03 07:54:02 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -879,7 +879,7 @@
 'jim.houston:comcast.net' => 'Jim Houston',
 'jk:ozlabs.org' => 'Jeremy Kerr',
 'jkenisto:us.ibm.com' => 'James Keniston',
-'jkluebs:com.rmk.(none)' => 'John K Luebs',
+'jkluebs:com.rmk.(none)' => 'John K. Luebs',
 'jkmaline:cc.hut.fi' => 'Jouni Malinen',
 'jkt:helius.com' => 'Jack Thomasson',
 'jlcooke:certainkey.com' => 'Jean-Luc Cooke',

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.175
## Wrapped with gzip_uu ##


M'XL( )/:OD   [V4X6K;,!2%?T=/<2&%;+16KF3+L@TI79NR=2FLI/0!%%N-
ML]A6L)0T 3_\G(0T2Z$_NHW)0N:*R^'<PX>Z\&1UG71*Y5P^4Y:J*JNU)EWX
M9JQ+.M-R3;-M.3:F+?MV:75_KNM*%_WK4;N]?>$Y8PI+VL8'Y=(<5KJV28=1
M__7&;18ZZ8QOOS[=?QD3,AC 3:ZJJ7[4#@8#XDR]4D5FKQ:ZFBYG%76UJFRI
MG:*I*9O7WH8C\O9CW,=0Q V/0R$:S;40:<#41$92I_PWN44:2Z3&9@4U]?14
M*$#A(X9!NQID/H_)$!AE4@ &?0S[Z /&B8@3)L^1)XCP)J>K?3YPSL!#<@W_
M>(H;DL+CIFK36RY@8EP.+VIC*1D!XUR0AV.$Q/O@(@05DLNCX]R4^HU=FYO:
M%6:Z=RM8A#*0+&I\)F/1/.M8/:<28X4Z4Y/LG6Q.5 (,T4<I8B8;P6(1[D X
M=)QP\-=^WF?@U-$1@58QDGL$@NC#"'#P^/]$8)_?#_#JE_5V>^L6B,-H?\##
MD#%@Y&YW=N'L+DN@F'OISF^K2!?%Q0J0\DC -K=#.#(108(<5C.GX':]@#,R
MC"*^E=K_>C_GQ5)/;-*.3^MR3C]5IM*?>S"XA-YWDU<PHG"_[>A='!^0--?I
4W"[+01A'@9^UM/\"L56%M*L$    
 

