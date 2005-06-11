Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVFKTZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVFKTZm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 15:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVFKTZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 15:25:42 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26374 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261789AbVFKTZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 15:25:34 -0400
Date: Sat, 11 Jun 2005 21:25:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Greg Stark <gsstark@mit.edu>
Cc: Jens Axboe <axboe@suse.de>, Mark Lord <liml@rtr.ca>,
       linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: SMART support for libata
Message-ID: <20050611192531.GG3770@stusta.de>
References: <87y8g8r4y6.fsf@stark.xeocode.com> <41B7EFA3.8000007@pobox.com> <87br6g6ayr.fsf@stark.xeocode.com> <42A73E6E.80808@rtr.ca> <873brs5ir8.fsf@stark.xeocode.com> <42A85F5E.10208@rtr.ca> <87u0k74cuy.fsf@stark.xeocode.com> <20050610063858.GN5140@suse.de> <87oeae4433.fsf@stark.xeocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87oeae4433.fsf@stark.xeocode.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 11:35:44AM -0400, Greg Stark wrote:
> Jens Axboe <axboe@suse.de> writes:
> 
> > > > Greg Stark wrote:
> > > 
> > > What I should *really* be using is the noflushd daemon. That's been on hold
> > > since I found it didn't work with SATA drives. But I wonder if it would work
> > > these days.
> > 
> > noflushd is ancient, have you tried playing with laptop mode?
> 
> Where do I find more about this?

Documentation/laptop-mode.txt

> greg

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

