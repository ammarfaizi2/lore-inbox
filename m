Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVFWBCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVFWBCJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 21:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbVFWBCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:02:07 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:59037 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261944AbVFWBAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:00:13 -0400
Date: Wed, 22 Jun 2005 17:59:11 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Karim Yaghmour <karim@opersys.com>
cc: Ingo Molnar <mingo@elte.hu>, Bill Huey <bhuey@lnxw.com>,
       Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
In-Reply-To: <42BA069D.20208@opersys.com>
Message-ID: <Pine.LNX.4.62.0506221753010.16773@qynat.qvtvafvgr.pbz>
References: <1119287612.6863.1.camel@localhost> <20050620183115.GA27028@nietzsche.lynx.com>
 <42B98B20.7020304@opersys.com> <20050622192927.GA13817@nietzsche.lynx.com>
 <20050622200554.GA16119@elte.hu> <42B9CC98.1040402@opersys.com>
 <20050622220428.GA28906@elte.hu> <42B9F673.4040100@opersys.com>
 <20050623000607.GB11486@elte.hu> <42BA069D.20208@opersys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What sort of hardware would you need for the three boxes to run these 
tests?

I understand that Karim doesn't have time to keep running these tests, but 
I'm wondering if others would be able to scrape up surplus hardware and 
setup the test config, accepting configs/kernels from a couple people to 
test.

I know that I have a large number of slow (<200MHz) pentiums that are just 
sitting around at home and could be used for this, but I don't know if 
they would be considered fast enough for any portions of this test (I have 
a much smaller number of faster machines that could possibly be used)

even if none of the big-name testing facilities want to do this we should 
be able to get something setup.

David Lang


-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
