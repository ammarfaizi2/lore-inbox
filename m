Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262395AbSKCUSt>; Sun, 3 Nov 2002 15:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262430AbSKCUSt>; Sun, 3 Nov 2002 15:18:49 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:32810 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id <S262395AbSKCUSs>; Sun, 3 Nov 2002 15:18:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jos Hulzink <josh@stack.nl>
To: Vojtech Pavlik <vojtech@suse.cz>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Petition against kernel configuration options madness...
Date: Sun, 3 Nov 2002 23:25:28 +0100
User-Agent: KMail/1.4.3
References: <200211031809.45079.josh@stack.nl> <20021103193734.GC2516@pasky.ji.cz> <20021103211308.B8636@ucw.cz>
In-Reply-To: <20021103211308.B8636@ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211032325.28397.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 November 2002 21:13, Vojtech Pavlik wrote:
>
> All the needed options ARE enabled by default. (check arch/i386/defconfig)

Now all you need is the users to know "make defconfig". I compile kernels since 1.2.13, but I didn't know the option till today. Sure, my fault, but I'm sure I'm not the only one.

Detail: IMHO the USB keyboard and mouse support should be on, and DRI should be enabled for all video cards, but that is a minor issue...

Jos

