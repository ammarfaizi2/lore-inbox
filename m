Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268173AbTBXGnS>; Mon, 24 Feb 2003 01:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268131AbTBXGnS>; Mon, 24 Feb 2003 01:43:18 -0500
Received: from bitmover.com ([192.132.92.2]:54721 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S268177AbTBXGnR>;
	Mon, 24 Feb 2003 01:43:17 -0500
Date: Sun, 23 Feb 2003 22:52:04 -0800
From: Larry McVoy <lm@bitmover.com>
To: Gerhard Mack <gmack@innerfire.net>
Cc: Larry McVoy <lm@bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Bill Davidsen <davidsen@tmr.com>, Ben Greear <greearb@candelatech.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224065204.GA6074@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Gerhard Mack <gmack@innerfire.net>, Larry McVoy <lm@bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Bill Davidsen <davidsen@tmr.com>,
	Ben Greear <greearb@candelatech.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030224045717.GC4215@work.bitmover.com> <Pine.LNX.4.44.0302240109420.31224-100000@innerfire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302240109420.31224-100000@innerfire.net>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Dig through the mail logs and you'll see that I was completely against the
> > preemption patch.  I think it is a bad idea, if you want real time, use
> > rt/linux, it solves the problem right.
> 
> So your saying I need to switch to rt/linux to run games or an mp3 player?

It depends on the quality you want.  If you want it to work without
exception, yeah, I guess that is what I'm saying.  People seem to be
willing to put up with sloppy playback on a computer that they would
freak out over if it happened on their TV.  rt/linux will make your
el cheapo laptop actually deliver what you need.

I think there has been a fair amount of discussion of this sort of stuff
in the games world.  Some game company got taken to task recently because
even 2Ghz machines couldn't run their game properly.  Makes me wonder if
a real time system is what they need.  
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
