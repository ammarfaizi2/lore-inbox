Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267575AbSLMBSI>; Thu, 12 Dec 2002 20:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267577AbSLMBSI>; Thu, 12 Dec 2002 20:18:08 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:4085 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S267575AbSLMBSI>; Thu, 12 Dec 2002 20:18:08 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15865.14115.470727.50756@wombat.chubb.wattle.id.au>
Date: Fri, 13 Dec 2002 12:25:55 +1100
To: linux-kernel@vger.kernel.org
Subject: New large block device patch available (against 2.4.21-pre1)
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've updated the large block device patch to fix the incorrect size
reporting for large SCSI discs, and to match 2.4.21-pre1.

This patch is almost completely untested --- I no longer have access
to any large disc machines --- please let me know how you get on with it.

Patch at:
      http://www.gelato.unsw.edu.au/patches/2.4.21-pre1-lbd.patch

--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
