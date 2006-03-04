Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWCDRxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWCDRxv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 12:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWCDRxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 12:53:51 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29971 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932263AbWCDRxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 12:53:50 -0500
Date: Sat, 4 Mar 2006 18:53:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Richard Knutsson <ricknu-0@student.ltu.se>,
       Benoit Boissinot <benoit.boissinot@ens-lyon.fr>, p_gortmaker@yahoo.com
Subject: Re: [PATCH 04/13] RTC subsystem, class
Message-ID: <20060304175349.GL9295@stusta.de>
References: <20060304164247.963655000@towertech.it> <20060304164248.740384000@towertech.it> <20060304170810.GE9295@stusta.de> <20060304184611.784fd939@inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060304184611.784fd939@inspiron>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2006 at 06:46:11PM +0100, Alessandro Zummo wrote:
> On Sat, 4 Mar 2006 18:08:10 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > > +REAL TIME CLOCK (RTC) SUBSYSTEM
> > > +P:	Alessandro Zummo
> > > +M:	a.zummo@towertech.it
> > > +L:	linux-kernel@vger.kernel.org
> > > +S:	Maintained
> > > +
> > >...
> > 
> > The entry above the one you are adding is:
> > 
> > REAL TIME CLOCK DRIVER
> > P:      Paul Gortmaker
> > M:      p_gortmaker@yahoo.com
> > L:      linux-kernel@vger.kernel.org
> > S:      Maintained
> > 
> > 
> > Two entries for the same thing only cause confusion.
> 
>  It is not the same thing. Paul's one is the standard rtc
>  driver, which has not yet replaced by the rtc class.

My wording wasn't good:
Two entries that sound as if they were for the same thing only cause 
confusion.

The problem is that MAINTAINERS is written for people sending patches or 
bug reports and the difference between these two entries is very subtle.

>  Best regards,
>  Alessandro Zummo,

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

