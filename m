Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315606AbSEZDRz>; Sat, 25 May 2002 23:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315599AbSEZDRy>; Sat, 25 May 2002 23:17:54 -0400
Received: from bitmover.com ([192.132.92.2]:5845 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S315606AbSEZDRt>;
	Sat, 25 May 2002 23:17:49 -0400
Date: Sat, 25 May 2002 20:17:49 -0700
From: Larry McVoy <lm@bitmover.com>
To: David Schleef <ds@schleef.org>
Cc: Karim Yaghmour <karim@opersys.com>, Larry McVoy <lm@bitmover.com>,
        Wolfgang Denk <wd@denx.de>, linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020525201749.A19792@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Schleef <ds@schleef.org>, Karim Yaghmour <karim@opersys.com>,
	Larry McVoy <lm@bitmover.com>, Wolfgang Denk <wd@denx.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020525110208.A15969@work.bitmover.com> <20020525182617.D627E11972@denx.denx.de> <20020525114426.B15969@work.bitmover.com> <3CEFEB73.5BB2C14C@opersys.com> <20020525133637.B17573@work.bitmover.com> <20020525190913.A6869@stm.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 07:09:13PM -0700, David Schleef wrote:
> I checked RTAI vs. RTLinux, and it turned up 2 things: an example
> written by Jerry Epplin, and the implementation of rt_printk(),
> which was written by me.  Neither of these were "originally" in
> RTLinux, they were both "originally" posted to the RTLinux mailing
> list.
> 
> There was one more match that was publicly claimed as copying by
> the maintainer of RTLinux -- a few fields in the scheduler structure.
> The script caught those, too, once I set the threshhold down to 3
> lines, which also picked up hundreds of mismatches.  

Good luck making that stick in court.  First of all, the RTAI guys have
admitted over and over that RTAI is a fork of the RTLinux source base.
Your claims that that isn't true are countered by principles from both
parties in question.  Second of all, both source bases have evolved 
since the fork.  Whether your script catches the common heritage or 
not has no meaning, the fact remains that one is derived from the
other, and as such has to be GPLed.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
