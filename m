Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbTJaM74 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 07:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263292AbTJaM74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 07:59:56 -0500
Received: from jack.stev.org ([217.79.103.51]:58920 "EHLO jack.stev.org")
	by vger.kernel.org with ESMTP id S263290AbTJaM7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 07:59:55 -0500
Date: Fri, 31 Oct 2003 13:06:20 +0000 (GMT)
From: James Stevenson <james@stev.org>
X-X-Sender: james@Beast.ez-dsp.com
To: Angelo Compagnoni <acompagnoni@ntb.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: PCI-driver bursting to target
In-Reply-To: <001b01c39897$09e08aa0$b1248892@ntb.ch>
Message-ID: <Pine.LNX.4.44.0310311305510.2460-100000@Beast.ez-dsp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is what dma on the device is normally for.
Does your hardware support DMA ?

On Wed, 22 Oct 2003, Angelo Compagnoni wrote:

> >Is there any feature in the kernel source, that supports burst >writes and
> reads to a target?
> >The driver I have works for single data transfer with the methods
> >writel(b,addr) and readl(addr).
> >I need the burst mode for my diploma thesis.
> >Thank you for help.
> >
> >I wish to be personally CC'ed the answers/comments posted to the >list in
> response to my posting.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

