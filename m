Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276500AbRI2N4L>; Sat, 29 Sep 2001 09:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276501AbRI2N4D>; Sat, 29 Sep 2001 09:56:03 -0400
Received: from Expansa.sns.it ([192.167.206.189]:32782 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S276500AbRI2Nzt>;
	Sat, 29 Sep 2001 09:55:49 -0400
Date: Sat, 29 Sep 2001 15:51:53 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
cc: David Lang <david.lang@digitalinsight.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2 GB file limitation
In-Reply-To: <Pine.LNX.4.33.0109290816480.10053-100000@boston.corp.fedex.com>
Message-ID: <Pine.LNX.4.33.0109291549180.30595-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Sep 2001, Jeff Chua wrote:

>
> On Fri, 28 Sep 2001, David Lang wrote:
>
> > ?? slackware 8 has large file support (I've been useing it for a while
> > now)
> >
>
> I think you can get >2GB support if you've Gcc 3.0. Even with the latest
> kernel 2.4.x, you won't get >2GB with gcc 2.95.3.
>
>
???
I am using it and I am using gcc 2.95.3 for normal things,
and to compiled my kernel and my libc, because gcc
3.0.1 produces slower binaries on my Athlons (yes, with athlon
optimizzations turned on), at less for my programs, and it is better to
avoid it for glibc compilation because of back compatibility issues.


bests
Luigi

