Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262611AbTCKBCK>; Mon, 10 Mar 2003 20:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262769AbTCKBCJ>; Mon, 10 Mar 2003 20:02:09 -0500
Received: from air-2.osdl.org ([65.172.181.6]:22981 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262611AbTCKBCI>;
	Mon, 10 Mar 2003 20:02:08 -0500
Subject: Re: OLS2003 Performance BOF Proposals
From: Craig Thomas <craiger@osdl.org>
To: Ruth Forester <rsf@flying-dove.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E981156C-5196-11D7-B7DA-000A95685D4E@flying-dove.com>
References: <E981156C-5196-11D7-B7DA-000A95685D4E@flying-dove.com>
Content-Type: text/plain
Organization: OSDL
Message-Id: <1047345168.25830.29.camel@bullpen.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 10 Mar 2003 17:12:48 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think both can be combined into one.  The first seems to outline
the way to run a benchmark (multiple runs, std dev, variance, etc)
and a list of micro benchmarks.  The second seems to handle the larger
performance tests such as large database loads, very long running tests,
etc.

I wonder if you can include a discussion of monitoring tools for
performance data collection as part of the first BOF?  We have found
that for 2.5 the packages report different numbers when
comparing between sysstat, vmstat, ziostat, and iostat.


On Sat, 2003-03-08 at 10:51, Ruth Forester wrote:
> Everyone,
> 
> 
> I would very much appreciate comments (even one-liners) on any
> community interest in these two OLS Performance BoF sessions.  I
> believe the topics are dissimilar and relevant enough to justify both:  
> 
> ----------------------------------------------------------------------
> 
> This BOF will include a discussion on Linux benchmark automation. We
> will discuss the features needed to provide an effective benchmark
> automation process for Linux. This will include, defining the
> configuration, input files, benchmark execution, output files, etc. 
> We will also discuss the types of benchmarks that are tailored for
> rapid execution and results analysis, for maximum development impact.
> 
> 
> PROPOSAL FOR LINUX PERFORMANCE
> 
> Linux changes occur very quickly in the open source community. There
> is a strong need to quickly collect and share performance data and
> analysis. However, there may be some instances where good, quality
> performance data collection and analysis take longer than the short
> turnaround required for maximum impact regarding newly released
> patches. We plan to discuss the most effective methodology for
> impacting Linux performance in a rapidly changing Linux open source
> community environment.
> 
> --------------------------------------------------------
> 
> Please reply immediately so we can quickly submit them to OLS? 
> 
> Thanks for your (speedy) replies! 
> 
> 
> ruth
> 
> Ruth Forester, Linux Performance LTC
> 
> <smaller>rsf@flying-dove.com
> 
> notes: rsf@us.ibm.com
> 
> IBM Linux Technology Center
> 
> Beaverton, Oregon</smaller>
-- 
Craig Thomas <craiger@osdl.org>
OSDL

