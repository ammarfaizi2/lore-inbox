Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287939AbSBDOXo>; Mon, 4 Feb 2002 09:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288086AbSBDOXe>; Mon, 4 Feb 2002 09:23:34 -0500
Received: from mustard.heime.net ([194.234.65.222]:27089 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S287939AbSBDOXV>; Mon, 4 Feb 2002 09:23:21 -0500
Date: Mon, 4 Feb 2002 15:23:18 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>, Tux mailing list <tux-list@redhat.com>
Subject: Re: [patch] O(1) scheduler, -K2
In-Reply-To: <Pine.LNX.4.33.0202040621400.22435-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.30.0202041521200.22987-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

Today, the O(1) seems to be quite incompatible with Tux. Will you be
merging these two together, or is that a no-go?

thanks

roy

On Mon, 4 Feb 2002, Ingo Molnar wrote:

>
> the -K2 O(1) scheduler patch for kernels 2.5.3, 2.4.18-pre7 and 2.4.17 is
> available at:
>
>     http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.3-K2.patch
>     http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-K2.patch
>     http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.18-pre7-K2.patch
>
> the -K2 patch includes fixes, cleanups, performance improvements and
> interactivity improvements.
>
> Bug reports, comments, suggestions are welcome,
>
> 	Ingo
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

