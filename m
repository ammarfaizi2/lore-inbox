Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbUKJIty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbUKJIty (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 03:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbUKJIty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 03:49:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:57054 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261496AbUKJIto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 03:49:44 -0500
Date: Wed, 10 Nov 2004 09:49:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Larry McVoy <lm@work.bitmover.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Larry McVoy <lm@bitmover.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: bk-commits: diff -p?
Message-ID: <20041110084908.GG5602@suse.de>
References: <Pine.LNX.4.61.0411080940310.27771@anakin> <20041108164302.GA489@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108164302.GA489@work.bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08 2004, Larry McVoy wrote:
> This has been fixed in the following releases:
> 
> bk-3.2.3
> bk-3.2.2c
> bk-3.2.2b
> 
> Correct usage is "bk diffs -up" which will get you unified + procedural diffs.
> -p is currently a hack, it implies -u, but don't depend on that behaviour,
> a future release does this correctly and if you teach your fingers that 
> diffs -p is the same as diffs -up you'll get burned later.

Thanks! I requested this about a year ago :-)

-- 
Jens Axboe

