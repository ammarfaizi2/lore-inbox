Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262161AbSJ2R3i>; Tue, 29 Oct 2002 12:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262178AbSJ2R3i>; Tue, 29 Oct 2002 12:29:38 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:40591 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S262161AbSJ2R3h>; Tue, 29 Oct 2002 12:29:37 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 29 Oct 2002 09:45:08 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Shailabh Nagar <nagar@watson.ibm.com>
cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [PATCH] Updated sys_epoll now with man pages
In-Reply-To: <3DBEA982.8010309@watson.ibm.com>
Message-ID: <Pine.LNX.4.44.0210290943130.1457-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, Shailabh Nagar wrote:

> Andrew,
>
> It would be very helpful if you could point out what were the bugs you found
> objectionable enough to withold your approval for the patch's inclusion.
>
> It appears that the lack of comments in the code is one major concern. That alone
> being a reason to dismiss the sys_epoll patch seems unreasonable. Consider
> - there are another 3-4 months before the stable kernel will be out. In the
> interim, Davide with assistance from some of us IBMers can put in the desired
> level of comments in the code. Our committment to having a fully understood patch
> should be evident from the release of man pages and a detailed web page listing
> performance results alongwith the patch itself.
> - this patch is the ONLY available scalable alternative to poll() and does far
> better. To make an example out of this patch for not conforming to commenting
> standards is a little extreme.
>
> That being said, if there are bugs (small or large) that make the patch
> questionable, I would understand why it can't be included. But we do need to
> know what the bugs are. Davide had been very responsive to your last set of
> comments and included all of them in his patch.
>
> Please do find the time to list out atleast some of the bugs that you found.

Guys, Andrew sent me suggestions about the code and I'm working with him
to see what it might be improved in the current code. I think that I'll
have a patch ready before the end of today ...



- Davide


