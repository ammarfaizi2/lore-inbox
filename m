Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132554AbRALUkh>; Fri, 12 Jan 2001 15:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132952AbRALUk2>; Fri, 12 Jan 2001 15:40:28 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:53515 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S132554AbRALUjy>;
	Fri, 12 Jan 2001 15:39:54 -0500
Date: Fri, 12 Jan 2001 21:39:28 +0100
From: Frank de Lange <frank@unternet.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardwarerelated?
Message-ID: <20010112213928.G26555@unternet.org>
In-Reply-To: <20010112213217.E26555@unternet.org> <Pine.LNX.4.30.0101122132290.2772-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101122132290.2772-100000@e2>; from mingo@elte.hu on Fri, Jan 12, 2001 at 09:34:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 09:34:03PM +0100, Ingo Molnar wrote:
> ? this is x86-only code. There is no hot-pluggable CPU support for Linux
> AFAIK. (But in any case, the code is basically ready for hot-pluggable
> CPUs, just take a few precautions and change cpu_online_mask and a couple
> of other things.)

OK, maybe the Sun example was not the best to give for this code... But if
there are no hot-pluggable x86's around now (I think there are, but can not
recollect who made 'm...) and nobody is complaining, then it is fine with me...
I won't hot-unplug my BP6's CPU's anyway...

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
