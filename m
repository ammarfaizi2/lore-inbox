Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267235AbUJFFLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267235AbUJFFLv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 01:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267263AbUJFFLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 01:11:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:43240 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267235AbUJFFLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 01:11:50 -0400
Date: Tue, 5 Oct 2004 22:09:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: kenneth.w.chen@intel.com, mingo@redhat.com, linux-kernel@vger.kernel.org,
       judith@osdl.org
Subject: Re: Default cache_hot_time value back to 10ms
Message-Id: <20041005220954.0602fba8.akpm@osdl.org>
In-Reply-To: <41637BD5.7090001@yahoo.com.au>
References: <200410060042.i960gn631637@unix-os.sc.intel.com>
	<20041005205511.7746625f.akpm@osdl.org>
	<416374D5.50200@yahoo.com.au>
	<20041005215116.3b0bd028.akpm@osdl.org>
	<41637BD5.7090001@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Any idea when 2.6.9 will be coming out?

Before -mm hits 1000 patches, I hope.

2.6.8 wasn't really super-stable and our main tool for getting the quality
is to stretch the release times, give us time to shake things out.  The
release time is largely driven by perceptions of current stability, bug
report rates, etc.

A current guess would be -rc4 later this week, 2.6.9 late next week.  We'll
see.

One way of advancing that is to get down and work on bugs in current -linus
tree, yes?

If this still doesn't seem to be working out and if 2.6.9 isn't as good as
we'd like I'll consider shutting down -mm completely once we hit -rc2 so
people have nothing else to do apart from fix bugs in, and test -linus. 
We'll see.
