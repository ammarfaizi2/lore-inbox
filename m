Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272651AbTHPO6t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 10:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272977AbTHPO6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 10:58:49 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:44677 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S272651AbTHPO6s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 10:58:48 -0400
Message-ID: <3F3E46E6.4000906@softhome.net>
Date: Sat, 16 Aug 2003 16:59:50 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Newbie <john_r_newbie@hotmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OT] Re: ide drives performance issues, maybe related with buffer
 cache.
References: <l98r.7U2.5@gated-at.bofh.it>
In-Reply-To: <l98r.7U2.5@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Newbie wrote:
> 
>> RTFM , and STOP SPAMMING
> 
> 
> I've read them, see my previous posts. If you have nothing to say, 
> better stay silent.
> Ok, have a look at 2.6-test2, the same picture, slightly faster, though.
> And 2.6 by default set unmaskirq to 1.
> IO is really bursty (see post by insecure) opposite to `enemy I`.
> 

   If you are really newbie in Linux - I can advice you to try FreeBSD.
   By default FreeBSD (as of version 3.2) is much less aggressive in 
caching and buffering. I never saw Linux greedy caching/buffering 
working good - it always has some stupid edge cases when it is 
easier/faster to power-off/power-on/fsck system, rather than to get to 
console and kill offending process.
   But sure - Linux's throughput is much higher that in *BSD.
   Benchmarketing.

