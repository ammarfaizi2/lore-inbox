Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269906AbRHEC2S>; Sat, 4 Aug 2001 22:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269905AbRHEC2I>; Sat, 4 Aug 2001 22:28:08 -0400
Received: from ns.suse.de ([213.95.15.193]:25361 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S269904AbRHEC2B>;
	Sat, 4 Aug 2001 22:28:01 -0400
Date: Sun, 5 Aug 2001 04:28:05 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: "Paul G. Allen" <pgallen@randomlogic.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: MTRR and Athlon Processors
In-Reply-To: <3B6C9B0E.EF55EF8@randomlogic.com>
Message-ID: <Pine.LNX.4.30.0108050427270.2519-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Aug 2001, Paul G. Allen wrote:

> Jul 29 03:33:00 keroon kernel: mtrr: type mismatch for f8000000,4000000
> old: write-back new: write-combining
>
> This happens quite often, especially with the agpgart and NVdriver
> modules.

iirc, this is a problem with the nvidia module, and there's nothing
the kernel can do about it. Complain to nvidia.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

