Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265966AbUAEWfE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265986AbUAEWdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:33:52 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:62471 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265966AbUAEWcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:32:05 -0500
Date: Mon, 5 Jan 2004 22:32:03 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: claas@rootdir.de, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0: atyfb broken
In-Reply-To: <20031230212609.GA4267@rootdir.de>
Message-ID: <Pine.LNX.4.44.0401052230150.7347-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hello,
> 
> I have got an HP omnibook 4150B. When booting with atyfb,
> the kernel messages look great:
> 
> atyfb: 3D RAGE Mobility (PCI) [0x4c4d rev 0x64] 8M SDRAM, 29.498928 MHz XTAL, 230 MHz PLL, 50 Mhz MCLK
> fb0: ATY Mach64 frame buffer device on PCI

Can you try my latest patch. 

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz


