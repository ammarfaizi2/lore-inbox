Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317055AbSEXAXZ>; Thu, 23 May 2002 20:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317056AbSEXAXY>; Thu, 23 May 2002 20:23:24 -0400
Received: from h64-251-67-69.bigpipeinc.com ([64.251.67.69]:32517 "HELO
	kelownamail.packeteer.com") by vger.kernel.org with SMTP
	id <S317055AbSEXAXX>; Thu, 23 May 2002 20:23:23 -0400
From: "Stephane Charette" <scharette@packeteer.com>
To: "Austin Gonyou" <austin@digitalroadkill.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Thu, 23 May 2002 17:23:23 -0700
Reply-To: "Stephane Charette" <scharette@packeteer.com>
X-Mailer: PMMail 2000 Standard (2.10.2010) For Windows 2000 (5.0.2195;2)
In-Reply-To: <1022193715.7292.74.camel@UberGeek>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: Recent kernel SMP scalability Benchmark/White-paper References.
Message-Id: <20020524002323Z317055-22651+51447@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 May 2002 17:41:55 -0500, Austin Gonyou wrote:

>I was looking around on google web, google groups, lkml digests,
>Intel.com, RedHat, SuSe, SGI.com, osdl.com, etc for some benchmarks of
>recent 2.4.x kernels, say 2.4.x > 16, with references to SMP scalability
>problems or successes, etc. Mainly centering around 4-way/8-way x86
>testing in terms of memory bandwidth/utilization, threading performance,
>etc. 

All I've found so far is:

http://www.usenix.org/publications/library/proceedings/als2000/full_papers/bryantscale/bryantscale.pdf

which is based on the 2.2.14-SMP -vs- 2.3.99-SMP kernels.

>I'm hoping to create a white-paper internally, and hopefully externally
>at some point, which can be maintained so others don't have to do the
>same arduous task of trying to find recent data as it pertains to said
>statistics.

If you find anything else, or get forwarded any information, please post the relevant information where possible.  There are many of us looking for benchmark information on recent 2.4.x kernels.  Seems like a few companies/projects are currently looking at the costs/benefits/risks of moving up to the new kernel.

Regards,

Stephane Charette



