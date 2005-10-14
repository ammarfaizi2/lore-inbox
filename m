Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbVJNRO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVJNRO3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 13:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVJNRO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 13:14:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:28310 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750803AbVJNRO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 13:14:29 -0400
Date: Fri, 14 Oct 2005 10:13:26 -0700
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@osdl.org>
Cc: kernel-stuff@comcast.net, stable@kernel.org, linux-kernel@vger.kernel.org,
       Christian Krause <chkr@plauener.de>
Subject: Re: [stable] Re: [PATCH] Re: bug in handling of highspeed usb HID devices
Message-ID: <20051014171326.GA16496@kroah.com>
References: <101320051953.12930.434EBB460007F30B0000328222007589429D0E050B9A9D0E99@comcast.net> <20051013212518.GY5856@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051013212518.GY5856@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2005 at 02:25:18PM -0700, Chris Wright wrote:
> * kernel-stuff@comcast.net (kernel-stuff@comcast.net) wrote:
> > This seems to be -stable material since it's a clear cut bug with bad
> > consequences. 
> > 
> > Chris Wright - is the below patch acceptable for -stable?

Also, I don't think this should go into -stable, as there are no
high-speed HID devices available right now, so it really isn't affecting
anyone :)

thanks,

greg k-h
