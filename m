Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVGCPDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVGCPDs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 11:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVGCPDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 11:03:48 -0400
Received: from ns1.suse.de ([195.135.220.2]:21391 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261448AbVGCPDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 11:03:46 -0400
Date: Sun, 3 Jul 2005 17:03:44 +0200
From: Andi Kleen <ak@suse.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ISA DMA suspend for x86_64
Message-ID: <20050703150344.GL21330@wotan.suse.de>
References: <42C3A698.9020404@drzeus.cx.suse.lists.linux.kernel> <1120130926.6482.83.camel@localhost.localdomain.suse.lists.linux.kernel> <42C3E3A4.3090305@drzeus.cx.suse.lists.linux.kernel> <42C432BB.407@drzeus.cx.suse.lists.linux.kernel> <p73u0jeg5lg.fsf@verdi.suse.de> <42C6CF40.4040308@drzeus.cx> <20050702174055.GI21330@wotan.suse.de> <42C6D3D5.6070909@drzeus.cx> <20050702182749.GJ21330@wotan.suse.de> <42C70F81.4010500@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C70F81.4010500@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2005 at 12:04:49AM +0200, Pierre Ossman wrote:
> Andi Kleen wrote:
> 
> >>Like this?
> >>    
> >>
> >
> >You still need to add it to the obj-ys
> >
> >  
> >
> 
> Ah, sorry. Not quite familiar with how the kernel's build system works.
> Is it more correct this time? =)

Yes, looks good now.  Thanks.

But I can't apply it before the i386 part didn't go in.

-Andi
