Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266132AbRGLPtn>; Thu, 12 Jul 2001 11:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266150AbRGLPtd>; Thu, 12 Jul 2001 11:49:33 -0400
Received: from babel.spoiled.org ([212.84.234.227]:4663 "HELO
	babel.spoiled.org") by vger.kernel.org with SMTP id <S266132AbRGLPtY>;
	Thu, 12 Jul 2001 11:49:24 -0400
Date: 12 Jul 2001 15:49:09 -0000
Message-ID: <20010712154909.8460.qmail@babel.spoiled.org>
From: Juri Haberland <juri@koschikode.com>
To: ionut@cs.columbia.edu (Ion Badulescu)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] starfire net driver update
X-Newsgroups: spoiled.linux.kernel
In-Reply-To: <Pine.LNX.4.33.0107120711090.18452-100000@age.cs.columbia.edu>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (OpenBSD/2.9 (i386))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:

> On 12 Jul 2001, Juri Haberland wrote:
> 
>> Btw, at what log-level is the link status printed?
>> I only got it via dmesg, but not in the logs. FWIW:
> 
> I'm logging them at the debug level -- which I know some distributions 
> don't log by default. I'm wondering if I should increase the level to 
> info or notice... probably just info though, so they are logged but not 
> displayed on the console.

Yes, info would be good.

Thanks a lot,
Juri

-- 
Juri Haberland  <juri@koschikode.com> 

