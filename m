Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbTA2BRR>; Tue, 28 Jan 2003 20:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbTA2BRR>; Tue, 28 Jan 2003 20:17:17 -0500
Received: from packet.digeo.com ([12.110.80.53]:13038 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261799AbTA2BRQ>;
	Tue, 28 Jan 2003 20:17:16 -0500
Message-ID: <3E372DC5.10466574@digeo.com>
Date: Tue, 28 Jan 2003 17:26:29 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Cliff White <cliffw@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [OSDL][BENCHMARK] DBT2 results question
References: <200301290115.h0T1FsI05742@es175.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jan 2003 01:26:29.0457 (UTC) FILETIME=[72E48C10:01C2C735]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cliff White wrote:
> 
> As Andrew Morton requested, we have rerun the OSDL Database Test 2 on cached
> and non-cached versions comparing 2.4.21-pre3 and 2.5.49 and this time
> we have vmstat data.
> Actually, we have a _ton of data, which is why i'm posting this.
> What data in particular are you kernel coders looking for?
> 
>  We could graph each statistic for each set of runs for a side by
> side comparison 2.4 versus 2.5.
> 
> We can also post the raw data, but 40 runs is a bit much to post on a mailing
>  list.
> 
> What would you find most useful?

Didn't you have a standardised set of number for the dbt1 runs?  They
were pretty good if I recall correctly.

It is very hard to find dbt1 results at osdl.org.  I normally have to
grep the lse-tech archives to find anything at all.

Ah yes.
http://www.osdl.org/projects/dbt1prfrns/results/2proc/linux-2.4.18-1tier/index.html

That seems a reasonable summary.

>  We will get the runs Andrew requested on 2.5.58 when we can get past the
> I/O bug Dave Olien reported last week.

That isn't fixed yet, and there's no workaround, alas.
