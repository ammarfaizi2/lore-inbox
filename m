Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266081AbUAFGqV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 01:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266084AbUAFGqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 01:46:21 -0500
Received: from waste.org ([209.173.204.2]:25043 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266081AbUAFGqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 01:46:20 -0500
Date: Tue, 6 Jan 2004 00:46:07 -0600
From: Matt Mackall <mpm@selenic.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@fs.tum.de>
Subject: Re: 2.6.1-rc1-tiny2
Message-ID: <20040106064607.GB18208@waste.org>
References: <20040106054859.GA18208@waste.org> <3FFA56D6.6040808@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFA56D6.6040808@cyberone.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 05:33:58PM +1100, Nick Piggin wrote:
> 
> 
> Matt Mackall wrote:
> 
> >This is the fourth release of the -tiny kernel tree. The aim of this
> >tree is to collect patches that reduce kernel disk and memory
> >footprint as well as tools for working on small systems. Target users
> >are things like embedded systems, small or legacy desktop folks, and
> >handhelds.
> >
> 
> Have you considered Adrian Bunk's CPU selection rationalisation work?

Vaguely aware of it.

> The last argument I heard against it was that there is lower hanging
> fruit for size reduction. You seem to have got a lot of that.

Yes, a fair amount. Btw, what's the size differential for piggin-sched
vs mainline?

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
