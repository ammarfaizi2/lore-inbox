Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318912AbSHSPKV>; Mon, 19 Aug 2002 11:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318914AbSHSPKV>; Mon, 19 Aug 2002 11:10:21 -0400
Received: from ns1.ionium.org ([62.27.22.2]:23820 "HELO mail.ionium.org")
	by vger.kernel.org with SMTP id <S318913AbSHSPKU> convert rfc822-to-8bit;
	Mon, 19 Aug 2002 11:10:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Justin Heesemann <jh@ionium.org>
Organization: ionium Technologies
To: linux-kernel@vger.kernel.org
Subject: Re: epox 4g4a+ (i845g and hpt372) with kernel 2.4.x: Ok, now booting the kernel. hangs.
Date: Mon, 19 Aug 2002 17:16:16 +0200
User-Agent: KMail/1.4.2
References: <200208181746.30967.jh@ionium.org>
In-Reply-To: <200208181746.30967.jh@ionium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208191716.17316.jh@ionium.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 August 2002 17:46, Justin Heesemann wrote:
>
> Loading kernel..................
> Loading
> rescue.gz..................................................................
>..... ready.
> Uncompressing Linux... Ok, now booting the kernel.
>
> Then it hangs.
> Is there a way to get more information what exactly it is doing before it
> hangs ?

Ok.. update:
I've testet some more kernels. I started with 2.4.0 which did boot, so did 
2.4.2 and 2.4.3.
With 2.4.4 it won't boot. The last message is 

Ok, now booting the kernel.

Which of the changes from 2.4.4 could cause this ?
Every other kernel higher then 2.4.4 that i tried (2.4.5, 2.4.10, 2.4.19, 
2.5.31) are having the same problem.

I am completly stuck. the ram is ok, the onboard graphic adapter seems ok too 
(trying to boot with another agp card doesnt help)

-- 
Best Regards,
Justin Heesemann

