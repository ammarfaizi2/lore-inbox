Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTLLVeZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 16:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbTLLVeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 16:34:24 -0500
Received: from mail.kroah.org ([65.200.24.183]:58509 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262074AbTLLVeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 16:34:16 -0500
Date: Fri, 12 Dec 2003 13:32:47 -0800
From: Greg KH <greg@kroah.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: David T Hollis <dhollis@davehollis.com>,
       "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: udev for dummies
Message-ID: <20031212213247.GB24643@kroah.com>
References: <20031211221604.GA2939@werewolf.able.es> <1071183521.5900.36.camel@dhollis-lnx.kpmg.com> <3FD92CA4.20606@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD92CA4.20606@nortelnetworks.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 09:49:08PM -0500, Chris Friesen wrote:
> David T Hollis wrote:
> >On Thu, 2003-12-11 at 17:16, J.A. Magallon wrote:
> 
> >>What am I missing / misunderstanding ?
> 
> >You may be overthinking it a bit.  I just set up udev on my box and it's
> >working quite well.  It's not really intending to completely replace
> >/dev, rather it provides a dynamic device structure based on hotplugged
> >devices.
> 
> Greg can speak to this better than I, but udev is most certainly 
> intended to completely replace /dev.  The thing is that not everything 
> exports the required information in /sys just yet.

Yes, this is true.

thanks,

greg k-h
