Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284952AbRL3UuY>; Sun, 30 Dec 2001 15:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284948AbRL3UuH>; Sun, 30 Dec 2001 15:50:07 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:31756 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284945AbRL3Utt>; Sun, 30 Dec 2001 15:49:49 -0500
Date: Sun, 30 Dec 2001 12:53:29 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: J Sloan <jjs@pobox.com>
cc: timothy.covell@ashavan.org, Stephan von Krawczynski <skraw@ithnet.com>,
        Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Balanced Multi Queue Scheduler ...
In-Reply-To: <3C2F7D49.9040606@pobox.com>
Message-ID: <Pine.LNX.4.40.0112301253030.935-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Dec 2001, J Sloan wrote:

> Timothy Covell wrote:
>
> >Ummm, on my Dual P-III (650MHz with 524988416 Bytes), my current Seti
> >efficiency is 5.35 CpF.   That's a tad high/slower than an Ultra Sparc IIi
> >according to their stats.  So, it would appear that being SMP is hurting my
> >performance a bit.   Unless that is that you meant to run a seti instance for
> >each CPU?   And this reminds me of how "make -j3 bzlilo" is slower than
> >"make -j2 bzlilo".
> >
> Eh?
>
> On my 4-way ppro, make -j4 is much faster
> than a simple "make" for kernel compilation.
> Almost linearly so -

He's saying -j3 on a dual CPU



- Davide


