Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287258AbRL2Xi2>; Sat, 29 Dec 2001 18:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287250AbRL2XiL>; Sat, 29 Dec 2001 18:38:11 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:30736 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S287263AbRL2Xh5>; Sat, 29 Dec 2001 18:37:57 -0500
Date: Sat, 29 Dec 2001 15:39:03 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Andrew Morton <akpm@zip.com.au>
cc: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Balanced Multi Queue Scheduler ...
In-Reply-To: <3C2E4875.9D0F4BC6@zip.com.au>
Message-ID: <Pine.LNX.4.40.0112291538270.1580-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, Andrew Morton wrote:

> > It'd be nice to have inside local_irq_disable()/enable() a cycle counter
> > sampler to see what is the worst case path with disabled irqs.
> >
>
> http://www.zip.com.au/~akpm/linux/#intlat
>
> This tool needs a bit of maintenance work, but it can measure and identify
> the source of worst-case interrupt latencies quite successfully.

Thx, i'll take a look.



- Davide


