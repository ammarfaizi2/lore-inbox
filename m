Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261723AbTAIHPh>; Thu, 9 Jan 2003 02:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261732AbTAIHPh>; Thu, 9 Jan 2003 02:15:37 -0500
Received: from tapu.f00f.org ([202.49.232.129]:29409 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S261723AbTAIHPh>;
	Thu, 9 Jan 2003 02:15:37 -0500
Date: Wed, 8 Jan 2003 23:24:18 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.55
Message-ID: <20030109072418.GA19265@tapu.f00f.org>
References: <Pine.LNX.4.44.0301082033410.1438-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301082033410.1438-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 08:35:45PM -0800, Linus Torvalds wrote:

> <joe@fib011235813.fsnet.co.uk>:
>   o dm: Don't let the ioctl interface drop a suspended device
>   o dm: Correct clone info initialisation
>   o dm: Correct target_type reference counting
>   o dm: rwlock_t -> rw_semaphore (fluff)
>   o dm: Call dm_put_target_type() *after* calling the destructor
>   o dm: Remove explicit returns from void fns (fluff)
>   o dm: printk tgt->error if dm_table_add_target() fails
>   o dm: Simplify error->map
>   o dm: Export dm_table_get_mode()
>   o dm: Remove redundant error checking

FWIW, I *really* like it when people are able to prefix these
summaries as they send patches... I make reading the log more
pleasant.



  --cw
