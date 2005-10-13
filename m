Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbVJMWrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbVJMWrX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 18:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbVJMWrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 18:47:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:39301 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964874AbVJMWrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 18:47:22 -0400
Date: Thu, 13 Oct 2005 15:46:52 -0700
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@osdl.org>
Cc: kernel-stuff@comcast.net, stable@kernel.org, linux-kernel@vger.kernel.org,
       Christian Krause <chkr@plauener.de>
Subject: Re: [stable] Re: [PATCH] Re: bug in handling of highspeed usb HID devices
Message-ID: <20051013224652.GC3266@kroah.com>
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
> 
> This all looks fine.  But two things, please send -stable patches to
> stable@kernel.org, and I've not seen an ACK from any usb developers.

I haven't seen a patch even _sent_ in a format that it could be applied
in (please read Documentation/SubmittingPatches.)

thanks,

greg k-h
