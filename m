Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284933AbRL3UtO>; Sun, 30 Dec 2001 15:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284945AbRL3UtE>; Sun, 30 Dec 2001 15:49:04 -0500
Received: from flrtn-2-m1-236.vnnyca.adelphia.net ([24.55.67.236]:48518 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S284933AbRL3Us4>;
	Sun, 30 Dec 2001 15:48:56 -0500
Message-ID: <3C2F7D49.9040606@pobox.com>
Date: Sun, 30 Dec 2001 12:47:05 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: timothy.covell@ashavan.org
CC: Stephan von Krawczynski <skraw@ithnet.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Balanced Multi Queue Scheduler ...
In-Reply-To: <200112292338.AAA29985@webserver.ithnet.com> <200112301951.fBUJoxSr011753@svr3.applink.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Covell wrote:

>Ummm, on my Dual P-III (650MHz with 524988416 Bytes), my current Seti 
>efficiency is 5.35 CpF.   That's a tad high/slower than an Ultra Sparc IIi 
>according to their stats.  So, it would appear that being SMP is hurting my 
>performance a bit.   Unless that is that you meant to run a seti instance for 
>each CPU?   And this reminds me of how "make -j3 bzlilo" is slower than
>"make -j2 bzlilo".
>
Eh?

On my 4-way ppro, make -j4 is much faster
than a simple "make" for kernel compilation.
Almost linearly so -

This is with recent 2.4.1x kernels BTW on
Red Hat 7.1/7.2

Sorry to hear of your bizzare experiences -
but then again, maybe you're running a
2.2.x kernel or something?

cu

jjs



