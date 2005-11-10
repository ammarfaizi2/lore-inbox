Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbVKJIkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbVKJIkZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 03:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVKJIkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 03:40:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35663 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750885AbVKJIkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 03:40:25 -0500
Date: Thu, 10 Nov 2005 09:40:26 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, len.brown@intel.com, jgarzik@pobox.com,
       tony.luck@intel.com, bcollins@debian.org, scjody@modernduck.com,
       dwmw2@infradead.org, rolandd@cisco.com, davej@codemonkey.org.uk,
       shaggy@austin.ibm.com, sfrench@us.ibm.com
Subject: Re: merge status
Message-ID: <20051110084025.GW3699@suse.de>
References: <20051109133558.513facef.akpm@osdl.org> <1131573041.8541.4.camel@mulgrave> <Pine.LNX.4.64.0511091358560.4627@g5.osdl.org> <1131575124.8541.9.camel@mulgrave> <20051109150141.0bcbf9e3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109150141.0bcbf9e3.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09 2005, Andrew Morton wrote:
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> >
> > it's my contributors who drop me in it
> > by leaving their patch sets until you declare a kernel, dumping the
> > integration testing on me in whatever time window is left.
> 
> Yes, I think I'm noticing an uptick in patches as soon as a kernel is
> released.
> 
> It's a bit irritating, and is unexpected (here, at least).  I guess people
> like to hold onto their work for as long as possible so when they release
> it, it's in the best possible shape.

Sometimes I do hold on to stuff for a little while because I don't think
it's quite ready yet, but that's not because I don't want it out there.
It's more of a "I don't feel like spending 1-2 hours making and testing
a -mm version", really. And if I just send you the vanilla patch for
something I know you have to massage to get to apply, a cloud of guilt
builds up over my head. With so many patches in -mm, I don't want to put
that extra strain on you.

-- 
Jens Axboe

