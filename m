Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWGDA54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWGDA54 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 20:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWGDA54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 20:57:56 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:41663 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751337AbWGDA5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 20:57:55 -0400
Message-ID: <44A9BD0B.8010104@garzik.org>
Date: Mon, 03 Jul 2006 20:57:47 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
CC: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: Linux SATA Support Question - Is the ULI M1575 chip supported?
References: <Pine.LNX.4.64.0607031756510.3342@p34.internal.lan>
In-Reply-To: <Pine.LNX.4.64.0607031756510.3342@p34.internal.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> 
> In the source:
> 
> enum {
>         uli_5289                = 0,
>         uli_5287                = 1,
>         uli_5281                = 2,
> 
>         uli_max_ports           = 4,
> 
>         /* PCI configuration registers */
>         ULI5287_BASE            = 0x90, /* sata0 phy SCR registers */
>         ULI5287_OFFS            = 0x10, /* offset from sata0->sata1 phy 
> regs */
>         ULI5281_BASE            = 0x60, /* sata0 phy SCR  registers */
>         ULI5281_OFFS            = 0x60, /* offset from sata0->sata1 phy 
> regs */
> };
> 
> However, in the manual for this motherboard it states it has a ULI 
> M1575, can anyone comment?
> 
> http://us.dfi.com.tw/Upload/Manual/90800601.pdf

What is the PCI ID?

	Jeff



