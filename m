Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbTARGLr>; Sat, 18 Jan 2003 01:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbTARGLq>; Sat, 18 Jan 2003 01:11:46 -0500
Received: from main.gmane.org ([80.91.224.249]:43436 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S262807AbTARGLp>;
	Sat, 18 Jan 2003 01:11:45 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Kevin Puetz <puetzk@iastate.edu>
Subject: Re: Is the BitKeeper network protocol documented?
Date: Sat, 18 Jan 2003 00:20:15 -0600
Message-ID: <b0arl3$59p$1@main.gmane.org>
References: <20030118043309.GA18658@bjl1.asuk.net> <20030118052919.GA22751@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

> As far as I can tell your complaint is that you can't have access to
> the up to minute source view without using something which violates
> your politics.

No, without something that violates your license. Nice of him to actually
respect it :-)

> The fact that you can get almost real time views via one of many BK to
> tarball/patch mirrors seems to not be good enough.
> 
> I guess I don't know how to help you.  As far as I can tell, if Linus
> wasn't using BK he'd still be doing what he was doing up until he started
> using BK which means you wouldn't have the option of the up to date
> snapshots you can currently get.

Yes, a huge thank-you for making this possible... it's easy to forget that
the max wait time is now an hour, and it used to be weeks... linus's brain
is a much harder protocol to mirror than bk :-)

> I fail to see why this is such a big deal, you now have up to the
> hour snapshots in the form you want where before you had to wait weeks
> between releases.  That's a dramatic improvement over what you had a
> year ago and complaining that you can't have up to the minute views of
> the source when the only reason is your politics, well, is it going to
> seem really unreasonable if I think that maybe your politics are getting
> in the way of your technical goals?

Well, I would point out that it's not politics, but rather respect for your
licensing terms that prevents him from using bk. (this part got snipped
relatively early, maybe you missed it)

> Although I am unfortable using closed source software, it seemed
> pragmatic to fetch and install BitKeeper.  I went to bitmover.com, and
> read the free license before downloading:
> 
>         http://www.bitkeeper.com/Sales.Licensing.Free.html
> 
> That looked ok.  I am allowed to use it.  Great!
> 
> So I downloaded version 3.0, and typed "bk help bkl".  I found that
> the license with the software is different to the licence on the web
> page.
> 
>         [Note to Larry, you may wish to update the above URL to the
>         current version].
> 
> Unfortunately, the license that comes with the download adds a new
> clause 3(d): that's the clause which tells me that actually I'm not
> allowed to use BitKeeper, because of other software I occasionally
> work on.  (No, I do not work on Subversion, but I do occasionally
> dabble with sophisticated version management scripts).
> 
> So, being conscientious and obedient, I removed BitKeeper from my system.

So, as you said you would consider case by case license grants if this
clause became a problem when it was last discussed (IIRC anyway, I don't
mean to put words in your mouth if I'm remembering that thread wrong),
maybe this would be a good time for one. Or he can use the hourly changeset
mirror :-)

