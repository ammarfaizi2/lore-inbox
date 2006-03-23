Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbWCWL6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbWCWL6P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 06:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWCWL6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 06:58:15 -0500
Received: from theblackmoor.net ([64.191.130.90]:3257 "EHLO
	cygnus.theblackmoor.net") by vger.kernel.org with ESMTP
	id S1030239AbWCWL6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 06:58:15 -0500
Date: Thu, 23 Mar 2006 07:57:56 -0400
From: Spike <spike@spykes.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, ck@vds.kolivas.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ck] swap prefetching merge plans
Message-ID: <20060323075756.70eced5a@buffy>
In-Reply-To: <200603231804.36334.kernel@kolivas.org>
References: <20060322205305.0604f49b.akpm@osdl.org>
	<200603231804.36334.kernel@kolivas.org>
X-Mailer: Sylpheed-Claws 2.0.0cvs113 (GTK+ 2.8.16; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2006 18:04:36 +1100
Con Kolivas <kernel@kolivas.org> wrote:

> On Thu, 23 Mar 2006 03:53 pm, Andrew Morton wrote:
> > A look at the -mm lineup for 2.6.17:
> 
> > mm-implement-swap-prefetching.patch
> > mm-implement-swap-prefetching-fix.patch
> > mm-implement-swap-prefetching-tweaks.patch
> 
> >   Still don't have a compelling argument for this, IMO.
> 
> For those users who feel they do have a compelling argument for it, please 
> speak now or I'll end up maintaining this in -ck only forever.  I've come to 
> depend on it with my workloads now so I'm never dropping it. There's no point 
> me explaining how it is useful yet again, though, because I just end up 
> looking like I'm handwaving. It seems a shame for it not to be available to 
> all linux users.
> 
> Cheers,
> Con
> _______________________________________________
> http://ck.kolivas.org/faqs/replying-to-mailing-list.txt
> ck mailing list - mailto: ck@vds.kolivas.org
> http://vds.kolivas.org/mailman/listinfo/ck


As a gamer it really makes wonders. That's really all I can say because
swap prefetching is such a simple logical thing that one does not need
to go into details as its been said so many times over and over again
before. Having something like this is beneficial to desktop users.

I suppose support for 1000 some odd CPU's in the kernel is really useful
as well for most people....

One can go on and on with the examples, as I seen over the years it
seems to just depend on what the few major maintainers want and not
what the public finds actually useful.

Bren
