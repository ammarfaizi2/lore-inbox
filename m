Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262450AbSKRNjD>; Mon, 18 Nov 2002 08:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262472AbSKRNjD>; Mon, 18 Nov 2002 08:39:03 -0500
Received: from news.cistron.nl ([62.216.30.38]:31763 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S262450AbSKRNi6>;
	Mon, 18 Nov 2002 08:38:58 -0500
From: Rene Blokland <reneb@orac.aais.org>
Subject: Re: 2.5.48 Compilation Failure skbuff.c
Date: Mon, 18 Nov 2002 14:37:43 +0100
Organization: Cistron
Message-ID: <slrnathr97.hqm.reneb@orac.aais.org>
References: <slrnathnn0.aas.reneb@orac.aais.org> <20021118101230.N1407@almesberger.net>
Reply-To: reneb@cistron.nl
X-Trace: ncc1701.cistron.net 1037627158 30604 195.64.94.30 (18 Nov 2002 13:45:58 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021118101230.N1407@almesberger.net>, Werner Almesberger wrote:
> Rene Blokland wrote:
>> include/linux/crypto.h: In function `crypto_tfm_alg_modname':
>> include/linux/crypto.h:202: dereferencing pointer to incomplete type
> [...]
>> Any comments?
> 
> Disabling modules should work around this. Alternatively, you can
> try the untested patch below. I also had to disable devfs to build
> 2.4.58.
> 
Hi Werner a long time ago (a) :-)
I have modules disabled already. 


-- 
Groeten / Regards, Rene J. Blokland

