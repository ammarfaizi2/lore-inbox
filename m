Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266786AbUJFFVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266786AbUJFFVd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 01:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267189AbUJFFVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 01:21:33 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:7780 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266786AbUJFFVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 01:21:31 -0400
Message-ID: <416380D7.9020306@yahoo.com.au>
Date: Wed, 06 Oct 2004 15:21:27 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: kenneth.w.chen@intel.com, mingo@redhat.com, linux-kernel@vger.kernel.org,
       judith@osdl.org
Subject: Re: Default cache_hot_time value back to 10ms
References: <200410060042.i960gn631637@unix-os.sc.intel.com>	<20041005205511.7746625f.akpm@osdl.org>	<416374D5.50200@yahoo.com.au>	<20041005215116.3b0bd028.akpm@osdl.org>	<41637BD5.7090001@yahoo.com.au> <20041005220954.0602fba8.akpm@osdl.org>
In-Reply-To: <20041005220954.0602fba8.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>Any idea when 2.6.9 will be coming out?
> 
> 
> Before -mm hits 1000 patches, I hope.
> 
> 2.6.8 wasn't really super-stable and our main tool for getting the quality
> is to stretch the release times, give us time to shake things out.  The
> release time is largely driven by perceptions of current stability, bug
> report rates, etc.
> 
> A current guess would be -rc4 later this week, 2.6.9 late next week.  We'll
> see.
> 
> One way of advancing that is to get down and work on bugs in current -linus
> tree, yes?
> 
> If this still doesn't seem to be working out and if 2.6.9 isn't as good as
> we'd like I'll consider shutting down -mm completely once we hit -rc2 so
> people have nothing else to do apart from fix bugs in, and test -linus. 
> We'll see.
> 

OK thanks for the explanation.

Any thoughts about making -rc's into -pre's, and doing real -rc's?
It would have caught the NFS bug that made 2.6.8.1, and probably
the cd burning problems... Or is Linus' patching finger just too
itchy?
