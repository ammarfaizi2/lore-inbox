Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTHUE5H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 00:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbTHUE4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 00:56:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:36338 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262437AbTHUE42
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 00:56:28 -0400
Message-ID: <3F4450F7.4020102@mvista.com>
Date: Wed, 20 Aug 2003 21:56:23 -0700
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Larson <plars@linuxtestproject.org>
CC: lkml <linux-kernel@vger.kernel.org>,
       ltp-results <ltp-results@lists.sourceforge.net>, linstab@osdl.org
Subject: Re: LTP nightly regression results for	2.6.0-test3-bk2,bk3,bk5,bk6,bk7,mm3,mjb1
References: <1061415052.3909.1733.camel@plars>
In-Reply-To: <1061415052.3909.1733.camel@plars>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Larson wrote:
> 
> Here's the latest batch of LTP test results for the latest 2.6 bk
> snapshots and mm/mjb trees.  These results and previous results are
> archived at: http://developer.osdl.org/dev/ltp/results/
> 
> Thanks,
> Paul Larson

Ok, so suppose I want to tackle one (or more) of these.  Where do I
find the sources for the test.  And if I find the test in error, what
do I do?


> 
> 2.6.0-test3-bk1-vs-2.6.0-test3-bk2
> http://developer.osdl.org/dev/ltp/results/2.6.0-test3-bk1-vs-2.6.0-test3-bk2/
> Test Name      2.6.0-test3-bk1    2.6.0-test3-bk2     Regression  Improvement
> -----------------------------------------------------------------------------
> alarm03        FAIL               FAIL                    N            N
> getgroups03    FAIL               FAIL                    N            N
> nanosleep02    FAIL               FAIL                    N            N
> setegid01      FAIL               PASS                    N            Y
> swapoff01      FAIL               FAIL                    N            N
> swapoff02      FAIL               FAIL                    N            N

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml


