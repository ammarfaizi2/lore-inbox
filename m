Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbTBJNVM>; Mon, 10 Feb 2003 08:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbTBJNVL>; Mon, 10 Feb 2003 08:21:11 -0500
Received: from 3-157.ctame701-1.telepar.net.br ([200.193.161.157]:23495 "EHLO
	3-157.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S264628AbTBJNVL>; Mon, 10 Feb 2003 08:21:11 -0500
Date: Mon, 10 Feb 2003 11:30:46 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@digeo.com>
cc: Nick Piggin <piggin@cyberone.com.au>, "" <andrea@suse.de>,
       "" <reiser@namesys.com>, "" <jakob@unthought.net>,
       "" <david.lang@digitalinsight.com>, "" <ckolivas@yahoo.com.au>,
       "" <linux-kernel@vger.kernel.org>, "" <axboe@suse.de>
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK]
 2.4.20-ck3 / aa / rmap with contest]
In-Reply-To: <20030210041245.68665ff6.akpm@digeo.com>
Message-ID: <Pine.LNX.4.50L.0302101129530.12742-100000@imladris.surriel.com>
References: <3E47579A.4000700@cyberone.com.au> <20030210080858.GM31401@dualathlon.random>
 <20030210001921.3a0a5247.akpm@digeo.com> <20030210085649.GO31401@dualathlon.random>
 <20030210010937.57607249.akpm@digeo.com> <3E4779DD.7080402@namesys.com>
 <20030210101539.GS31401@dualathlon.random> <3E4781A2.8070608@cyberone.com.au>
 <20030210111017.GV31401@dualathlon.random> <3E478C09.6060508@cyberone.com.au>
 <20030210113923.GY31401@dualathlon.random> <20030210034808.7441d611.akpm@digeo.com>
 <3E4792B7.5030108@cyberone.com.au> <20030210041245.68665ff6.akpm@digeo.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2003, Andrew Morton wrote:

> Could be that sending out a request which is larger than a track is
> saving a rev of the disk for some reason.

I guess disks are optimised for the benchmarks that are
run by popular PC magazines ...

After all, those benchmarks and the sales price are the
main factors determining sales ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
