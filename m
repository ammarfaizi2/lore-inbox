Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261778AbTCLQFL>; Wed, 12 Mar 2003 11:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261779AbTCLQEk>; Wed, 12 Mar 2003 11:04:40 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:44992 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261778AbTCLQET>;
	Wed, 12 Mar 2003 11:04:19 -0500
Subject: OLS2003 Performance BOF Proposals
To: niv@us.ibm.com
Cc: linux-kernel@vger.kernel.org, ajh@linuxsymposium.org
X-Mailer: Lotus Notes Release 5.0.9  November 16, 2001
Message-ID: <OFDB9DE8C5.9E1E0DA2-ON86256CE7.00544711@rchland.ibm.com>
From: "Sandra K Johnson" <sandraja@us.ibm.com>
Date: Wed, 12 Mar 2003 10:14:15 -0600
X-MIMETrack: Serialize by Router on d27ml101/27/M/IBM(Release 5.0.11  |July 24, 2002) at
 03/12/2003 10:14:23 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nivedita,

Ruth Forester, Partha Narayanan and I are working on these proposals. I've
answered your questions below. We appreciate any additional comments or
community interest. Thanks.

> From: Nivedita Singhvi <niv@us.ibm.com>
> Date: Sat Mar 8, 2003  1:15:34 PM US/Pacific
> To: rsf@flying-dove.com, linux-kernel@vger.kernel.org
> Subject: Re:  OLS2003 Performance BOF Proposals
> Reply-To: niv@us.ibm.com
>
>> I would very much appreciate comments (even one-liners) on any
>> community interest in these two OLS Performance BoF sessions.  I
>> believe the topics are dissimilar and relevant enough to justify >>
both:
>
>> PROPOSAL FOR LINUX BENCHMARK AUTOMATION
>> This BOF will include a discussion on Linux benchmark automation. We
>> will discuss the features needed to provide an effective benchmark
>> automation process for Linux. This will include, defining the
>> configuration, input files, benchmark execution, output files, etc.
>> We  will also discuss the types of benchmarks that are tailored for
>> rapid  execution and results analysis, for maximum development >>
impact.

>> PROPOSAL FOR LINUX PERFORMANCE
>> Linux changes occur very quickly in the open source community. There
>> is  a strong need to quickly collect and share performance data and
>> analysis. However, there may be some instances where good, quality
>> performance data collection and analysis take longer than the short
>> turnaround required for maximum impact regarding newly released
>> patches. We plan to discuss the most effective methodology for
>> impacting Linux performance in a rapidly changing Linux open source
>> community environment.
>
> While the first is fairly clear on what the content might be,
> its not very clear what the second is referring to..At first
> I figured they were going to be discussing techniques like
> how to automate the benchmark process to make it faster
> (which would overlap with the first, I imagine?), but if not,
> is it going to be about which benchmarks to run etc? or how to
> avoid benchmark legalese miseries that can make them a big
> headache?? :)
>

This second proposal is for a more general discussion
on Linux performance. We do not plan to focus on
benchmark automation, etc. The plan to discuss the
tradeoffs between getting good, reliable, reproducible
performance data and the need to post performance data
regarding patches quickly. This may not be an issue for
small microbenchmarks; however, it may be an issue for
larger macrobenchmarks, that my require more than 24
hours to generate good, reliable data. We want to focus
on amenable solutions for this issue, as well as other issues.
This would include some discussion on various types of
benchmarks, but little or no discussion on benchmark restrictions.

We have revised the 2nd proposal as follows:

PROPOSAL FOR LINUX PERFORMANCE

Linux changes occur very quickly in the open source community. There
 is a strong need to quickly collect and share performance data and
 analysis. However, there may be some instances where good, quality
 performance data collection and analysis take longer than the short
 turnaround required for maximum impact regarding newly released
 patches. For example, some macro benchmarks require more than
24 hours to configure, collect, and analyze performance data. This
varies across benchmarks, and the associated targeted workloads.
Given this tradeoff between the need to quickly have performance
data for newly created patches, and the need to have good, reliable,
reproducible, data that may take time to generate and analyze, we
plan to discuss the most effective methodology for impacting Linux
performance in a rapidly changing Linux open source community
environment.

> thanks,
> Nivedita
>



Sandra K. Johnson, Ph.D.
Linux Technology Center



