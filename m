Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264161AbTDOE0z (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 00:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264168AbTDOE0z (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 00:26:55 -0400
Received: from granite.he.net ([216.218.226.66]:54532 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264161AbTDOE0y (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 00:26:54 -0400
Date: Mon, 14 Apr 2003 21:41:06 -0700
From: Greg KH <greg@kroah.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Miquel van Smoorenburg'" <miquels@cistron-office.nl>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Simple Kernel-User Event Interface (Was: RE: [ANNOUNCE] udev 0.1 release)
Message-ID: <20030415044106.GB8403@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 12, 2003 at 01:52:38AM -0700, Perez-Gonzalez, Inaky wrote:
> > Looks like a good start, but I'm not moving the hotplug interface over
> > to it :)
> 
> Good try - I won't let go :) If you see this as something potentially
> useful, how would you like it to develop so that in the long term 
> it can be used? be it in parallel with /sbin/hotplug or as a 
> potential replacement?

I don't know.  Even if we decide to change, this is a 2.7 thing.

> I guess that the first thing I would have to do is somehow look into
> how hotplug is behaving now and hook it to do something similar, right?

That would be a good start :)

thanks,

greg k-h
