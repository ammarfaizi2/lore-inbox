Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbUKCMNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbUKCMNK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 07:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUKCMNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 07:13:09 -0500
Received: from gprs214-124.eurotel.cz ([160.218.214.124]:52608 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261565AbUKCMNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 07:13:07 -0500
Date: Wed, 3 Nov 2004 13:10:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrea Arcangeli <andrea@novell.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: PG_zero
Message-ID: <20041103121025.GA1132@elf.ucw.cz>
References: <20041030141059.GA16861@dualathlon.random> <418671AA.6020307@yahoo.com.au> <161650000.1099332236@flay> <20041101223419.GG3571@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041101223419.GG3571@dualathlon.random>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Yeah, we got bugger-all benefit out of it. The only think it might do
> > is lower the latency on inital load-spikes, but basically you end up

Is not the lower latency on load-spikes pretty nice for the user? If
openoffice loads faster or something like that, it might be worth it.

Desktop systems *are* idle most of the time..
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
