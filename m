Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129927AbRANAQf>; Sat, 13 Jan 2001 19:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130150AbRANAQZ>; Sat, 13 Jan 2001 19:16:25 -0500
Received: from smtp9.xs4all.nl ([194.109.127.135]:34526 "EHLO smtp9.xs4all.nl")
	by vger.kernel.org with ESMTP id <S129927AbRANAQK>;
	Sat, 13 Jan 2001 19:16:10 -0500
Date: Sun, 14 Jan 2001 00:13:58 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Frank de Lange <frank@unternet.org>,
        Manfred Spraul <manfred@colorfullife.com>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related?
Message-ID: <20010114001358.A1150@grobbebol.xs4all.nl>
In-Reply-To: <Pine.LNX.4.10.10101121158050.3010-100000@penguin.transmeta.com> <Pine.LNX.4.30.0101122101370.2576-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101122101370.2576-100000@e2>; from mingo@elte.hu on Fri, Jan 12, 2001 at 09:03:49PM +0100
X-OS: Linux grobbebol 2.2.19pre7 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 09:03:49PM +0100, Ingo Molnar wrote:
> well, some time ago i had an ne2k card in an SMP system as well, and found
> this very problem. Disabling/enabling focus-cpu appeared to make a
> difference, but later on i made experiments that show that in both cases
> the hang happens. I spent a good deal of time trying to fix this problem,
> but failed - so any fresh ideas are more than welcome.

for the record. my BP6, non OC, apic smp system with ne2k fails within
24 hours here too. if I can be of any help..... (2.4.0. kernel. no
vmware or opensound)

-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
