Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946498AbWKACew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946498AbWKACew (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 21:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946509AbWKACew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 21:34:52 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:30227 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1946498AbWKACev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 21:34:51 -0500
Date: Wed, 1 Nov 2006 03:34:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ernst Herzberg <earny@net4u.de>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: 2.6.19-rc[1-4]: boot fail with (lapic && on_battery)
Message-ID: <20061101023450.GD27968@stusta.de>
References: <200610312227.54617.list-lkml@net4u.de> <20061101010406.GA27968@stusta.de> <200611010305.33990.earny@net4u.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611010305.33990.earny@net4u.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 03:05:33AM +0100, Ernst Herzberg wrote:
> On Wednesday 01 November 2006 02:04, Adrian Bunk wrote:
> 
> > @Ingo:
> > Any ideas?
> >
> >
> > @Ernst:
> > Thanks for your report.
> > What model is your laptop?
> 
> It's a Thinkpad R50p

Does anyone own a Thinkpad 2.6.19-rc did not break?  ;-)

We have a (most likely unrelated) problem after resume reported by 
owners of three different Thinkpad models.

> > Unless someone is able to spot the problem from your bug report, please
> > do the following process of git bisecting for finding what broke it:
> > ....
> > After at about 12 reboots, ...
> 
> Will try, if i get a little spare time ;-)

Thanks a lot!

> Thanks,

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

