Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWIVRt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWIVRt4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 13:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWIVRtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 13:49:55 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4100 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964839AbWIVRty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 13:49:54 -0400
Date: Fri, 22 Sep 2006 19:49:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: The GPL: No shelter for the Linux kernel?
Message-ID: <20060922174953.GD9693@stusta.de>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 11:15:50AM -0500, James Bottomley wrote:

> Although this white paper was discussed amongst the full group of kernel
> developers who participated in the informal poll, as you can expect from
> Linux Kernel Developers, there was a wide crossection of opinion.  This
> document is really only for discussion, and represents only the views of
> the people listed as authors (not the full voting pool).
> 
> James
> 
> ----------
> 
> The Dangers and Problems with GPLv3
> 
> 
> James E.J. Bottomley             Mauro Carvalho Chehab
> Thomas Gleixner            Christoph Hellwig           Dave Jones
> Greg Kroah-Hartman              Tony Luck           Andrew Morton
> Trond Myklebust             David Woodhouse
>...
> 6 Conclusions
> 
>... Therefore, as far as we are
> concerned (and insofar as we control subsystems of the kernel) we cannot
> foresee any drafts of GPLv3 coming out of the current drafting process that
> would prove acceptable to us as a licence to move the current Linux Kernel
> to.
>...


Some people might wonder why kernel developers have any business
discussing the GPLv3 in their positions as kernel developers and why 
10 core kernel developers put their names on a document containing this
statement.


Isn't all this complete nonsense considering that the COPYING file in 
the kernel contains the following?

<--  snip  -->

 Also note that the only valid version of the GPL as far as the kernel
 is concerned is _this_ particular version of the license (ie v2, not
 v2.2 or v3.x or whatever), unless explicitly otherwise stated.

<--  snip  -->


Considering that the number of people that contributed to the Linux 
kernel during the last 15 years might be in the range 5.000-20.000, so 
asking all contributors to agree with a licence change from GPLv2 to 
GPLv3 (or any other license) and handling all the cases where 
contributors do not answer, are not reachable or disagree, and doing 
this in a way not creating legal issues in any jurisdiction is not a 
realistic option.


So aren't all discussions about "acceptable to us as a licence to move 
the current Linux Kernel to" silly since this is anyway not an option?


In the internal discussions there was one point that changes this 
pictures, and I would consider it highly immoral to keep it secret since 
it affects every single contributor to Linux.


Thinking about probably changing the license of the kernel makes sense 
if you believe the following "nuclear option" is a real option:

     1. It is a legally tenable and arguable position that the Linux
        kernel is a work of joint authorship whose legal citus is that
        of the USA.
     2. On this basis, a single co-author can cause the kernel to be
        relicensed.
     3. To be legally sound, such a co-author would have to be either a
        current major subsystem maintainer or a demonstrated contributor
        of a significant proportion of code of the kernel.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

