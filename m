Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbSJSBTO>; Fri, 18 Oct 2002 21:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265447AbSJSBTO>; Fri, 18 Oct 2002 21:19:14 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:30480 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265446AbSJSBTN>; Fri, 18 Oct 2002 21:19:13 -0400
Date: Sat, 19 Oct 2002 03:25:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Srihari Vijayaraghavan <harisri@bigpond.com>
Cc: linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
Subject: Re: 2.4.20pre11aa1
Message-ID: <20021019012516.GB23930@dualathlon.random>
References: <20021018145204.GG23930@dualathlon.random> <29723.1034955246@ocs3.intra.ocs.com.au> <20021018160031.GI23930@dualathlon.random> <200210191121.20062.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210191121.20062.harisri@bigpond.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 11:21:19AM +1000, Srihari Vijayaraghavan wrote:
> I may be wrong but considering in my case the kernel is crashing whether 
> agpgart/radeon are compiled as modules or built-in, I suspect that this issue 
> is larger than just modules sub-system.

agreed. the oops in modprobe sounds more like a coincidence now.

> Anyway I will start applying the patches from 00* on-wards from your tree to 
> see if I can reliably prove where the problem is.

that will help a lot, thanks!

Andrea
