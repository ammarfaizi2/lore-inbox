Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290206AbSAORlH>; Tue, 15 Jan 2002 12:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290205AbSAORks>; Tue, 15 Jan 2002 12:40:48 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4525 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S290119AbSAORkq>;
	Tue, 15 Jan 2002 12:40:46 -0500
Date: Tue, 15 Jan 2002 09:22:39 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ACB-IO for 2.5.1 (Re: Linux-2.5.2) (fwd)
Message-ID: <Pine.LNX.4.10.10201150921350.24031-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since this was eaten by VGER again :-((

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

---------- Forwarded message ----------
Date: Tue, 15 Jan 2002 00:36:23 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ACB-IO for 2.5.1 (Re: Linux-2.5.2)



http://www.linxudiskcert.org/

Please note that not every patch submitted and is added to this patch.
However all of them are in queue.

If you have submitted any patches in the past 2 months please resend.

I do expect some breakage in various archs; however, this change is to
allow them to have a native MMIO migration path.  Additionally a second
data-phase transport layer will be developed for SerialATA and all future
MMIO native Host-Controllers.  Please be away Ultra133 in the future will
require MMIO transport or Virtual DMA accross the PCI-DMA bus to the next
generation of ATA-Bridges.

Respectfully,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development


