Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263123AbTHVNLg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 09:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbTHVNLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 09:11:36 -0400
Received: from dyn-ctb-210-9-245-150.webone.com.au ([210.9.245.150]:19974 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S263277AbTHVNJD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 09:09:03 -0400
Message-ID: <3F4615D8.9030200@cyberone.com.au>
Date: Fri, 22 Aug 2003 23:08:40 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] new scheduler policy
References: <3F4182FD.3040900@cyberone.com.au> <20030822085508.GA10215@k3.hellgate.ch>
In-Reply-To: <20030822085508.GA10215@k3.hellgate.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Roger Luethi wrote:

>On Tue, 19 Aug 2003 11:53:01 +1000, Nick Piggin wrote:
>  
>
>>I haven't run many tests on it - my mind blanked when I tried to
>>remember the scores of scheduler "exploits" thrown around. So if
>>anyone would like to suggest some, or better still, run some,
>>please do so. And be nice, this isn't my type of scheduler :P
>>    
>>
>
>I timed a pathological benchmark from hell I've been playing with lately.
>Three consecutive runs following a fresh boot. Time is in seconds:
>
>2.4.21			821	21	25
>2.6.0-test3-mm1		724	946	896
>2.6.0-test3-mm1-nick	905	987	997
>
>Runtime with ideal scheduling: < 2 seconds (we're thrashing).
>  
>

Cool. Can you post the benchmark source please?


