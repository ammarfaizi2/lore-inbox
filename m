Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbUFQUaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUFQUaW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 16:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbUFQUaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 16:30:22 -0400
Received: from verein.lst.de ([212.34.189.10]:26756 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262756AbUFQUaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 16:30:09 -0400
Date: Thu, 17 Jun 2004 22:30:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@lst.de>, "Adam J. Richter" <adam@yggdrasil.com>,
       linux-kernel@vger.kernel.org
Subject: Re: more files with licenses that aren't GPL-compatible
Message-ID: <20040617203005.GA31776@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, Greg KH <greg@kroah.com>,
	"Adam J. Richter" <adam@yggdrasil.com>,
	linux-kernel@vger.kernel.org
References: <200406180629.i5I6Ttn04674@freya.yggdrasil.com> <20040617180507.GA18134@kroah.com> <20040617195458.GA31338@lst.de> <20040617202207.GB23533@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617202207.GB23533@kroah.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 01:22:08PM -0700, Greg KH wrote:
> > WAKE UP!
> > 
> > We have files in the kernel we can't distribute.
> 
> I do not agree with that statement.  Those files were placed in the
> kernel tree in good faith that they could be redistributed.  I have the
> email trails to prove it.  If the wording is somehow not correct to
> convey this intent, I will be quite willing to fix it.

You can't fix it.  Talk to keyspan and get it a 2clause BSD or GPL
header and the problem is solved.

> > Do Adam & me need to ask the vendors and mirrors to take the kernel
> > tarball down first before you react?
> 
> Again, I am reacting to the emi26 image.  The keyspan dispute I do not
> agree with.  We are free to disagree with each other here, but until I
> receive a contrary legal opinion, I will insist that these files remain.

Read through the license, especially:

--
Permission is hereby granted for the distribution of this firmware 
image as part of a Linux or other Open Source operating system kernel 
in text or binary form as required. 
--

"as part of the linux kerrnel" is a violation of the GPL, because I
can't use it in my kernel fork, or hurd if they ever get usb support.
Also note that it doesn't mention modification at all.  There's no
way you can legally link it into a GPL'ed program.  I don't know what
you're IP lawyer are smoking, but I could count a few laywers I've
talked to that are active in the Free Software and Creative Commons
world that absolutely disagree with you.  What you say is basically
the GPL is void and works under it are placed in the public domain.

Got a paycheck from SCO recently?

