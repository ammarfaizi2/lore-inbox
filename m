Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbUL2CG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbUL2CG4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 21:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbUL2CGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 21:06:55 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:9482 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261299AbUL2CGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 21:06:52 -0500
Message-ID: <41D2120E.8030008@conectiva.com.br>
Date: Wed, 29 Dec 2004 00:10:22 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Organization: Conectiva S.A.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Networking Team <netdev@oss.sgi.com>,
       linux-net <linux-net@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Patch: add loglevel to printk's in net/ipv4/route.c
References: <Pine.LNX.4.61.0412290256000.3528@dragon.hygekrogen.localhost> <41D2104D.3010406@conectiva.com.br> <Pine.LNX.4.61.0412290312540.3528@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.61.0412290312540.3528@dragon.hygekrogen.localhost>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jesper Juhl wrote:
> On Wed, 29 Dec 2004, Arnaldo Carvalho de Melo wrote:
> 
> 
>>Jesper Juhl wrote:
>>
>>>Small patch below adds loglevels to a few printk's in net/ipv4/route.c
>>>
> 
> [...]
> 
>>Are you sure the output is much improved? ;)
>>
> 
> It doesn't make much difference, it's mostly for completeness/correctness.

No, it does a helluva difference, give it a try :-)

- Arnaldo
