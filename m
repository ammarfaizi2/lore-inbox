Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263130AbUKTRs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbUKTRs0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 12:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263132AbUKTRs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 12:48:26 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7948 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263130AbUKTRsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 12:48:18 -0500
Date: Sat, 20 Nov 2004 18:48:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jim Nelson <james4765@verizon.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove obsolete Computone MAINTAINERS entry (fwd)
Message-ID: <20041120174816.GC2829@stusta.de>
References: <20041120002559.GB2754@stusta.de> <20041119194735.63d2a257.akpm@osdl.org> <20041120125017.GB2829@stusta.de> <419F5D69.2080407@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419F5D69.2080407@verizon.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 10:06:17AM -0500, Jim Nelson wrote:
> Adrian Bunk wrote:
> >On Fri, Nov 19, 2004 at 07:47:35PM -0800, Andrew Morton wrote:
> >
> >>Adrian Bunk <bunk@stusta.de> wrote:
> >>
> >>>I'm not sure whether it makes sense to list the previous maintainers for 
> >>>orphaned code, but if such entries contain buouncing mail addresses it's 
> >>>IMHO time to simply remove them.
> >>>
> >>>...
> >>>-M:	Michael H. Warfield <mhw@wittsend.com>
> >>
> >>wittsend.com is still there and Michael still runs it.
> >
> >
> >At least the listed mailing list is defunct:
> >
> ><linux-computone@lazuli.wittsend.com>:
> >Sorry, I wasn't able to establish an SMTP connection. (#4.4.1)
> >I'm not going to try again; this message has been in the queue too long.
> >
> >
> >And to be honest, I don't see that much value in shiping entries in 
> >MAINTAINERS for people who have reseigned as maintainers.
> 
> If someone is willing to step up to the plate and get the driver working 
> again, it would be better to have the contact information for the old 
> maintainer available in a centralized location.  Plus, anyone who tries the 

It's still in Documentation/computone.txt, and if someone wants to do 
seroious work on an orphaned driver, I assume he'll start with reading 
the driver and documentation.

> driver and finds it busted can look in the MAINTAINERS file and find out 
> that it's not being fixed, instead of it being one of those drivers that 
> has no defined maintainer (I've run across a few).
> 
> After all, we do have to be honest about unmaintained drivers - rather than 
> hiding broken code.  Honestly, it's better to define who's responsible for 
> an area of code, even if it no longer works.

MAINTAINERS does not cover all drivers.
It's not about being honest or about hiding broken code, but adding 
let's say fifty entries for no longer supported drivers isn't of any 
practical value.

At least I'm checking MAINTAINERS for people who want to receive the 
patches I send today, not for people who have worked on the driver at 
some time in the past. Adding information about orphaned drivers to this 
file simply makes it harder to find whether valid entries covering the 
driver in question exist.

If someone steps up and wants to generate and maintain a driver status 
document that would be fine with me. But this would require a serious 
amount of work and is more than just adding a few orphaned drivers to 
MAINTAINERS.

> My $0.02.
> 
> Jim

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

