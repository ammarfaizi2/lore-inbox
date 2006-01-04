Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbWADBDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbWADBDE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 20:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWADBDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 20:03:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45586 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965077AbWADBDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 20:03:03 -0500
Date: Wed, 4 Jan 2006 02:03:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: kyungmin.park@samsung.com, dwmw2@infradead.org,
       linux-mtd@lists.infradead.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: drivers/mtd/onenand/: unacceptable stack usage
Message-ID: <20060104010302.GL3831@stusta.de>
References: <20051216005505.GW23349@stusta.de> <0IRK00I50JP6FZ@mmp1.samsung.com> <20060103165437.2311cfc1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060103165437.2311cfc1.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 04:54:37PM -0800, Andrew Morton wrote:
> Kyungmin Park <kyungmin.park@samsung.com> wrote:
> >
> >  OK. I change the source code. 
> >  It is working well on OMAP H4 with 2.6.15-rc4 kernel and LTP fs test is
> >  passed.
> > 
> >  And please apply the recent onenand patch
> > 
> >  	- check correct manufacturer 
> >  	- unlock problem in DDP (Double Density Package)
> >  	- add platform_device.h instead of device.h
> > 
> >  Thank you
> 
> These patches are wordwrapped and cannot be applied.
> 
> You've included three separate patches in the body of a single email. 
> Please don't do that.  One patch per email is preferred.
> 
> So please redo these patches against 2.6.15 and resend them, as per
> http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt, thanks.

???

The patches are already included in 2.6.15.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

