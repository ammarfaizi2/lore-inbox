Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263409AbTCNRYp>; Fri, 14 Mar 2003 12:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263410AbTCNRYp>; Fri, 14 Mar 2003 12:24:45 -0500
Received: from magic-mail.adaptec.com ([208.236.45.100]:10116 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S263409AbTCNRYo>; Fri, 14 Mar 2003 12:24:44 -0500
Date: Fri, 14 Mar 2003 10:34:06 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Terry Barnaby <terry@beam.ltd.uk>
cc: mmadore@aslab.com, linux-kernel@vger.kernel.org
Subject: Re: Reproducible SCSI Error with Adaptec 7902
Message-ID: <525730000.1047663245@aslan.btc.adaptec.com>
In-Reply-To: <3E71F9CB.706@beam.ltd.uk>
References: <3E71B629.60204@beam.ltd.uk> <1999490000.1047653585@aslan.scsiguy.com> <3E71F9CB.706@beam.ltd.uk>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Justin,
> 
> Thanks for the info.
> We were using these drivers as:
> 
> 1. The 1.0.0 driver is as used in the Stock Redhat 7.3 release (updated
> 	to current updates).

Unfortunately, providing updates to Redhat even in a timely manner has
no impact on whether or not these udpates are incorporated into recent
releases.

> 2. The 1.1.0 driver is on the Adaptec web site for Linux and is I 		 believe the one shipped on there CDROM for the on-board 7902
> 	controller.

Getting website updates is a slow and painful process at Adaptec.
I've been working on this for some time, but have not yet had any
success.  That is why I distribute the most recent drivers from
a location I can control.

> We were not aware of a later driver.
> For future reference, where should we go to find the latest drivers
> for any device for the linux 2.4.x kernel ?

That would depend on the device.  For Adaptec aic7xxx and aic79xx drivers,
you can use the site I provided.

> Do you know if the latest driver at
> http://people.FreeBSD.org/~gibbs/linux/RPM/aic79xx/ might fix
> this problem ?

I don't know enough about your problem to be able to say.  There have
been lots of fixes to these drivers over their lifetime, so upgrading
is a good first step.

--
Justin

