Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263089AbUFQUyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbUFQUyl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 16:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUFQUyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 16:54:40 -0400
Received: from mail.kroah.org ([65.200.24.183]:44996 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263089AbUFQUyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 16:54:15 -0400
Date: Thu, 17 Jun 2004 13:52:48 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@lst.de>, "Adam J. Richter" <adam@yggdrasil.com>,
       linux-kernel@vger.kernel.org
Subject: Re: more files with licenses that aren't GPL-compatible
Message-ID: <20040617205248.GA3138@kroah.com>
References: <200406180629.i5I6Ttn04674@freya.yggdrasil.com> <20040617180507.GA18134@kroah.com> <20040617195458.GA31338@lst.de> <20040617202207.GB23533@kroah.com> <20040617203005.GA31776@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617203005.GA31776@lst.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 10:30:05PM +0200, Christoph Hellwig wrote:
> On Thu, Jun 17, 2004 at 01:22:08PM -0700, Greg KH wrote:
> > > WAKE UP!
> > > 
> > > We have files in the kernel we can't distribute.
> > 
> > I do not agree with that statement.  Those files were placed in the
> > kernel tree in good faith that they could be redistributed.  I have the
> > email trails to prove it.  If the wording is somehow not correct to
> > convey this intent, I will be quite willing to fix it.
> 
> You can't fix it.  Talk to keyspan and get it a 2clause BSD or GPL
> header and the problem is solved.

I don't believe that is necessary.

> > > Do Adam & me need to ask the vendors and mirrors to take the kernel
> > > tarball down first before you react?
> > 
> > Again, I am reacting to the emi26 image.  The keyspan dispute I do not
> > agree with.  We are free to disagree with each other here, but until I
> > receive a contrary legal opinion, I will insist that these files remain.
> 
> Read through the license, especially:
> 
> --
> Permission is hereby granted for the distribution of this firmware 
> image as part of a Linux or other Open Source operating system kernel 
> in text or binary form as required. 
> --
> 
> "as part of the linux kerrnel" is a violation of the GPL, because I
> can't use it in my kernel fork, or hurd if they ever get usb support.

"other Open Source operating system kernel" does allow this.

Remember, the point here is that this is code that does not run on the
same processor that Linux runs on.  It is a blob that we copy down to
the other processor on the device.

> Also note that it doesn't mention modification at all.

Because there's nothing here you can modify.

> There's no way you can legally link it into a GPL'ed program.

I see we disagree on this point, and that's fine.

> I don't know what you're IP lawyer are smoking, but I could count a
> few laywers I've talked to that are active in the Free Software and
> Creative Commons world that absolutely disagree with you.  What you
> say is basically the GPL is void and works under it are placed in the
> public domain.

Again, I am not saying that at all, never did.  My position stands until
either Linus changes his mind about the issue, or a lawyer that I trust
tells me otherwise.  As you are neither, I accept the fact that we will
disagree on this.

> Got a paycheck from SCO recently?

And the reason you attack me personally for this is why?

I get a paycheck from the company SCO has brought to court, as everyone
here well knows.

thanks,

greg k-h
