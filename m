Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbVKURjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbVKURjA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbVKURjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:39:00 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:37926
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S932396AbVKURi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:38:59 -0500
Date: Mon, 21 Nov 2005 18:38:55 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: disable tsc with seccomp
Message-ID: <20051121173855.GI14746@opteron.random>
References: <20051105134727.GF18861@opteron.random> <200511051712.09280.ak@suse.de> <20051105163134.GC14064@opteron.random> <200511051804.08306.ak@suse.de> <20051106015542.GE14064@opteron.random> <20051121164349.GE14746@opteron.random> <20051121170517.GA20775@brahms.suse.de> <20051121171616.GH14746@opteron.random> <20051121172444.GB20775@brahms.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121172444.GB20775@brahms.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 06:24:44PM +0100, Andi Kleen wrote:
> I don't believe theoretical, unlikely to be usable in any way

Demonstrate it if you can.

The fact is that the closest thing to a demonstration that we have,
demonstrated the opposite of what you claim, so you'll have an hard
time to convince me about your point given you've no way to demonstrate
it.

I can guarantee that my machine is safe by running top, the only thing
that escapes the easy "top" check is CPUShare and I want to fix it,
since I can. 

> And in addition your change doesn't even close that channel
> in theory.

The the PCE is red herring, since it's a zero-cost addition.
