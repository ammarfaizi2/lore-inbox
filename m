Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262887AbSJGGQC>; Mon, 7 Oct 2002 02:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262890AbSJGGQC>; Mon, 7 Oct 2002 02:16:02 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:40877 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S262887AbSJGGQB>; Mon, 7 Oct 2002 02:16:01 -0400
Message-Id: <200210070621.g976LV1H428754@pimout4-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Larry McVoy <lm@bitmover.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: New BK License Problem?
Date: Sun, 6 Oct 2002 21:21:19 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Larry McVoy <lm@bitmover.com>, "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <20021006075627.I9032@work.bitmover.com> <Pine.LNX.4.44.0210061718370.9062-100000@localhost.localdomain> <20021006081514.J9032@work.bitmover.com>
In-Reply-To: <20021006081514.J9032@work.bitmover.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's Interesting what question Larry is going out of his way NOT to answer.

Ingo asked:

> what happens if Linux merges some sort of kernel based versioned
> filesystem, eg. something similar to what ClearCase does today?

Larry responded, unhelpefully:

> I think the license is clear on that point.

So why did Ingo ask the question?  Oh well.

Ingo again:

> so BK cannot be used to access the kernel tree in that case, correct? I'm
> just wondering where the boundary line is. Eg. if i started working on a
> versioned filesystem today, i'd not be allowed to use BK. I just have to
> keep stuff like that in mind when using BK.

Larry responded again, but again ducked the question, choosing insead to talk 
about ClearCase.

It seems pretty clear that the people who object to BitKeeper have an easy 
way to force it out out of Kernel developent: You don't have to reproduce 
bitkeeper, just write a version controlled filesystem (or version control 
extension to an existing filesystem) that Linus likes enough to include in 
the tree.  (EVMS probably doesn't qualify as such, but I'm sure Larry could 
make a case it does if he really wanted to.  So nobody really has a license 
to use no-charge bitkeeper, they really just have permission as long as 
Larry's in a good mood.  But this is nothing new, is it?)

It's possible that a version controlled filesystem will never be accepted 
into the Linux tree just because Linus wouldn't want to give up bitkeeper.  
Oh well.  Can't say I've ever personally had a need for one, and you could 
always do it via Coda, assuming the existince of such a tool wouldn't taint 
the Coda parts of the kernel... :)

Rob
