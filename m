Return-Path: <linux-kernel-owner+willy=40w.ods.org-S279392AbVBEEze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S279392AbVBEEze (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 23:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S279412AbVBEEzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 23:55:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:38049 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S279392AbVBEEzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 23:55:25 -0500
Date: Fri, 4 Feb 2005 20:54:57 -0800
From: Greg KH <greg@kroah.com>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net,
       David Brownell <david-b@pacbell.net>
Subject: Re: 2.6: USB disk unusable level of data corruption
Message-ID: <20050205045457.GA505@kroah.com>
References: <1107519382.1703.7.camel@localhost.localdomain> <20050204133726.7ba8944f@localhost.localdomain> <1107564013.10471.3.camel@localhost.localdomain> <20050205014413.GB31596@kroah.com> <1107570646.7049.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107570646.7049.5.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 09:30:45PM -0500, Parag Warudkar wrote:
> 
> > Does 2.6.11-rc3 have this same issue?
> > 
> > thanks,
> > 
> > greg k-h
> 
> I just compiled 2.6.11-rc3 booted and then again did a kernel compile on
> the USB disk - no problems. 

Great!

> With FC 2.6.10 kernel I am able to reproduce the problem within no time
> - seems something is seriously broken in FC3 latest kernel. 

Go file a bug in the redhat bugzilla :)

Good luck,

greg k-h
