Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbUCEU6S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 15:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbUCEU6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 15:58:17 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:56972 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S262701AbUCEU6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 15:58:11 -0500
Message-ID: <4048E9C0.6010707@matchmail.com>
Date: Fri, 05 Mar 2004 12:57:36 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: linux-kernel@vger.kernel.org, Jesper Dangaard Brouer <hawk@diku.dk>,
       marek cervenka <cer20um@axpsu.fpf.slu.cz>, linux-net@vger.kernel.org,
       James Morris <jmorris@intercode.com.au>
Subject: Re: [PATCH 1/2] NET: fix class reporting in TBF qdisc
References: <Pine.LNX.4.58.0403031323140.6655@ask.diku.dk> <200403050144.17622.dtor_core@ameritech.net> <200403050147.39657.dtor_core@ameritech.net> <200403050148.22964.dtor_core@ameritech.net>
In-Reply-To: <200403050148.22964.dtor_core@ameritech.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> ===================================================================
> 
> 
> ChangeSet@1.1649, 2004-03-05 01:18:18-05:00, dtor_core@ameritech.net
>   NET: TBF trailing whitespace cleanup
> 
> 
>  sch_tbf.c |   68 +++++++++++++++++++++++++++++++-------------------------------
>  1 files changed, 34 insertions(+), 34 deletions(-)
> 
> 
> ===================================================================
> 
> 
> 
> diff -Nru a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
> --- a/net/sched/sch_tbf.c	Fri Mar  5 01:26:58 2004
> +++ b/net/sched/sch_tbf.c	Fri Mar  5 01:26:58 2004
> @@ -62,7 +62,7 @@
>  
>  	Algorithm.
>  	----------
> -	
> +

That's a lot of whitespace cleanup in there too.
