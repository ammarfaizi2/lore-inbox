Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTKUWBH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 17:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTKUWBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 17:01:07 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:11905
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261270AbTKUWBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 17:01:06 -0500
Date: Fri, 21 Nov 2003 16:59:47 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Jing Xu <xujing_cn2001@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: cannot mask irqs by pci=irqmask=
In-Reply-To: <20031121212412.13302.qmail@web41315.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0311211659060.2498@montezuma.fsmlabs.com>
References: <20031121212412.13302.qmail@web41315.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Nov 2003, Jing Xu wrote:

> How do I change these IRQ's?  Is there some other
> configuration file I haven't found? If anyone can
> provide any insight into this, I would appreciate it
> greatly. Let me know what/if any details you need - I
> am by no means an expert in this area and didn't want
> to post reams of irrelevant information, but if there
> is something I'm missing let me know and I'll get
> it...

You can modify PCI slot IRQ assignment in your BIOS, or you could simply 
disable the USB driver in the kernel.

