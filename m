Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131026AbRARB0k>; Wed, 17 Jan 2001 20:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131184AbRARB0a>; Wed, 17 Jan 2001 20:26:30 -0500
Received: from [129.94.172.186] ([129.94.172.186]:42736 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131026AbRARB0Y>; Wed, 17 Jan 2001 20:26:24 -0500
Date: Thu, 18 Jan 2001 12:26:02 +1100 (EST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@localhost.localdomain>
To: Tobias Ringstrom <tori@tellus.mine.nu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What happened to your kernel changelogs?
In-Reply-To: <Pine.LNX.4.30.0101171438260.11321-100000@svea.tellus>
Message-ID: <Pine.LNX.4.31.0101181223220.31432-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2001, Tobias Ringstrom wrote:

> I liked them a lot, and I bet I'm not alone.  Are they gone for
> good, or have you just ceased writing them for test kernels?

I like them a lot too.

Without the changelogs Linus is just a "black box"
which outputs random patches.

With a good changelog, we all have a much better idea
what Linus wants and, consequently, what kind of patches
we should give him (and which kind of patches we should
wait with for a week or so).

Also, the changelog items are a good way to keep track
of what's happening with the kernel, it makes it so much
faster to track down exactly when a bug was fixed or
introduced and what change had this effect.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
