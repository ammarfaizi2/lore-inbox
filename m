Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261285AbSJFPFv>; Sun, 6 Oct 2002 11:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261538AbSJFPFv>; Sun, 6 Oct 2002 11:05:51 -0400
Received: from mx1.elte.hu ([157.181.1.137]:47577 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261285AbSJFPFu>;
	Sun, 6 Oct 2002 11:05:50 -0400
Date: Sun, 6 Oct 2002 17:22:33 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Larry McVoy <lm@bitmover.com>
Cc: "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
In-Reply-To: <20021006075627.I9032@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0210061718370.9062-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 6 Oct 2002, Larry McVoy wrote:

> > a simple question: does the BK license allow the Rational kernel
> > developers to use BK (to eg. check out Linus' tree) when working on kernel
> > support for ClearCase?
> 
> I think the license is clear on that point.

so BK cannot be used to access the kernel tree in that case, correct? I'm
just wondering where the boundary line is. Eg. if i started working on a
versioned filesystem today, i'd not be allowed to use BK. I just have to
keep stuff like that in mind when using BK.

> > perhaps you should restrict the BK license's wording to closed-source
> > 'competitors' only
> 
> And how would that solve the problem posed in your first question?

in no way - but it would be a (small) incentive for them to open-source
their kernel mods. Which would also enable you to use the technology. Ie.  
potentially good for you.

	Ingo

