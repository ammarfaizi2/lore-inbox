Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272573AbTHFVbu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 17:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272071AbTHFV3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 17:29:39 -0400
Received: from [81.193.98.149] ([81.193.98.149]:21890 "HELO
	puma-vgertech.no-ip.com") by vger.kernel.org with SMTP
	id S271751AbTHFV31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 17:29:27 -0400
Message-ID: <3F3173D5.8000705@toxyn.org>
Date: Wed, 06 Aug 2003 22:32:05 +0100
From: RaTao <ratao@toxyn.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.0-test2-mm4 O_DIRECT
References: <3F30CFC1.1090205@toxyn.org> <20030806121759.50a48626.akpm@osdl.org>
In-Reply-To: <20030806121759.50a48626.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

I've correct my (don't know how) misspelled subject :)

Andrew Morton wrote:

[..snip..]
> 
> 
> It works OK here.
> 
> 
>>- vmstat doesn't show bi/bo for O_DIRECT's disk access.
> 
> 
> It does here.
> 

Maybe goofed somewhere. I can't test it again today, I'll do it tomorrow.


> 
> I'd be suspecting your test app: is it checking the return value of all
> syscalls?

I'll double check.
Thanks,

Ratao



