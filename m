Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUL2CDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUL2CDD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 21:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbUL2CDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 21:03:03 -0500
Received: from mail.dif.dk ([193.138.115.101]:44482 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261297AbUL2CCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 21:02:51 -0500
Date: Wed, 29 Dec 2004 03:13:52 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Networking Team <netdev@oss.sgi.com>,
       linux-net <linux-net@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Patch: add loglevel to printk's in net/ipv4/route.c
In-Reply-To: <41D2104D.3010406@conectiva.com.br>
Message-ID: <Pine.LNX.4.61.0412290312540.3528@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0412290256000.3528@dragon.hygekrogen.localhost>
 <41D2104D.3010406@conectiva.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2004, Arnaldo Carvalho de Melo wrote:

> Jesper Juhl wrote:
> > Small patch below adds loglevels to a few printk's in net/ipv4/route.c
> > 
[...]
> 
> Are you sure the output is much improved? ;)
> 
It doesn't make much difference, it's mostly for completeness/correctness.


-- 
Jesper

