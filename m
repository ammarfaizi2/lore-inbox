Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbVL2NET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVL2NET (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 08:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbVL2NET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 08:04:19 -0500
Received: from jubileegroup.co.uk ([217.147.177.250]:59067 "EHLO
	mail3.jubileegroup.co.uk") by vger.kernel.org with ESMTP
	id S1750712AbVL2NES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 08:04:18 -0500
Date: Thu, 29 Dec 2005 13:04:01 +0000 (GMT)
From: "G.W. Haywood" <ged@jubileegroup.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Documentation patch.
Message-ID: <Pine.LNX.4.58.0512291301420.2118@mail3.jubileegroup.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (mail3.jubileegroup.co.uk [0.0.0.0]); Thu, 29 Dec 2005 13:04:01 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This had me grepping the docs for a minute or two...

73,
Ged.
============================================================================

~/src/linux/Documentation$ > diff -C3 Configure.help Configure.help.original
*** Configure.help      Thu Dec 29 12:55:30 2005
--- Configure.help.original     Wed Dec 28 14:11:26 2005
***************
*** 12827,12834 ****
    without a specific driver are compatible with NE2000.

    If you have a PCI NE2000 card however, say N here and Y to "PCI
!   NE2000 and clones support" under "EISA, VLB, PCI and on board
!   controllers" below. If you have a NE2000 card and are running on
    an MCA system (a bus system used on some IBM PS/2 computers and
    laptops), say N here and Y to "NE/2 (ne2000 MCA version) support",
    below.
--- 12827,12833 ----
    without a specific driver are compatible with NE2000.

    If you have a PCI NE2000 card however, say N here and Y to "PCI
!   NE2000 support", above. If you have a NE2000 card and are running on
    an MCA system (a bus system used on some IBM PS/2 computers and
    laptops), say N here and Y to "NE/2 (ne2000 MCA version) support",
    below.


