Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135760AbRD2Mhn>; Sun, 29 Apr 2001 08:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135765AbRD2Mhe>; Sun, 29 Apr 2001 08:37:34 -0400
Received: from dire.bris.ac.uk ([137.222.10.60]:4856 "EHLO dire.bris.ac.uk")
	by vger.kernel.org with ESMTP id <S135760AbRD2MhX>;
	Sun, 29 Apr 2001 08:37:23 -0400
Date: Sun, 29 Apr 2001 13:32:37 +0100 (BST)
From: Matt <madmatt@bits.bris.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.x on sparc32
Message-ID: <Pine.LNX.4.21.0104291322550.11010-100000@bits.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone tell me the current status of 2.4.x on sparc(32) platforms?

I tried 2.4.2 previously which compiled fine, but would lock the machine
up loading the kernel after the SILO prompt, (before Tux appears, etc.).

I've tried 2.4.4 today, but that won't build as it appears this
architecture is missing the pte_alloc_one_fast() definitions and such,
(many warnings).

My box is an SS IPX (sun4c), PROM 2.9 & currently running 2.2.18 +RAID,
which I've been told has been a meddlesome platform in the past.

Thanks

Matt

