Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267855AbTBJMVj>; Mon, 10 Feb 2003 07:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267839AbTBJMVi>; Mon, 10 Feb 2003 07:21:38 -0500
Received: from [195.223.140.107] ([195.223.140.107]:33922 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267855AbTBJMUu>;
	Mon, 10 Feb 2003 07:20:50 -0500
Date: Mon, 10 Feb 2003 13:30:06 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@digeo.com>, reiser@namesys.com, jakob@unthought.net,
       david.lang@digitalinsight.com, riel@conectiva.com.br,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210123006.GK31401@dualathlon.random>
References: <3E4779DD.7080402@namesys.com> <20030210101539.GS31401@dualathlon.random> <3E4781A2.8070608@cyberone.com.au> <20030210111017.GV31401@dualathlon.random> <3E478C09.6060508@cyberone.com.au> <20030210113923.GY31401@dualathlon.random> <20030210034808.7441d611.akpm@digeo.com> <3E4792B7.5030108@cyberone.com.au> <20030210041245.68665ff6.akpm@digeo.com> <3E479AA1.3050308@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E479AA1.3050308@cyberone.com.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 11:27:13PM +1100, Nick Piggin wrote:
> Is there a magic number above which you see the improvement,
> Andrea? Or does it steadily climb?

I recall more than 512k wasn't worthwhile anymore

Andrea
