Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbUCJR3c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 12:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbUCJR3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 12:29:32 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:35343 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262724AbUCJR33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 12:29:29 -0500
Date: Wed, 10 Mar 2004 17:29:14 +0000
From: Christoph Hellwig <hch@infradead.org>
To: jt@hpl.hp.com
Cc: Christoph Hellwig <hch@infradead.org>, prism54-devel@prism54.org,
       "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Intersil Prism54 wireless driver
Message-ID: <20040310172914.A25155@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, jt@hpl.hp.com,
	prism54-devel@prism54.org, "David S. Miller" <davem@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040304023524.GA19453@bougret.hpl.hp.com> <20040310165548.A24693@infradead.org> <20040310172114.GA8867@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040310172114.GA8867@bougret.hpl.hp.com>; from jt@bougret.hpl.hp.com on Wed, Mar 10, 2004 at 09:21:14AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 09:21:14AM -0800, Jean Tourrilhes wrote:
> > --- linux-2.6.3/drivers/net/wireless/prism54/isl_wds.c	Thu Jan  1 00:00:00 1970
> > +++ linux-2.6.3-prism54/drivers/net/wireless/prism54/isl_wds.c	Thu Mar  4 02:00:01 2004
> > 
> > 	WDS doesn't belong into a driver but in higher-level code.
> 
> 	The big 802.11 reorg can only happen when HostAP is in the
> kernel.

I don't quite understand that comment.  This feature doesn't belong into
a driver.  Whether it's some day implemented in a hypothetic 802.11 midlayer
that can only be done with another driver merged is a different question,
isn't it?

> 
> 	Regards,
> 
> 	Jean
> 
---end quoted text---
