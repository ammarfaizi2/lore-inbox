Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbVI2FoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVI2FoP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 01:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVI2FoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 01:44:15 -0400
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:21517
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S1751155AbVI2FoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 01:44:14 -0400
Date: Wed, 28 Sep 2005 22:30:58 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "David S. Miller" <davem@davemloft.net>
cc: jgarzik@pobox.com, willy@w.ods.org, luben_tuikov@adaptec.com,
       patmans@us.ibm.com, ltuikov@yahoo.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org, linux-scsi@vger.kernel.org
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
In-Reply-To: <20050928.162929.50617923.davem@davemloft.net>
Message-ID: <Pine.LNX.4.10.10509282223570.19896-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dave,

Was it really necessary to this far and rude?

I heard the snow is falling and there is a fresh shipment of hash headed
out to the slopes, don't be late.

Not sure who to credit the following to:

When TOE's were introduced to Linux, there was a violent rejection of this
hardware because Linux is superior in the NetStack than any other possible
NetStack every created.

The point is there is a known history in Linux to reject things which
steps on peoples' egos.

Have a great ski trip.

Cheers,

Andre

On Wed, 28 Sep 2005, David S. Miller wrote:

> From: Jeff Garzik <jgarzik@pobox.com>
> Date: Wed, 28 Sep 2005 19:22:53 -0400
> 
> > Both Luben and his predecessor, Justin Gibbs, were severely dissatisfied 
> > with the SCSI core.  Often they have raised valid issues that need 
> > addressing, but their choice has been to work around or ignore existing 
> > code (and maintainers), rather than work with it, and fix it.
> 
> I'm in violent agreement here.
> 
> Justin was just as anti-social of an engineer as one could get.  And,
> when you put an ex-FreeBSD guy onto Linux driver maintainence, what in
> the world could anyone expect. :-)
> 
> For example, instead of accepting that the symbol "current" is a
> reserved symbol when compiling under the Linux kernel, he decided that
> "sticking a square peg into a round hole" was a better way to deal
> with this, and thus he put an "#undef current" into the adaptec driver
> instead of simply renaming a structure member from "current" to
> something else.
> 
> I don't know how else to define "control freak".
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

