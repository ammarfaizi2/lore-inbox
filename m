Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbTA2BDJ>; Tue, 28 Jan 2003 20:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261847AbTA2BDJ>; Tue, 28 Jan 2003 20:03:09 -0500
Received: from air-2.osdl.org ([65.172.181.6]:1963 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261624AbTA2BDI>;
	Tue, 28 Jan 2003 20:03:08 -0500
Message-Id: <200301290115.h0T1FsI05742@es175.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: [OSDL][BENCHMARK] DBT2 results question
Date: Tue, 28 Jan 2003 17:15:54 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As Andrew Morton requested, we have rerun the OSDL Database Test 2 on cached
and non-cached versions comparing 2.4.21-pre3 and 2.5.49 and this time
we have vmstat data. 
Actually, we have a _ton of data, which is why i'm posting this.
What data in particular are you kernel coders looking for?

 We could graph each statistic for each set of runs for a side by
side comparison 2.4 versus 2.5.

We can also post the raw data, but 40 runs is a bit much to post on a mailing
 list. 

What would you find most useful?

 We will get the runs Andrew requested on 2.5.58 when we can get past the
I/O bug Dave Olien reported last week.

cliffw


