Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVBJCx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVBJCx6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 21:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVBJCx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 21:53:57 -0500
Received: from ozlabs.org ([203.10.76.45]:31412 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261954AbVBJCxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 21:53:39 -0500
Date: Thu, 10 Feb 2005 13:53:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: orinoco-devel@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [0/8] orinoco driver updates
Message-ID: <20050210025333.GE5324@localhost.localdomain>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	orinoco-devel@lists.sourceforge.net, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <20050112052352.GA30426@localhost.localdomain> <4200316F.7030401@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4200316F.7030401@pobox.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 08:48:31PM -0500, Jeff Garzik wrote:
> David Gibson wrote:
> >Following are a bunch of patches which make a few more steps towards
> >the long overdue merge of the CVS orinoco driver into mainline.  These
> >do make behavioural changes to the driver, but they should all be
> >trivial and largely cosmetic.
> 
> OK, the changes look good, but I was waiting for the previous stuff you 
> submitted to land in upstream.
> 
> Could I convince you to rediff and resend against the latest 2.6.x snapshot?
> 
> At the time you sent these, they conflicted with a previous cleanup you 
> had sent, and that I had applied.

Ok, I'm a little confused.  The last batch were all checked against
the then-current netdev-2.6 bk tree, or was the conflict with
something you'd applied between when I pulled the tree and you looked
at the patches?  As far as I can tell all the previous batch of
patches I sent you are in netdev (plus a couple from this batch), but
most are still not in upstream.

I'm now not entirely clear on whether you want patches against the
netdev bk, or against Linus bk/snapshots.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
