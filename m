Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263222AbVAFXjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263222AbVAFXjI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 18:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVAFXds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 18:33:48 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:10136 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263080AbVAFXcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 18:32:45 -0500
Date: Thu, 6 Jan 2005 15:14:45 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Weinehall <tao@debian.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>, Jens Axboe <axboe@suse.de>
Subject: Re: /sys/block vs. /sys/class/block
Message-ID: <20050106231445.GC22174@kroah.com>
References: <1103526532.5320.33.camel@gaston> <20041220224950.GA21317@kroah.com> <1103612870.21771.22.camel@gaston> <20041222153449.46da0671.sfr@canb.auug.org.au> <20041222062057.GC31513@kroah.com> <20041223063938.GA27718@khan.acc.umu.se> <1103784933.29975.6.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103784933.29975.6.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2004 at 07:55:33AM +0100, Benjamin Herrenschmidt wrote:
> 
> > > But I guess I should ask, who really cares about this, so late in the
> > > sysfs structure game?  Is /sys/block/ really a big problem for anyone?
> > > And if it is, I'd much rather someone make the required driver core
> > > changes to fix this up properly, than just put a symlink to paper over
> > > some userspace issue.
> > 
> > Maybe because *for once* it'd be nice to actually have inconsistencies
> > gotten rid of in their relative infancy instead of waiting 10 years
> > and then having to explain them as existing only for hysterical
> > raisins...
> 
> Agreed.

-ENOPATCH  :)
