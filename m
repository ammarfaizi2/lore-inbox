Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVCIXka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVCIXka (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVCIXkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:40:13 -0500
Received: from waste.org ([216.27.176.166]:28322 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261199AbVCIXiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:38:16 -0500
Date: Wed, 9 Mar 2005 15:38:07 -0800
From: Matt Mackall <mpm@selenic.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, chrisw@osdl.org, torvalds@osdl.org,
       akpm@osdl.org
Subject: Re: Linux 2.6.11.2
Message-ID: <20050309233807.GF3120@waste.org>
References: <20050309083923.GA20461@kroah.com> <20050309210631.GY3163@waste.org> <20050309231156.GB31064@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050309231156.GB31064@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 03:11:57PM -0800, Greg KH wrote:
> On Wed, Mar 09, 2005 at 01:06:31PM -0800, Matt Mackall wrote:
> > On Wed, Mar 09, 2005 at 12:39:23AM -0800, Greg KH wrote:
> > > And to further test this whole -stable system, I've released 2.6.11.2.
> > > It contains one patch, which is already in the -bk tree, and came from
> > > the security team (hence the lack of the longer review cycle).
> > > 
> > > It's available now in the normal kernel.org places:
> > > 	kernel.org/pub/linux/kernel/v2.6/patch-2.6.11.2.gz
> > > which is a patch against the 2.6.11.1 release.
> > 
> > Argh! @*#$&!!&! 
> > 
> > > If consensus arrives
> > > that this patch should be against the 2.6.11 tree, it will be done that
> > > way in the future.
> > 
> > Consensus arrived back when 2.6.8.1 came out.
> 
> It did?  So, what was it agreed to be?  Any pointers to that agreement?

Deltas against 2.6.x tarballs. The discussion was some large fraction
of the 2.6.8.1 announce thread. I think someone else mentioned it in
the recent renumbering thread, so I didn't feel the need to
pre-emptively whinge this time around..

> > Fixing it in the future is too #*$%* late because you've now turned it
> > into a special case.
> 
> No, I can always respin the patch, and re-release it if it's a problem.

That'd make things easier, yes.

-- 
Mathematics is the supreme nostalgia of our time.
