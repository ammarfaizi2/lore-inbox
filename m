Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbUK0WN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbUK0WN0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 17:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbUK0WN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 17:13:26 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:54407 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261348AbUK0WNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 17:13:24 -0500
Date: Sat, 27 Nov 2004 15:12:48 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Zoltan Boszormenyi <zboszor@freemail.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: CD-ROM problem on x86-64
In-Reply-To: <41A8F4C3.9070000@freemail.hu>
Message-ID: <Pine.LNX.4.61.0411271512030.3173@montezuma.fsmlabs.com>
References: <41A84875.2030505@freemail.hu> <41A848C4.1030504@freemail.hu>
 <Pine.LNX.4.61.0411271035340.3173@montezuma.fsmlabs.com> <41A8C3BF.20904@freemail.hu>
 <Pine.LNX.4.61.0411271123350.3173@montezuma.fsmlabs.com> <41A8F4C3.9070000@freemail.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Nov 2004, Zoltan Boszormenyi wrote:

> I will soon. Although I have to apply this patch also, more than one
> person use my machine at once. My 2 and a half year old son would be
> angry without his cartoons. ;-)
> 
> In the meantime it turned out that downing eth1 did not solve this
> problem. The r8169 stopped spitting its messages but I still had one
> 
> hda: dma_timer_expiry: dma status == 0x24
> hda: DMA interrupt recovery
> hda: lost interrupt

Or you could try booting with acpi=off
