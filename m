Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVFDHTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVFDHTp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 03:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVFDHTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 03:19:44 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:43133 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261279AbVFDHT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 03:19:27 -0400
Date: Sat, 4 Jun 2005 00:19:18 -0700
From: Greg KH <gregkh@suse.de>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050604071918.GB13684@suse.de>
References: <20050603232828.GA29860@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506031706450.1876@ppc970.osdl.org> <20050604013311.GA30151@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506031851220.1876@ppc970.osdl.org> <20050604063833.GA13238@suse.de> <20050604065106.GA8230@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050604065106.GA8230@colo.lackof.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2005 at 12:51:06AM -0600, Grant Grundler wrote:
> On Fri, Jun 03, 2005 at 11:38:33PM -0700, Greg KH wrote:
> > Anyone have any pointers to a simple PCI express network card?  (no, I
> > don't want a PCI express video card, although if someone wants to send
> > me one I will not complain...)
> 
> "simple"?

Well, not a 16-wide PCI-E device :)

> Well, I'm aware of bcm5708 and Michael Chan (Broadcom)
> recently posted the bnx2 driver for it. If HP has it, then others
> are likely offering it too:
> http://h18004.www1.hp.com/products/servers/networking/nc320t/index.html

Ah, nice, thanks for the pointer.

greg k-h
