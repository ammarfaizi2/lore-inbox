Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbSKYSQv>; Mon, 25 Nov 2002 13:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbSKYSQv>; Mon, 25 Nov 2002 13:16:51 -0500
Received: from [195.223.140.107] ([195.223.140.107]:11680 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S261836AbSKYSQu>;
	Mon, 25 Nov 2002 13:16:50 -0500
Date: Mon, 25 Nov 2002 19:23:55 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Con Kolivas <conman@kolivas.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.4.20-rc2-aa1 with contest
Message-ID: <20021125182355.GE9623@dualathlon.random>
References: <200211230929.31413.conman@kolivas.net> <20021124162845.GC12212@dualathlon.random> <200211251744.35509.conman@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211251744.35509.conman@kolivas.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2002 at 05:44:30PM +1100, Con Kolivas wrote:
> will kill it when it finishes testing in that load. To reproduce it
> yourself, run mem_load then do a kernel compile make -j(4xnum_cpus).

I will try.

> If that doesnt do it I'm not sure how else you can see it. sys-rq-T
> shows too much stuff on screen for me to make any sense of it and
> scrolls away without me being able to scroll up.

you can use as usual a serial or netconsole to log the sysrq+t output.

Andrea
