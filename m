Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbWCWMDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWCWMDn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 07:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWCWMDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 07:03:43 -0500
Received: from theblackmoor.net ([64.191.130.90]:8889 "EHLO
	cygnus.theblackmoor.net") by vger.kernel.org with ESMTP
	id S1030240AbWCWMDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 07:03:42 -0500
Date: Thu, 23 Mar 2006 08:03:33 -0400
From: Spike <spike@spykes.net>
To: Spike <spike@spykes.net>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       ck@vds.kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: [ck] swap prefetching merge plans
Message-ID: <20060323080333.48d39108@buffy>
In-Reply-To: <20060323075756.70eced5a@buffy>
References: <20060322205305.0604f49b.akpm@osdl.org>
	<200603231804.36334.kernel@kolivas.org>
	<20060323075756.70eced5a@buffy>
X-Mailer: Sylpheed-Claws 2.0.0cvs113 (GTK+ 2.8.16; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2006 07:57:56 -0400
Spike <spike@spykes.net> wrote:

> On Thu, 23 Mar 2006 18:04:36 +1100
> Con Kolivas <kernel@kolivas.org> wrote:
> 
> > On Thu, 23 Mar 2006 03:53 pm, Andrew Morton wrote:
> > > A look at the -mm lineup for 2.6.17:
> > 
> > > mm-implement-swap-prefetching.patch
> > > mm-implement-swap-prefetching-fix.patch
> > > mm-implement-swap-prefetching-tweaks.patch
> > 
> > >   Still don't have a compelling argument for this, IMO.
> > 
> > For those users who feel they do have a compelling argument for it, please 
> > speak now or I'll end up maintaining this in -ck only forever.  I've come to 
> > depend on it with my workloads now so I'm never dropping it. There's no point 
> > me explaining how it is useful yet again, though, because I just end up 
> > looking like I'm handwaving. It seems a shame for it not to be available to 
> > all linux users.
> > 
> > Cheers,
> > Con
> > _______________________________________________
> > http://ck.kolivas.org/faqs/replying-to-mailing-list.txt
> > ck mailing list - mailto: ck@vds.kolivas.org
> > http://vds.kolivas.org/mailman/listinfo/ck
> 

I must add that if it gets merged you'd probably see every desktop
oriented Linux distro under the sun enable it in their default kernels.

Most people don't ever see the value of something until it becomes
mainline.

Bren
