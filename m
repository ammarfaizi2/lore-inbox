Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131842AbRCXWse>; Sat, 24 Mar 2001 17:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131861AbRCXWsY>; Sat, 24 Mar 2001 17:48:24 -0500
Received: from www.wen-online.de ([212.223.88.39]:38156 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131842AbRCXWsS>;
	Sat, 24 Mar 2001 17:48:18 -0500
Date: Sat, 24 Mar 2001 23:47:44 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <3ABCE547.DD5E78B9@redhat.com>
Message-ID: <Pine.LNX.4.33.0103242307520.570-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Mar 2001, Doug Ledford wrote:

> Mike Galbraith wrote:
> >
> > General thread comment:
> > To those who are griping, and obviously rightfully so, Rik has twice
> > stated on this list that he could use some help with VM auto-balancing.
> > The responses (visible on this list at least) was rather underwhelming.
> > I noted no public exchange of ideas.. nada in fact.
>
> While my post didn't give an exact formula, I was quite clear on the fact that
> the system is allowing the caches to overrun memory and cause oom problems.

Yes.  A testcase would be good.  It's not happening to everybody nor is
it happening under all loads.  (if it were, it'd be long dead)

> I'm more than happy to test patches, and I would even be willing to suggest
> some algorithms that might help, but I don't know where to stick them in the
> code.  Most of the people who have been griping are in a similar position.

First step toward killing the critter is to lure him onto open ground.
Once there.. well, I've seen some pretty fancy shooting on this list.

	-Mike

