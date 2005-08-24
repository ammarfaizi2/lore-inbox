Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbVHXWkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVHXWkg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 18:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbVHXWkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 18:40:36 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:7698 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932347AbVHXWkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 18:40:36 -0400
Date: Thu, 25 Aug 2005 00:40:29 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.13-rc7 : OK
Message-ID: <20050824224029.GA1909@pcw.home.local>
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Aug 23, 2005 at 10:08:13PM -0700, Linus Torvalds wrote:
> 
> Hullo.
> 
>  I really wanted to release a 2.6.13, but there's been enough changes 
> while we've been waiting for other issues to resolve that I think it's 
> best to do a -rc7 first.
> 
> Most of the -rc7 changes are pretty trivial, either one-liners or 
> affecting some particular specific driver or unusual configuration. The 
> shortlog (appended) should give a pretty good idea of what's up.

Well, it's been running here for a few hours this evening, and I must say
that I have not noticed anything strange yet (except the printk timestamps
which switch to zero twice during boot and start with funny values, but
that's not important). The box is a dual-k7 with aic7xxx, and NFSv3 over
an e1000 NIC. Tested with SMP and preempt enabled.

> 
> 		Linus

Regards,
Willy

