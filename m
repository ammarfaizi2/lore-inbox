Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132037AbQKDFeb>; Sat, 4 Nov 2000 00:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132427AbQKDFeV>; Sat, 4 Nov 2000 00:34:21 -0500
Received: from squeaker.ratbox.org ([63.216.218.10]:20050 "HELO
	squeaker.ratbox.org") by vger.kernel.org with SMTP
	id <S132037AbQKDFeM>; Sat, 4 Nov 2000 00:34:12 -0500
Date: Sat, 4 Nov 2000 00:34:23 -0500 (EST)
From: Aaron Sethman <androsyn@ratbox.org>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tim Riker <Tim@Rikers.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
In-Reply-To: <20001102201836.A14409@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.21.0011040031450.11261-100000@squeaker.ratbox.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2000, Andi Kleen wrote:

> On Thu, Nov 02, 2000 at 07:07:12PM +0000, Alan Cox wrote:
> > > 1. There are architectures where some other compiler may do better
> > > optimizations than gcc. I will cite some examples here, no need to argue
> > 
> > I think we only care about this when they become free software.
> 
> SGI's pro64 is free software and AFAIK is able to compile a kernel on IA64.
> It is also not clear if gcc will ever produce good code on IA64.

Well if its compiling the kernel just fine without alterations to the
code, then fine. If not, if the SGI compiler is GPL'd pillage its sources
and get that code working in gcc. Otherwise, trying to get linux to work
with other C compilers doesn't seem worth the effort. 

Aaron

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
