Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTLAUuI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 15:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbTLAUuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 15:50:07 -0500
Received: from havoc.gtf.org ([63.247.75.124]:40683 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263205AbTLAUuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 15:50:04 -0500
Date: Mon, 1 Dec 2003 15:50:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Bradley Chapman <kakadu_croc@yahoo.com>
Cc: Jeff Garzik <jeff@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Clean up older Kernels
Message-ID: <20031201205001.GA14720@gtf.org>
References: <20031201203246.99655.qmail@web40907.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031201203246.99655.qmail@web40907.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 01, 2003 at 12:32:46PM -0800, Bradley Chapman wrote:
> Mr. Garzik,
> 
> > > On Mon, Dec 01, 2003 at 08:40:47PM +0100, Thomas Babut wrote:
> > > Hi,
> > >
> > > perhaps my question is unusual, but why do you not clean up the older Linux
> > > Kernels?
> > >
> > > The Kernel 2.0.39 is the last stable one, but there is also a 2.0.40-rc6. So
> > > why not releasing it as stable 2.0.40 (final)? And Alan Cox isn't active any
> > > more for some time and the ac-Patches are very old. They could be removed,
> > > or not?
> >
> > 2.0.x has a maintainer, David Winehall(sp?) IIRC. Poke him... :)
> >
> > I agree, might as well put out 2.0.40...
> 
> I've been wondering about this too, but I was afraid to ask first :-)
> 
> When 2.6 is officially released as a stable kernel and 2.4 is relegated to security/
> bugfix-only status, what will happen to 2.0 and 2.2? Obviously, they won't be
> totally ignored for support reasons (not everyone uses 2.4 - see counter.li.org),
> but what will Mr. Anvin do to the frontpage of kernel.org?

I don't see there being any radical change...  Alan still puts out 2.2
security fixes occasionally, and the older Linux kernels will _always_
be archived on ftp.kernel.org.  They're not going away... :)

	Jeff



