Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317639AbSGFMOh>; Sat, 6 Jul 2002 08:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317637AbSGFMOg>; Sat, 6 Jul 2002 08:14:36 -0400
Received: from ns.suse.de ([213.95.15.193]:41481 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317639AbSGFMOe>;
	Sat, 6 Jul 2002 08:14:34 -0400
Date: Sat, 6 Jul 2002 14:17:10 +0200
From: Dave Jones <davej@suse.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Rob Landley <landley@trommello.org>, Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Kernel release management
Message-ID: <20020706141710.A8216@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Russell King <rmk@arm.linux.org.uk>,
	Rob Landley <landley@trommello.org>,
	Bill Davidsen <davidsen@tmr.com>,
	Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1020701140915.23920A-100000@gatekeeper.tmr.com> <20020703173421.B8934@suse.de> <20020703200044.EB039C2C@merlin.webofficenow.com> <20020704132120.C11601@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020704132120.C11601@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, Jul 04, 2002 at 01:21:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2002 at 01:21:20PM +0100, Russell King wrote:

 > Think about who will do the stabilisation.  Do you really think Alan or
 > Marcelo will pick up 2.6 when it comes out?  Or do you see someone else
 > picking up 2.6?

Marcelo didn't seem against the idea, and as he's done a pretty good
job so far in 2.4, he seems to be the ideal guy for the job (time
permitting). At the time we get to 2.6.0, 2.4 should have slowed down
sufficiently that he'll be looking for something else to do.

 > One of the fundamental questions that needs to be asked along side the
 > "fork 2.7 with 2.6" problem is _who_ exactly is going to look after 2.6.
 > Dave Jones?  If Dave, who's going to do Daves job of making sure fixes
 > get propagated between stable and development trees?

When we get to 2.6, I'll do 2.6-dj's until the important bits are all
pushed to $maintainer, and keep the leftovers until 2.7-dj.

        Dave 

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
