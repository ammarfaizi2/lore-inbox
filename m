Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267753AbTBJLQD>; Mon, 10 Feb 2003 06:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267754AbTBJLQD>; Mon, 10 Feb 2003 06:16:03 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:49093 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267753AbTBJLQB>; Mon, 10 Feb 2003 06:16:01 -0500
Message-ID: <3E478C39.602@namesys.com>
Date: Mon, 10 Feb 2003 14:25:45 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@digeo.com>,
       jakob@unthought.net, david.lang@digitalinsight.com,
       riel@conectiva.com.br, ckolivas@yahoo.com.au,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3
 / aa / rmap with contest]
References: <3E473172.3060407@cyberone.com.au> <20030210073614.GJ31401@dualathlon.random> <3E47579A.4000700@cyberone.com.au> <20030210080858.GM31401@dualathlon.random> <20030210001921.3a0a5247.akpm@digeo.com> <20030210085649.GO31401@dualathlon.random> <20030210010937.57607249.akpm@digeo.com> <3E4779DD.7080402@namesys.com> <20030210101539.GS31401@dualathlon.random> <3E4781A2.8070608@cyberone.com.au> <20030210111017.GV31401@dualathlon.random>
In-Reply-To: <20030210111017.GV31401@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it true that there is no manpage available anywhere for fadvise?

For the benefit of others reading this thread, anticipatory scheduling 
is described at:

http://lwn.net/Articles/21274/



-- 
Hans


