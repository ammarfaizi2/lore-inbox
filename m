Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287244AbRL2XO5>; Sat, 29 Dec 2001 18:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287230AbRL2XOs>; Sat, 29 Dec 2001 18:14:48 -0500
Received: from bitmover.com ([192.132.92.2]:37800 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S287235AbRL2XOl>;
	Sat, 29 Dec 2001 18:14:41 -0500
Date: Sat, 29 Dec 2001 15:14:40 -0800
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, Benjamin LaHaise <bcrl@redhat.com>,
        Oliver Xymoron <oxymoron@waste.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Message-ID: <20011229151440.A21760@work.bitmover.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Larry McVoy <lm@bitmover.com>, Benjamin LaHaise <bcrl@redhat.com>,
	Oliver Xymoron <oxymoron@waste.org>,
	Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011229140410.A13883@work.bitmover.com> <E16KSQt-0005zf-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E16KSQt-0005zf-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Dec 29, 2001 at 10:58:27PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 10:58:27PM +0000, Alan Cox wrote:
> > > Wrong.  Most patches are independant, and even touch different functions.  
> > 
> > Really?  And the data which shows this absolute statement to be true is
> > where?  I'm happy to believe data, but there is no data here.
> 
> I rarely get clashes in merges with either 2.2 or with 2.4-ac when I was
> doing it. Offsets from multiple patches to the same file happen some times
> but its very rare two people had overlapping changes and when it happened
> it almost always meant that the two of them needed to talk because they were
> fixing the same thing or adding related features.

So that means that pretty much 100% of development to any one area is being
done by one person?!?   That's cool, but doesn't it limit the speed at which
forward progress can be made?  And does that mean for any area there is only
one person who really understands it?

I'm not sure that you want single threading of development to be something
enforced by your development process, and that's what it is starting to 
sound like more and more.  Isn't it true that a lack of merge conflicts
means that there is no parallel development in that area?  

We have lots of commercial customers using BK on the Linux kernel, they
are doing embedded this and that.  The rate of change that they make is
much greater than the rate of change made in the Linus maintained tree.
I'm not saying it's good or bad, it's just different.  I can say that
merging is a huge issue in commercial shops.  It's interesting to hear 
that it is not in Linux.

Some sociology guy with a CS background should do a study on this and 
explore the differences.  Is fast change better?  Is slow change better?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
