Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVCGFqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVCGFqY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 00:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVCGFqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 00:46:24 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:2821 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261633AbVCGFqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 00:46:20 -0500
Date: Mon, 7 Mar 2005 06:46:15 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ben Greear <greearb@candelatech.com>,
       Christian Schmid <webmaster@rapidforum.com>,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
Message-ID: <20050307054615.GA31475@alpha.home.local>
References: <4229E805.3050105@rapidforum.com> <422BAAC6.6040705@candelatech.com> <422BB548.1020906@rapidforum.com> <422BC303.9060907@candelatech.com> <422BE33D.5080904@yahoo.com.au> <20050307053032.GA30052@alpha.home.local> <422BE96E.9040006@yahoo.com.au> <422BE9B2.2080604@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422BE9B2.2080604@yahoo.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 04:42:10PM +1100, Nick Piggin wrote:
> Nick Piggin wrote:
> >Willy Tarreau wrote:
> 
> 
> >>thousands of sockets). I never had enough time to investigate more, so I
> >>went back to 2.4.
> >>
> >
> >I have heard other complaints about this, and they are definitely
> >related to the scheduler (not saying yours is, but it is very possible).
> >
> 
> Oh, and if you could dig this thing up too, that might be
> good: someone else may have time to investigate more.

I would love to, since my major concern with 2.6 has always been the
scheduler (but that's not to you that I will learn this). At the moment,
I really don't have time for this, I promised that I would send a full
reproducible report, but it takes a lot of time.

Cheers,
Willy

