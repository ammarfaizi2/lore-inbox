Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbVLMVM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbVLMVM4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbVLMVM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:12:56 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61457 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1030231AbVLMVMz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:12:55 -0500
Date: Fri, 2 Jan 1970 03:28:43 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Lee Revell <rlrevell@joe-job.com>,
       Dirk Steuwer <dirk@steuwer.de>, linux-kernel@vger.kernel.org
Subject: Re: Runs with Linux (tm)
Message-ID: <19700102032843.GA2445@ucw.cz>
References: <20051205121851.GC2838@holomorphy.com> <20051206011844.GO28539@opteron.random> <43944F42.2070207@didntduck.org> <loom.20051206T094816-40@post.gmane.org> <20051206104652.GB3354@favonius> <loom.20051206T173458-358@post.gmane.org> <20051207141720.GA533@kvack.org> <1133982741.17901.32.camel@mindpipe> <20051207194746.GG533@kvack.org> <439760FF.3060605@mnsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439760FF.3060605@mnsu.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>If even some "Linux-friendly" hardware manufacturers barely cooperate
> >>with the Linux comminuty now what makes you think this would work?
> >>   
> >>
> >
> >Nothing in life is guaranteed.  But at the very least, I think it would 
> >be a good step towards improving the Linux end user experience.  Instead 
> >of the unclear mess we have now (Is it supported?  Check with your 
> >vendor!), we would be able to say "Look for the Linux Certified logo".  
> >Combine that with a standard format for source code driver disks, and 
> >it would be a good step in the right direction.
> >
> > 
> >
> The problem as I see it:
> 
> A hardware vendor hires someone to write a driver.  The driver is 
> completed and submitted and finally makes it into the kernel.  It's 
> fully GPL and everyone is happy.  The hardware gets a "Native Linux 
> Support" logo.  The card goes out of favor and no one is interested in 
> maintaining the driver, it is marked obsolete and finally removed from 
> the kernel. ...the logo still suggests the hardware will work.

And? There's no problem. You still have GPLed driver, that is
reasonably nice (it was in kernel at one point), so you just fix that.
Don't overcomplicate this.

								Pavel
-- 
Thanks, Sharp!
