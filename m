Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131515AbQKJXsZ>; Fri, 10 Nov 2000 18:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131714AbQKJXsQ>; Fri, 10 Nov 2000 18:48:16 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:1034 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131515AbQKJXr7>; Fri, 10 Nov 2000 18:47:59 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: bzImage ~ 900K with i386 test11-pre2
Date: 10 Nov 2000 15:47:21 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8ui1e9$bj7$1@cesium.transmeta.com>
In-Reply-To: <3A0C86B3.62DA04A2@best.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3A0C86B3.62DA04A2@best.com>
By author:    Robert Lynch <rmlynch@best.com>
In newsgroup: linux.dev.kernel
>
> I've been regularly building kernels in the testXX series, and
> they have been coming out ~ 600K; test10-final and test11-pre1:
> 
> -rw-r--r--    1 root     root       610503 Oct 31 18:39
> vmlinuz-t10
> -rw-r--r--    1 root     root       610568 Nov  7 20:26
> vmlinuz-t11p01
> 
> test11-pre2 comes out ~ 900K:
> 
> -rw-r--r--    1 root     root       926345 Nov 10 10:16
> vmlinuz-t11p02
> 
> and is thus unusable.
> 
> I believe I am following all the same steps, nothing new, make
> dep bzImage modules modules_install.
> 

Different compile options?

Why is a 900K kernel unusable?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
