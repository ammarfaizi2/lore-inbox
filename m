Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbTIQGrM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 02:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbTIQGrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 02:47:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:29318 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262683AbTIQGrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 02:47:11 -0400
Date: Tue, 16 Sep 2003 23:47:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] must fix list
Message-Id: <20030916234746.0612ec90.akpm@osdl.org>
In-Reply-To: <3F67EDAF.40608@cyberone.com.au>
References: <3F67EDAF.40608@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
>  I don't know what happened to this, but I thought it was quite good.
>  Maybe I missed something?

It just didn't seem very relevant: people weren't keeping me up to date and
a lot of the patches which were going in weren't related to anything on the
lists.

>  Anyway I have removed AS from the list because it is done. I removed CFQ
>  as well because when the schedulers become runtime selectable (sometime
>  I hope), merging it becomes a non issue, even during the stable series I
>  think.
> 
>  I updated the kernel/sched.c section a bit.
> 
>  I moved 64-bit dev_t from should fix to must fix.
> 
>  It looks like quite a bit can be struck off, but I'll leave it up to those
>  who actually did the work.

Thanks.  Just for you, I'll do an update.

>  Maybe these should go in Documentation/must-fix/ to make patching and
>  syncing easier?

maybe...
