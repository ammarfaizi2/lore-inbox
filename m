Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbUL2CNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbUL2CNt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 21:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbUL2CNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 21:13:49 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:22721 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261295AbUL2CNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 21:13:40 -0500
Date: Wed, 29 Dec 2004 03:12:56 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Networking Team <netdev@oss.sgi.com>,
       linux-net <linux-net@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Patch: add loglevel to printk's in net/ipv4/route.c
Message-ID: <20041229021256.GD29323@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.61.0412290256000.3528@dragon.hygekrogen.localhost> <41D2104D.3010406@conectiva.com.br> <Pine.LNX.4.61.0412290312540.3528@dragon.hygekrogen.localhost> <41D2120E.8030008@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41D2120E.8030008@conectiva.com.br>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 December 2004 00:10:22 -0200, Arnaldo Carvalho de Melo wrote:
> >
> >It doesn't make much difference, it's mostly for completeness/correctness.
> 
> No, it does a helluva difference, give it a try :-)

hint: look for "\n"

Jörn

-- 
It is better to die of hunger having lived without grief and fear,
than to live with a troubled spirit amid abundance.
-- Epictetus
