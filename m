Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316256AbSEKSna>; Sat, 11 May 2002 14:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316257AbSEKSn3>; Sat, 11 May 2002 14:43:29 -0400
Received: from ns1.system-techniques.com ([199.33.245.254]:10393 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S316256AbSEKSn3>; Sat, 11 May 2002 14:43:29 -0400
Date: Sat, 11 May 2002 14:43:13 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14
 IDE 56)
In-Reply-To: <Pine.LNX.4.44.0205111130080.879-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0205111441190.10170-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Linus ,

On Sat, 11 May 2002, Linus Torvalds wrote:
... Large snip ...
> And I personally believe that "generate the data yourself" is actually a
> very common case. A pure pipe between two places is not what a computer is
> good at, or what a computer should be used for.
	Hmmm ,  (This may not apply here  But ...)
	What about linux as a router (ip/ipx/...) or a bridge device ?
		Tia ,  JimL

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

