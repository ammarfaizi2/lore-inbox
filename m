Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265643AbSKOCrQ>; Thu, 14 Nov 2002 21:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265647AbSKOCrP>; Thu, 14 Nov 2002 21:47:15 -0500
Received: from blacksea.dsdns.net ([66.78.32.3]:10477 "EHLO blacksea.bsdns.net")
	by vger.kernel.org with ESMTP id <S265643AbSKOCrJ> convert rfc822-to-8bit;
	Thu, 14 Nov 2002 21:47:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: Eric Northup <lkml@digitaleric.net>
Reply-To: mailing-lists@digitaleric.net
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Date: Thu, 14 Nov 2002 21:53:56 -0500
User-Agent: KMail/1.4.2
References: <1037325839.13735.4.camel@rth.ninka.net> <396026666.1037298946@[10.10.2.3]>
In-Reply-To: <396026666.1037298946@[10.10.2.3]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211142153.56373.lkml@digitaleric.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - blacksea.bsdns.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - digitaleric.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 November 2002 09:35 pm, Martin J. Bligh wrote:
> > I DO NOT want to be working on bugs on anything other than Linus's
> > actualy sources.  The first bug I got was a networking bug with
> > Andrew Morton's -mm patches applied.
[snip
> Hmmm ... I'm not sure that being that restrictive is going to help.
> Whilst bugs against any randomly patched version of the kernel
> probably aren't that interesting, things in major trees like -mm,
> -ac, -dj etc are likely going to end up in mainline sooner or later
> anyway ... wouldn't you rather know of the breakage sooner rather
> than later?

Would this be an appropriate use of the "version" tag in Bugzilla?  Currently 
the only choice is "2.5", but if that were renamed to "2.5-linus", then the 
other heavily used patchsets could be monitored while making it easy for 
people who only want to see bugs in Linus' tree.

-Eric
