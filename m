Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbUL2CUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbUL2CUh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 21:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbUL2CUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 21:20:36 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:7947 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261308AbUL2CUb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 21:20:31 -0500
Message-ID: <41D2152F.8080501@conectiva.com.br>
Date: Wed, 29 Dec 2004 00:23:43 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Organization: Conectiva S.A.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Networking Team <netdev@oss.sgi.com>,
       linux-net <linux-net@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Patch: add loglevel to printk's in net/ipv4/route.c
References: <Pine.LNX.4.61.0412290256000.3528@dragon.hygekrogen.localhost> <41D2104D.3010406@conectiva.com.br> <Pine.LNX.4.61.0412290312540.3528@dragon.hygekrogen.localhost> <41D2120E.8030008@conectiva.com.br> <20041229021256.GD29323@wohnheim.fh-wedel.de>
In-Reply-To: <20041229021256.GD29323@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jörn Engel wrote:
> On Wed, 29 December 2004 00:10:22 -0200, Arnaldo Carvalho de Melo wrote:
> 
>>>It doesn't make much difference, it's mostly for completeness/correctness.
>>
>>No, it does a helluva difference, give it a try :-)
> 
> 
> hint: look for "\n"

hint2: Or the _lack_ of "\n" 8)

- Arnaldo
