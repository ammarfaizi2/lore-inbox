Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbTDCRd2 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 12:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261412AbTDCRd1 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 12:33:27 -0500
Received: from granite.he.net ([216.218.226.66]:3087 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S261390AbTDCRdZ 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 12:33:25 -0500
Date: Thu, 3 Apr 2003 09:43:43 -0800
From: Greg KH <greg@kroah.com>
To: Stacy Woods <stacyw@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Bugs sitting in the NEW state for more than 2 weeks
Message-ID: <20030403174343.GA4895@kroah.com>
References: <3E8C5851.6080200@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E8C5851.6080200@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 10:50:41AM -0500, Stacy Woods wrote:
> 
> 387  Other      Other      bugme-janitors@lists.osdl.org
> poll on usb device does not return immediatly when device is unplugged
> 
> 388  Other      Other      bugme-janitors@lists.osdl.org
> 2.5.60/ioctl on usb device returns wrong length

Any reason why these were not assigned to the USB maintainer, like the
other USB bugs have been?

thanks,

greg k-h
