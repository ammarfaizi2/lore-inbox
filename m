Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbTE3WXu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 18:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264008AbTE3WXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 18:23:49 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:14241 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261244AbTE3WXt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 18:23:49 -0400
Message-ID: <3ED7DCF6.20206@us.ibm.com>
Date: Fri, 30 May 2003 15:36:38 -0700
From: Mingming Cao <cmm@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm2
References: <20030529012914.2c315dad.akpm@digeo.com>	<20030529042333.3dd62255.akpm@digeo.com>	<16087.47491.603116.892709@gargle.gargle.HOWL> <20030530133015.4f305808.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>>
>>Any hint on when -mm3 will be out,
> 
> 
> About ten hours hence, probably.
> 
> Welll ext3 has been a bit bumpy of course.  It's getting better, but I
> haven't yet been able to give it a 12-hour bash on the 4-way.  Last time I
> tried a circuit breaker conked; it lasted three hours but even ext3 needs
> electricity.  But three hours is very positive - it was hard testing.
> 
I run many fsx tests on mm2 on 8 way yesterday for a overnight run, 
before I saw your previous post.  Of course the tests failed with lots 
of error messages, but the good news is the system did not hang. Looking 
forward to mm3 out.


