Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262853AbTEME2G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 00:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262863AbTEME2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 00:28:05 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:15488 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S262853AbTEME2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 00:28:05 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16064.30560.333090.924642@wombat.chubb.wattle.id.au>
Date: Tue, 13 May 2003 14:41:04 +1000
To: linux-kernel@vger.kernel.org
Subject: Adaptec 29160 works for me with old driver in 2.5.69
X-Mailer: VM 7.07 under 21.4 (patch 12) "Portable Code" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So...
	The `old' adaptec driver works in my (SMP) box; the `new' one
doesn't.

During boot the `new' driver gives Data overrun errors (see previous
email for details); the old driver just works.

Peter C
