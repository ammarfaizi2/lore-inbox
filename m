Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVJNSKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVJNSKH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 14:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVJNSKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 14:10:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:33963 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750820AbVJNSKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 14:10:06 -0400
Date: Fri, 14 Oct 2005 11:09:23 -0700
From: Greg KH <greg@kroah.com>
To: Christian Krause <chkr@plauener.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Chris Wright <chrisw@osdl.org>,
       Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: [PATCH] Re: bug in handling of highspeed usb HID devices
Message-ID: <20051014180923.GA17179@kroah.com>
References: <m34q7mwlvv.fsf@gondor.middle-earth.priv> <20051013224839.GA3583@kroah.com> <m3ek6o2d7q.fsf@gondor.middle-earth.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3ek6o2d7q.fsf@gondor.middle-earth.priv>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2005 at 07:57:45PM +0200, Christian Krause wrote:
> Hi Greg,
> 
> On Thu, 13 Oct 2005 15:48:39 -0700, Greg KH wrote:
> > On Wed, Oct 12, 2005 at 09:55:32PM +0200, Christian Krause wrote:
> >> Here is a small patch which solves the whole problem:
> 
> > The patch is at the wrong level, and has spaces instead of tabs.
> > And no "signed-off-by" line :(
> > Take a look at Documentation/SubmittingPatches for how to create a patch
> > that I can apply and forward on.
> 
> Please apologize the wrong format of the patch, here is the next
> try. I also include the description why the change is necessary again:

You forgot a Signed-off-by: in the patch description.  Anything below
the patch is thrown away by our scripts.

Care to try it again?  Third time's a charm :)

thanks,

greg k-h
