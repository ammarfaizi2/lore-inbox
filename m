Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbVA1TQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVA1TQa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbVA1TQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:16:27 -0500
Received: from colo.lackof.org ([198.49.126.79]:50389 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S262778AbVA1TPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:15:34 -0500
Date: Fri, 28 Jan 2005 12:15:49 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Grant Grundler <grundler@parisc-linux.org>, Jesse Barnes <jbarnes@sgi.com>,
       Greg KH <greg@kroah.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <matthew@wil.cx>,
       linux-pci@atrey.karlin.mff.cuni.cz, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Patch to control VGA bus routing and active VGA device.
Message-ID: <20050128191549.GA32135@colo.lackof.org>
References: <9e47339105011719436a9e5038@mail.gmail.com> <20050125042459.GA32697@kroah.com> <9e473391050127015970e1fedc@mail.gmail.com> <200501270828.43879.jbarnes@sgi.com> <20050128173222.GC30791@colo.lackof.org> <9e47339105012810362a0a7018@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105012810362a0a7018@mail.gmail.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 01:36:48PM -0500, Jon Smirl wrote:
> > If it is intended to work with multiple IO Port address spaces,
> > then it needs to use the pci_dev->resource[] and mangle that appropriately.
> 
> Post a patch an I will incorporate it. 

Sorry - I only wanted to point out the short coming.
I don't care if it gets fixed (or not) since I don't use
or need to support multiple VGA cards. If someone else (in
HP) does, it's just nice to warn them what's broken.

thanks,
grant
