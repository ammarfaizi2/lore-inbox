Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287253AbRL2XjS>; Sat, 29 Dec 2001 18:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287250AbRL2XjO>; Sat, 29 Dec 2001 18:39:14 -0500
Received: from bitmover.com ([192.132.92.2]:47528 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S287256AbRL2Xil>;
	Sat, 29 Dec 2001 18:38:41 -0500
Date: Sat, 29 Dec 2001 15:38:40 -0800
From: Larry McVoy <lm@bitmover.com>
To: Dave Jones <davej@suse.de>
Cc: Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Benjamin LaHaise <bcrl@redhat.com>,
        Oliver Xymoron <oxymoron@waste.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Message-ID: <20011229153840.C21760@work.bitmover.com>
Mail-Followup-To: Dave Jones <davej@suse.de>, Larry McVoy <lm@bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Benjamin LaHaise <bcrl@redhat.com>,
	Oliver Xymoron <oxymoron@waste.org>,
	Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011229151440.A21760@work.bitmover.com> <Pine.LNX.4.33.0112300027400.1336-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0112300027400.1336-100000@Appserv.suse.de>; from davej@suse.de on Sun, Dec 30, 2001 at 12:33:29AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2001 at 12:33:29AM +0100, Dave Jones wrote:
> On Sat, 29 Dec 2001, Larry McVoy wrote:
> 
> > So that means that pretty much 100% of development to any one area is being
> > done by one person?!?   That's cool, but doesn't it limit the speed at which
> > forward progress can be made?
> 
> The closest approximation my minds-eye can make of how things work
> look something like this..
> 
> h h h h h
> \ | | | /
>  m  m m
>   \ |/
>   ttt
>    |
>    l
> 
> h - random j hacker working on same file/subsystem different goals
> m - maintainer for file/subsys
> t - "forked" tree maintainer (-ac, -dj, -aa etc..)
> l - Linus
> 
> Whilst development happens concurrently in parallel, the notion of
> progress is somewhat serialised as changes work their way down to
> Linus.

In my message above, I specifically asked about any one area, asking if 
there was parallel development in that area.  So far, noone has said "yes".
If the answer was "yes", somebody in your fanin (nice ascii, BTW :) is
merging.  So the answer is either

	noone => no parallel development in any one area
or
	someone

If it is "someone", who is it?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
