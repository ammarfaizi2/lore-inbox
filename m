Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTINGZa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 02:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbTINGZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 02:25:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:31670 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262188AbTINGZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 02:25:29 -0400
Message-Id: <200309140625.h8E6PMT24138@mail.osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Nick's scheduler policy v15 
In-Reply-To: Your message of "Sat, 13 Sep 2003 21:17:15 +1000."
             <3F62FCBB.2020807@cyberone.com.au> 
Date: Sat, 13 Sep 2003 23:25:22 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> Nick Piggin wrote:
> 
> >
> >
> > Cliff White wrote:
> >
> >>> Hi,
> >>> http://www.kerneltrap.org/~npiggin/v15/
> >>>
> >>>
> >>
> >> Here are results for several recent kernels for comparison.
> >> the sched-rollup-nopolicy tests are still running. Performance of v15 
> >> suffers as number of CPU's increase.
> >> At 8 cpu's, delta is noticeable vs stock -test5
> >> cliffw
> >>
> >
> > OK, so it hasn't crashed? Do you have the profiles up?
> 
> 
> Nevermind, I found them. It looks like its balancing way too much. I've
> a few ideas. I should be getting time on a NUMA box there at OSDL soon, 
> so I won't bother you with untested stuff. Thanks again for doing
> these.
> 
It's not a bother, my robot slaves do all the work. 
http://www.osdl.org/plm-cgi/plm

:)
cliffw

> 
