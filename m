Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277568AbRKNU5k>; Wed, 14 Nov 2001 15:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277653AbRKNU5a>; Wed, 14 Nov 2001 15:57:30 -0500
Received: from zeus.kernel.org ([204.152.189.113]:26279 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S277568AbRKNU5R>;
	Wed, 14 Nov 2001 15:57:17 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: alastair.stevens@mrc-bsu.cam.ac.uk (Alastair Stevens),
        linux-kernel@vger.kernel.org
Subject: Re: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
In-Reply-To: <Pine.GSO.4.33.0111141421230.14971-100000@gurney>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.14-686-smp (i686))
Message-Id: <E1646xi-00015T-00@gondolin.me.apana.org.au>
Date: Thu, 15 Nov 2001 07:48:46 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk> wrote:

> I installed Red Hat 7.2 and the machine boots fine, using SMP or UP
> kernels (Red Hat 2.4.9-7), but totally HANGS at the login prompt. Can't
> type, can't reboot, can't do anything. Single user mode _does_ let me
> in, however, and this is the only progress so far.

Try plugging in a mouse or stop running gpm.
-- 
Debian GNU/Linux 2.2 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
