Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267804AbTBJMYh>; Mon, 10 Feb 2003 07:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267811AbTBJMYh>; Mon, 10 Feb 2003 07:24:37 -0500
Received: from dial-ctb04112.webone.com.au ([210.9.244.112]:40199 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S267804AbTBJMYc>;
	Mon, 10 Feb 2003 07:24:32 -0500
Message-ID: <3E479C43.4050206@cyberone.com.au>
Date: Mon, 10 Feb 2003 23:34:11 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Andrew Morton <akpm@digeo.com>, reiser@namesys.com, jakob@unthought.net,
       david.lang@digitalinsight.com, riel@conectiva.com.br,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3
 / aa / rmap with contest]
References: <3E4779DD.7080402@namesys.com> <20030210101539.GS31401@dualathlon.random> <3E4781A2.8070608@cyberone.com.au> <20030210111017.GV31401@dualathlon.random> <3E478C09.6060508@cyberone.com.au> <20030210113923.GY31401@dualathlon.random> <20030210034808.7441d611.akpm@digeo.com> <3E4792B7.5030108@cyberone.com.au> <20030210041245.68665ff6.akpm@digeo.com> <3E479AA1.3050308@cyberone.com.au> <20030210123006.GK31401@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>On Mon, Feb 10, 2003 at 11:27:13PM +1100, Nick Piggin wrote:
>
>>Is there a magic number above which you see the improvement,
>>Andrea? Or does it steadily climb?
>>
>
>I recall more than 512k wasn't worthwhile anymore
>
Behaviour between 128 and 512 would be interesting then

