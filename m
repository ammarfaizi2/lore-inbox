Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267467AbSLRTmr>; Wed, 18 Dec 2002 14:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267468AbSLRTmr>; Wed, 18 Dec 2002 14:42:47 -0500
Received: from waste.org ([209.173.204.2]:15298 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S267467AbSLRTmq>;
	Wed, 18 Dec 2002 14:42:46 -0500
Date: Wed, 18 Dec 2002 13:50:09 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@redhat.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: Freezing.. (was Re: Intel P6 vs P7 system call performance)
Message-ID: <20021218195009.GB15237@waste.org>
References: <20021218165838.GD27695@suse.de> <Pine.LNX.4.44.0212180936550.2891-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212180936550.2891-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 09:41:15AM -0800, Linus Torvalds wrote:
> 
> > The approval process does seem to be quite a lot of work though.
> > I think it was rth last year at OLS who told me that at that time
> > he'd been doing more approving of other peoples stuff than coding himself.
> 
> I heartily disagree with the approval process for development, just
> because it gets so much in the way and just annoys people. But for
> stabilization, that's exactly what you want. So I think gcc is using the
> approval process much too much, but apparently it works for them.
> 
> And I think it could work for the kernel too, especially the stable
> releases and for the process of getting there. I just don't really know
> how to set it up well.

Actually, I think Marcello's got the stable process pretty well
figured out without any of this committee business. And given that his
credibility as 2.4 maintainer depends on his holding to the mandate to
make the kernel stable, he probably doesn't have too hard a time
holding the line. As benevolent dictator, you're simply not beholden
to such expectations and I doubt the committee approach would work for
long either.

So perhaps you should throw out a date for 'code freeze' and then plan to
hand off to the 2.6 maintainer at that date. 

The other piece that will help is if the timeline for 2.7 shows up
around then and is short enough so that people won't despair of ever
getting their big feature in.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
