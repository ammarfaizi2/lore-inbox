Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbTD3OAj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 10:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbTD3OAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 10:00:39 -0400
Received: from havoc.daloft.com ([64.213.145.173]:45525 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261921AbTD3OAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 10:00:38 -0400
Date: Wed, 30 Apr 2003 10:12:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Marc Zyngier <mzyngier@freesurf.fr>, rth@twiddle.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] DMA mapping API for Alpha
Message-ID: <20030430141258.GA25076@gtf.org>
References: <20030429150532.A3984@jurassic.park.msu.ru> <Pine.GSO.3.96.1030430140450.1016E-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030430140450.1016E-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 02:07:17PM +0200, Maciej W. Rozycki wrote:
> On Tue, 29 Apr 2003, Ivan Kokshaysky wrote:
> 
> > Since the Jensen is the only non-PCI alpha, I'd really prefer to
> > keep existing pci_* functions as is and make dma_* ones just
> > wrappers.
> 
>  Note that's the only non-PCI Alpha we support right now -- there may be
> more such ones in the future. 

Highly unlikely, I would guess :)

	Jeff



