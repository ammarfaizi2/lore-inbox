Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264095AbTCXEb5>; Sun, 23 Mar 2003 23:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264096AbTCXEb5>; Sun, 23 Mar 2003 23:31:57 -0500
Received: from flrtn-2-m1-133.vnnyca.adelphia.net ([24.55.67.133]:27042 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S264095AbTCXEb4>;
	Sun, 23 Mar 2003 23:31:56 -0500
Message-ID: <3E7E8CD7.3060507@tmsusa.com>
Date: Sun, 23 Mar 2003 20:43:03 -0800
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: linux-kernel@vger.kernel.org,
       Netfilter-devel <netfilter-devel@lists.netfilter.org>
Subject: Re: An oops while running 2.5.65-mm2
References: <3E7A1ABF.7050402@tmsusa.com>	 <20030320122931.0d2f208f.akpm@digeo.com> <1048209554.1103.21.camel@tux.rsn.bth.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Josefsson wrote:

>This might explain the crashes I've seen in my routers but been unable
>to capture so far (and without the extra slab debugging I don't know if
>I would have been able to find it or even get a decent capture...)
>
>Patch attached that should fix the problem, not tested or even compiled.
>
>Joe, can you please please test it and report back?
>

I've been running 2.5.65-kb2 + your patch
for the past 2 days and everything is fully
functional, with no repeat of the problems
we saw before.

Nice work.

Joe

