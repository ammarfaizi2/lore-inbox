Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267189AbTAaOFz>; Fri, 31 Jan 2003 09:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbTAaOFz>; Fri, 31 Jan 2003 09:05:55 -0500
Received: from mail021.syd.optusnet.com.au ([210.49.20.161]:44001 "EHLO
	mail021.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S267189AbTAaOFt> convert rfc822-to-8bit; Fri, 31 Jan 2003 09:05:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: [BENCHMARK] ext3, reiser, jfs, xfs effect on contest
Date: Sat, 1 Feb 2003 01:15:06 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200302010020.34119.conman@kolivas.net> <200302010040.49141.conman@kolivas.net> <3E3A8077.9050409@namesys.com>
In-Reply-To: <3E3A8077.9050409@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302010115.06955.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 Feb 2003 12:56 am, Hans Reiser wrote:
> Try running with the -E option for gcc, it might be less CPU intensive,
> and thus a better FS benchmark.
>
> What do you think?

To be honest I have no idea. I'm not trying to find the filesystem with the 
greatest throughput, but which utilises the least resources while maintaining 
throughput. Perhaps we're looking for different things, but I'm open to any 
suggestions; but they'll have to wait for my waking hours, and for others' 
comments. These benchmarks are run manually for every stage as they are way 
out of the scope of the design of contest and therefore time consuming.
