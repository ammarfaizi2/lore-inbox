Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129598AbQKSWWN>; Sun, 19 Nov 2000 17:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129657AbQKSWWE>; Sun, 19 Nov 2000 17:22:04 -0500
Received: from web.sajt.cz ([212.71.160.9]:58884 "EHLO web.sajt.cz")
	by vger.kernel.org with ESMTP id <S129598AbQKSWVr>;
	Sun, 19 Nov 2000 17:21:47 -0500
Date: Sun, 19 Nov 2000 22:50:37 +0100 (CET)
From: Pavel Rabel <pavel@web.sajt.cz>
To: mj@suse.cz
cc: linux-kernel@vger.kernel.org
Subject: Re: "No IRQ known for interrupt pin A..." error message
Message-ID: <Pine.LNX.4.21.0011192244240.29043-100000@web.sajt.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> During boot, I get the message:
> 
> PCI: No IRQ known for interrupt pin A of device 00:00.1. Please try
> using pci=biosirq.

It is related to VGA card (at least on my system).
Enabling 'Assign IRQ for VGA' in BIOS causes the message to disapear.

Pavel


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
