Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269531AbTGJRgJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 13:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269533AbTGJRgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 13:36:09 -0400
Received: from storm.he.net ([64.71.150.66]:42927 "HELO storm.he.net")
	by vger.kernel.org with SMTP id S269531AbTGJRgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 13:36:04 -0400
Date: Thu, 10 Jul 2003 10:50:45 -0700
From: Greg KH <greg@kroah.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: John Wong <kernel@implode.net>, linux-kernel@vger.kernel.org
Subject: Re: USB stops working with any of 2.4.22-pre's after 2.4.21
Message-ID: <20030710175045.GA12533@kroah.com>
References: <20030710065801.GA351@gambit.implode.net> <20030710170217.GA12098@kroah.com> <200307101335.34266.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307101335.34266.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 01:35:34PM -0400, Gene Heskett wrote:
> And my ability to use it, while never great due to config problems on 
> the other end of the cable, seems now to have gone away.  There has 
> also been some pretty heavy lightning activity in the area, during 
> which time it may have been hooked up, and something blown from the 
> EMP of a nearby strike.  I usually leave it unplugged on the seriel 
> side because of that.
> 
> Does this look normal?  ISTR it used to ID itself all the time, not 
> just in dmesg.

What does /proc/bus/usb/devices show for this device?

thanks,

greg k-h
