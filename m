Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261403AbTCMApq>; Wed, 12 Mar 2003 19:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261477AbTCMApq>; Wed, 12 Mar 2003 19:45:46 -0500
Received: from bitmover.com ([192.132.92.2]:15293 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261403AbTCMApp>;
	Wed, 12 Mar 2003 19:45:45 -0500
Date: Wed, 12 Mar 2003 16:56:27 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Ben Collins <bcollins@debian.org>, lm@bitmover.com,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030313005627.GJ7275@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Ben Collins <bcollins@debian.org>, lm@bitmover.com,
	linux-kernel@vger.kernel.org
References: <20030312034330.GA9324@work.bitmover.com> <20030312041621.GE563@phunnypharm.org> <20030312193806.2506042c.diegocg@teleline.es> <20030312184710.GI563@phunnypharm.org> <93890000.1047515366@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93890000.1047515366@flay>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Of course, I'm in no position to dictate to others what they should
> implement, do what you like ... just my personal opinion. But there's
> always the possiblity we can make something that fits kernel development
> *better*, rather than playing catchup to BK all the time ;-)

I like it when I agree with people, especially you since we've bumped
heads.  It's much more fun to agree...

My personal opinion is that BK maps only so so well onto the kernel
development effort.  It's not horrible, it's closer than any other SCM,
but it could be better.  The kernel guys tend to be "more loose" than
commercial guys, i.e., stuff is tried, it sits in Alan's tree for a
while or DaveJ's tree and then is rejected if it is found to be bad.
You really need a sort of "lossy" SCM system, one which is willing to
throw data away.  BK is absolutely not about losing information, we view
everything as valuable, even bad ideas.  That matches the commercial
world better than the Linux world.

I _think_ that Arch is closer.  You will definitely give up some stuff
if you move to Arch but you will also gain some stuff.  Arch is willing
to pick and choose, we aren't, we're sort of an all or nothing answer.
Pavel is all hot and bothered about PRCS but PRCS is sort of BK without
the distribution, gui tools, and scripting.  It's a step backwards as
far as I can tell (don't get me wrong, we've acknowledged the coolness
of PRCS on our website for years and I tried to team up with Josh, I'm
a fan).  You should really look at Arch, it may be a better fit.  And 
these days, if you could find a better fit, none of us at BitMover 
would shed a tear if you moved off BK.  This has *not* been a pleasant
experience for us.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
