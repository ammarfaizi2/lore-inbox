Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVL3VK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVL3VK7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 16:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVL3VK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 16:10:59 -0500
Received: from melos.informatik.uni-rostock.de ([139.30.241.22]:21771 "EHLO
	melos.informatik.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1750725AbVL3VK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 16:10:59 -0500
From: Denny Priebe <spamtrap@siglost.org>
Date: Fri, 30 Dec 2005 22:10:41 +0100
To: Greg KH <greg@kroah.com>
Cc: aab@cichlid.com, linux-kernel@vger.kernel.org
Subject: Re: Repeated USB disconnect and reconnect with Wacom Intuos3 6x11 tablet
Message-ID: <20051230211041.GA30356@nostromo.dyndns.info>
References: <20051213184600.GA4283@nostromo.dyndns.info> <20051213193832.GA14047@kroah.com> <20051215144254.GA19794@nostromo.dyndns.info> <20051215163122.GC14512@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215163122.GC14512@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 08:31:22AM -0800, Greg KH wrote with possible deletions:

> > What confuses me a bit is that theses USB disconnects do not appear
> > as soon as I read what the tablet provides.

> So I really think that this is an electronic issue, sorry.  Can you
> return this device and get a replacement one?

My second device behaves the same way. Since today I know of another user 
who can confirm these disconnects with his Intuos3.


Andrew Burgess wrote:

> It's possible that this is a 'feature' of the device firmware. [...]
> When the device notices that it has user input that isn't being read
> it disconnects and reconnects to get the OS's attention. So it might be a
> workaround for a buggy driver or windows itself?

So it seems that Andrew's theory is right. It's a feature.

Thanks to all who have replied.

Regards,
Denny
