Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbTBJJ4L>; Mon, 10 Feb 2003 04:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbTBJJ4L>; Mon, 10 Feb 2003 04:56:11 -0500
Received: from packet.digeo.com ([12.110.80.53]:11995 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264844AbTBJJ4L>;
	Mon, 10 Feb 2003 04:56:11 -0500
Date: Mon, 10 Feb 2003 02:06:02 -0800
From: Andrew Morton <akpm@digeo.com>
To: Hans Reiser <reiser@namesys.com>
Cc: andrea@suse.de, piggin@cyberone.com.au, jakob@unthought.net,
       david.lang@digitalinsight.com, riel@conectiva.com.br,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK]
 2.4.20-ck3 / aa / rmap with contest]
Message-Id: <20030210020602.0ff7d3f5.akpm@digeo.com>
In-Reply-To: <3E477802.8070008@namesys.com>
References: <Pine.LNX.4.50L.0302100211570.12742-100000@imladris.surriel.com>
	<Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com>
	<20030209203343.06608eb3.akpm@digeo.com>
	<20030210045107.GD1109@unthought.net>
	<3E473172.3060407@cyberone.com.au>
	<20030210073614.GJ31401@dualathlon.random>
	<3E47579A.4000700@cyberone.com.au>
	<20030210080858.GM31401@dualathlon.random>
	<20030210001921.3a0a5247.akpm@digeo.com>
	<3E477802.8070008@namesys.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2003 10:05:49.0097 (UTC) FILETIME=[FC714990:01C2D0EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
>
> reiser4 does directory readahead.  It gets a lot of gain from it. 

What is "a lot"?
