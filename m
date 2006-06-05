Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751048AbWFEMiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWFEMiP (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 08:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWFEMiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 08:38:15 -0400
Received: from havoc.gtf.org ([69.61.125.42]:23973 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751048AbWFEMiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 08:38:14 -0400
Date: Mon, 5 Jun 2006 08:33:04 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linville@tuxdriver.com
Subject: Re: wireless (was Re: 2.6.18 -mm merge plans)
Message-ID: <20060605123304.GA6066@havoc.gtf.org>
References: <20060604135011.decdc7c9.akpm@osdl.org> <20060605010636.GB17361@havoc.gtf.org> <20060605085451.GA26766@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605085451.GA26766@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 09:54:51AM +0100, Christoph Hellwig wrote:
> On Sun, Jun 04, 2006 at 09:06:36PM -0400, Jeff Garzik wrote:
> > On Sun, Jun 04, 2006 at 01:50:11PM -0700, Andrew Morton wrote:
> > > acx1xx-wireless-driver.patch
> > > fix-tiacx-on-alpha.patch
> > > tiacx-fix-attribute-packed-warnings.patch
> > > tiacx-pci-build-fix.patch
> > > tiacx-ia64-fix.patch
> > > 
> > >   It is about time we did something with this large and presumably useful
> > >   wireless driver.
> > 
> > I've never had technical objections to merging this, just AFAIK it had a
> > highly questionable origin, namely being reverse-engineered in a
> > non-clean-room environment that might leave Linux legally vulnerable.
> 
> As are at leasdt a fourth of linux drivers.  Andrew, please just go ahead

Hardly.  The -vast majority- of drivers I've dealt with in my time
hacking the kernel are either blessed by the vendor, or are of
unquestionably legal origin.

It's a good thing I pay attention to this issue, too, Mr. Just Go Ahead
And Merge It.


> Please don't let this reverse engineering idiocy hinder wireless driver
> adoption, we're already falling far behind openbsd who are very successfull
> reverse engineering lots of wireless chipsets.

Thanks for your highly professional, legal opinion :)

	Jeff



