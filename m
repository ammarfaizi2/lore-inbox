Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261830AbTCMA2w>; Wed, 12 Mar 2003 19:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261833AbTCMA2w>; Wed, 12 Mar 2003 19:28:52 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:42487 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261830AbTCMA2v>; Wed, 12 Mar 2003 19:28:51 -0500
Date: Wed, 12 Mar 2003 16:29:26 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ben Collins <bcollins@debian.org>
cc: lm@work.bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <93890000.1047515366@flay>
In-Reply-To: <20030312184710.GI563@phunnypharm.org>
References: <20030312034330.GA9324@work.bitmover.com> <20030312041621.GE563@phunnypharm.org> <20030312193806.2506042c.diegocg@teleline.es> <20030312184710.GI563@phunnypharm.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You're missing the point. I am not against the CVS->BK gateway. I'm all
> for it. But it's kind of sour given that he now wants to change the disk
> format of the repo to make it harder to get the data from it.
> 
> If all he announced was "you now have a CVS->BK repo", I wouldn't be
> complaining, I'd be patting him on the back.

As long as we continue to get all the data in an open format, I'm
not sure this really matters, personally. If there's some data loss,
let's focus on that issue ... but it seems there isn't at the moment.

I'd rather we *didn't* go trying to clone BK and make it file-format 
compatible underneath ... that seems more incendiary than useful. 
Cloning other products is always a loosing game, the best you can do 
is catch them. Personally, I'd prefer we spent the effort making a 
usable simple SCM that 95% of us can use that does merges and stuff, 
and not bother trying to follow someone else in file format.

Of course, I'm in no position to dictate to others what they should
implement, do what you like ... just my personal opinion. But there's
always the possiblity we can make something that fits kernel development
*better*, rather than playing catchup to BK all the time ;-)

M.

