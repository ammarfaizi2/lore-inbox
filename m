Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWF3Bld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWF3Bld (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 21:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWF3Bld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 21:41:33 -0400
Received: from [141.84.69.5] ([141.84.69.5]:19475 "HELO mailout.stusta.mhn.de")
	by vger.kernel.org with SMTP id S932067AbWF3Blc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 21:41:32 -0400
Date: Fri, 30 Jun 2006 03:40:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
Message-ID: <20060630014050.GI19712@stusta.de>
References: <20060629192121.GC19712@stusta.de> <1151628246.22380.58.camel@mindpipe> <20060629180706.64a58f95.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629180706.64a58f95.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 06:07:06PM -0700, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > On Thu, 2006-06-29 at 21:21 +0200, Adrian Bunk wrote:
> > > This patch was already sent on:
> > > - 26 Jun 2006
> > > - 27 Apr 2006
> > > - 19 Apr 2006
> > > - 11 Apr 2006
> > > - 10 Mar 2006
> > > - 29 Jan 2006
> > > - 21 Jan 2006 
> > 
> > 3 days ago?  That seems a bit silly.  Why didn't you just ping Andrew on
> > it?
> > 
> > Andrew, what's the status of this?  Can we get an ACK or a NACK before
> > this starts getting reposted every day? ;-)
> 
> I am stolidly letting the arch maintainers and the developer of this
> feature work out what to do.

Andrea is proud of getting a patent for the server part [1], so I doubt 
he would be happy with no longer having the client part defaulting to Y...

It might sound a bit strange that although Alan Cox and Linus Torvalds 
even wrote an open letter to the President of the European Parliament
calling "Software patents are also the utmost threat to the development 
of Linux and other free software products" [2]...

One bonus point for people arguing in favor of software patents - even 
Linux actively supports patented services.

cu
Adrian

[1] http://www.cpushare.com/legal
[2] http://www.effi.org/patentit/patents_torvalds_cox.txt

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

