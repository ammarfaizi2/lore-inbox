Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbTDCS6D 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 13:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263468AbTDCS6D 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 13:58:03 -0500
Received: from granite.he.net ([216.218.226.66]:23304 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263467AbTDCS5y 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 13:57:54 -0500
Date: Thu, 3 Apr 2003 11:10:35 -0800
From: Greg KH <greg@kroah.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Stacy Woods <stacyw@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bugs sitting in the NEW state for more than 2 weeks
Message-ID: <20030403191035.GA5445@kroah.com>
References: <3E8C5851.6080200@us.ibm.com> <20030403174343.GA4895@kroah.com> <1950000.1049395076@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1950000.1049395076@flay>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 10:37:56AM -0800, Martin J. Bligh wrote:
> >> 387  Other      Other      bugme-janitors@lists.osdl.org
> >> poll on usb device does not return immediatly when device is unplugged
> >> 
> >> 388  Other      Other      bugme-janitors@lists.osdl.org
> >> 2.5.60/ioctl on usb device returns wrong length
> > 
> > Any reason why these were not assigned to the USB maintainer, like the
> > other USB bugs have been?
> 
> Looks like someone just filed them under the wrong category ....
> I can move them and reassign if you like?

I took care of them.

thanks,

greg k-h
