Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264290AbUBKMRU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 07:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264310AbUBKMRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 07:17:19 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:46006 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264290AbUBKMRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 07:17:15 -0500
Date: Wed, 11 Feb 2004 13:10:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: Matt Domsch <Matt_Domsch@Dell.com>, Stuart_Hayes@Dell.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH (for 2.6.3-rc1) for cdrom driver dvd_read_struct
Message-ID: <20040211121050.GC19047@suse.de>
References: <CE41BFEF2481C246A8DE0D2B4DBACF4F020E5F21@ausx2kmpc106.aus.amer.dell.com> <20040210122715.A31834@lists.us.dell.com> <20040210182631.A21504@mail.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210182631.A21504@mail.kroptech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10 2004, Adam Kropelin wrote:
> On Tue, Feb 10, 2004 at 12:27:15PM -0600, Matt Domsch wrote:
> > On Tue, Feb 10, 2004 at 12:06:03PM -0600, Stuart_Hayes@Dell.com wrote:
> > > 
> > > At risk of sounding stupid, how can a user space program check the type of
> > > media (DVD vs. CD) that's in the drive?  I think that's what magicdev is
> > > trying to do.
> > > Thanks
> > > Stuart
> > 
> > 
> > Stuart, FYI, more linux-kernel ettiquite.
> > 
> > People much prefer to see a quoting style as above (date, from line,
> > inline >-delimited note you're quoting, followed by non->-delimited
> > text.  (Such as this).  Outlook doesn't do this very well, as it
> > always wants to put your response at the top of the message, but with
> > cut-n-paste you can make the messages look more like what l-k expects.
> 
> I find OE-QuoteFix and Outlook-QuoteFix do a nice job of making
> Outlook Express and Outlook, respectively, more standards compliant in
> this regard. In addition to fixing up the message quoting syntax to what
> Matt described, they also cleanly handle line wraps. In short, they make
> life much easier for those of us tied to Windows boxes at the office.
> 
> OE-QuoteFix:
> http://home.in.tum.de/~jain/software/oe-quotefix/
> 
> Outlook-QuoteFix:
> http://flash.to/outlook-quotefix/

Maybe it would be a good idea to have this info added to the FAQ, for
those unfortunately individuals that cannot easily switch to a decent
mua?

-- 
Jens Axboe

