Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263084AbTCTAsY>; Wed, 19 Mar 2003 19:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263128AbTCTAsY>; Wed, 19 Mar 2003 19:48:24 -0500
Received: from anumail4.anu.edu.au ([150.203.2.44]:55235 "EHLO anu.edu.au")
	by vger.kernel.org with ESMTP id <S263084AbTCTAsX>;
	Wed, 19 Mar 2003 19:48:23 -0500
Message-ID: <3E791241.3070700@cyberone.com.au>
Date: Thu, 20 Mar 2003 11:58:41 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.2.1) Gecko/20021217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] 2.5.65-mm2 with contest
References: <200303201016.54818.kernel@kolivas.org>
In-Reply-To: <200303201016.54818.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Domain: cyberone.com.au
X-Spam-Score: (-3.4)
X-Spam-Tests: EMAIL_ATTRIBUTION,IN_REP_TO,REFERENCES,SPAM_PHRASE_00_01,USER_AGENT,USER_AGENT_MOZILLA_UA,X_ACCEPT_LANG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Contest results for mm2:
>
Contest is starting to look good. Especially in
loads and lcpu.

>
>
>no_load:
>Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
>2.5.65              3   80      95.0    0.0     0.0     1.00
>2.5.65-mm1          3   79      94.9    0.0     0.0     1.00
>2.5.65-mm2          3   79      94.9    0.0     0.0     1.00
>
AS is now on par with deadline here which is nice.

[snip]

>dbench_load:
>Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
>2.5.65              3   542     14.2    9.0     62.5    6.78
>2.5.65-mm1          3   361     21.1    6.3     55.4    4.57
>2.5.65-mm2          3   437     17.4    7.7     60.6    5.53
>
I don't know if this is a good balance shift or not. Maybe not
related to AS but I'll investigate.

>
>
>Slight changes in io based loads due to the latest anticipatory scheduler 
>tweaks are evident. 
>
>Con
>
Thanks Con

