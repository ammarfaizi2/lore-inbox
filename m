Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281525AbRKQAbD>; Fri, 16 Nov 2001 19:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281537AbRKQAaw>; Fri, 16 Nov 2001 19:30:52 -0500
Received: from intranet.resilience.com ([209.245.157.33]:5583 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S281527AbRKQAam>; Fri, 16 Nov 2001 19:30:42 -0500
Message-ID: <3BF5B05F.9F727DD8@resilience.com>
Date: Fri, 16 Nov 2001 16:33:35 -0800
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AMD SMP capability sanity checking.
In-Reply-To: <Pine.LNX.4.30.0111162353140.32578-100000@Appserv.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> Burning out a fuse to make the switch from MP->XP may affect more
> than just the cpuid capabilities. The fact is _we don't know_
> 

Right, so why assume it doesn't work?

> I've yet to see a socket 370 dual processormotherboard that
> I'd put faith in for a mission critical environment.
> "I had no problems" means _nothing_ when theres as few as 1 other
> user reporting SMP related problems with the same setup.
> 

People with "true" SMP CPUs can have problems as well.  Does this mean
SMP CPUs are not SMP capable?  If only one person is having problems,
chances are there's a problem someplace.  Could it be a faulty
motherboard?  Mismatched CPUs?  Bad memory?  Bad CPU?  Bad power
supply?  There's an awful lot of variables here.

-Jeff

-- 
Jeff Golds
Sr. Software Engineer
jgolds@resilience.com
