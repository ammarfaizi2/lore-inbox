Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129756AbQKAQ1i>; Wed, 1 Nov 2000 11:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131248AbQKAQ12>; Wed, 1 Nov 2000 11:27:28 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:31517 "EHLO
	amsmta06-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129756AbQKAQ1T>; Wed, 1 Nov 2000 11:27:19 -0500
Date: Wed, 1 Nov 2000 18:35:12 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: J{rvensivu Riku <galaxy@cs.tut.fi>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Q: HPT370 RAID support?
In-Reply-To: <Pine.GSO.4.21.0011011454170.28486-100000@korppi.cs.tut.fi>
Message-ID: <Pine.LNX.4.21.0011011833060.20580-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hello,
> 
> The Highpoint Technologies HPT370 ATA-100 + RAID chip is supported well
> the lastest releases but it's RAID features are not implemented. I've
> heard rumours telling that this chip isn't a real RAID chip possessing
> only minimal (if any) hardware RAID capabilities and even those are
> undocumented. Is this right or are there any plans to implement some RAID
> features, as far as it would do any difference compared to the
> really nicely working software-RAID? (Andre Hedrick?)

The RAID is a BIOS with some nice routines. It basically is a dual IDE
controller with some crappy peace of software. Should even be allowed to
be called 'RAID'.

The're giving custumers the impression they get RAID for $2, while a real
RAID setup costs a lot more. I call this misleading.



	Igmar
	



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
