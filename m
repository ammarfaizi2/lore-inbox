Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267865AbUG3WWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267865AbUG3WWS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 18:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267864AbUG3WWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 18:22:17 -0400
Received: from elvis.franken.de ([193.175.24.41]:1981 "EHLO elvis.franken.de")
	by vger.kernel.org with ESMTP id S267862AbUG3WUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 18:20:34 -0400
Date: Sat, 31 Jul 2004 00:18:19 +0200
To: Matthew Wilcox <willy@debian.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: Exposing ROM's though sysfs
Message-ID: <20040730221819.GA24473@solo.franken.de>
References: <20040730181205.GW10025@parcelfarce.linux.theplanet.co.uk> <20040730185921.99631.qmail@web14929.mail.yahoo.com> <20040730190456.GZ10025@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730190456.GZ10025@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
From: tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 08:04:56PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 30, 2004 at 11:59:21AM -0700, Jon Smirl wrote:
> > Alan Cox knows more about this, but I believe there is only one PCI
> > card in existence that does this.
> 
> Strange; he was the one who pointed out this requirement to me in the
> first place and he hinted that many devices did this.

Just to name an example I know, HP Visualize EG or FXe (can't remember
which one right now) PCI cards, have this sort of restriction ...

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                 [ Alexander Viro on linux-kernel ]
