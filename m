Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVFDGrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVFDGrr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 02:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVFDGrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 02:47:47 -0400
Received: from colo.lackof.org ([198.49.126.79]:55005 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261267AbVFDGri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 02:47:38 -0400
Date: Sat, 4 Jun 2005 00:51:06 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050604065106.GA8230@colo.lackof.org>
References: <20050603232828.GA29860@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506031706450.1876@ppc970.osdl.org> <20050604013311.GA30151@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506031851220.1876@ppc970.osdl.org> <20050604063833.GA13238@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050604063833.GA13238@suse.de>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 11:38:33PM -0700, Greg KH wrote:
> Anyone have any pointers to a simple PCI express network card?  (no, I
> don't want a PCI express video card, although if someone wants to send
> me one I will not complain...)

"simple"? Well, I'm aware of bcm5708 and Michael Chan (Broadcom)
recently posted the bnx2 driver for it. If HP has it, then others
are likely offering it too:
http://h18004.www1.hp.com/products/servers/networking/nc320t/index.html

hth,
grant
