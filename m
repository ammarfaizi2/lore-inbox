Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265003AbRGLOOk>; Thu, 12 Jul 2001 10:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265120AbRGLOOa>; Thu, 12 Jul 2001 10:14:30 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:63496 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S265051AbRGLOOO>; Thu, 12 Jul 2001 10:14:14 -0400
Date: Thu, 12 Jul 2001 07:14:04 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Juri Haberland <juri@koschikode.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] starfire net driver update
In-Reply-To: <20010712103424.21260.qmail@babel.spoiled.org>
Message-ID: <Pine.LNX.4.33.0107120711090.18452-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Jul 2001, Juri Haberland wrote:

> Ion Badulescu wrote:
> 
> > Actually, try this patch first. I believe it will fix your problems, but
> > I'd like to confirm it.
> 
> Yep, this worked.

Great, good to hear that. I'll send the patch to Linus shortly.

> Btw, at what log-level is the link status printed?
> I only got it via dmesg, but not in the logs. FWIW:

I'm logging them at the debug level -- which I know some distributions 
don't log by default. I'm wondering if I should increase the level to 
info or notice... probably just info though, so they are logged but not 
displayed on the console.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

