Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136220AbRAMCXH>; Fri, 12 Jan 2001 21:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136264AbRAMCW6>; Fri, 12 Jan 2001 21:22:58 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:6660 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S136220AbRAMCWr>;
	Fri, 12 Jan 2001 21:22:47 -0500
Date: Sat, 13 Jan 2001 03:11:22 +0100
From: Frank de Lange <frank@unternet.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
Message-ID: <20010113031122.E29757@unternet.org>
In-Reply-To: <20010113014807.B29757@unternet.org> <Pine.LNX.4.10.10101121652160.8097-100000@penguin.transmeta.com> <20010113022741.D29757@unternet.org> <3A5FB4BA.37A9C7E5@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5FB4BA.37A9C7E5@colorfullife.com>; from manfred@colorfullife.com on Sat, Jan 13, 2001 at 02:51:54AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2001 at 02:51:54AM +0100, Manfred Spraul wrote:
> Frank de Lange wrote:
> > 
> > It could be that people using those cards are not the ones who tend
> > to go for the (somewhat tricky) BP6 board...
> > 
> 
> I doubt that it's BP6 specific: I have the problem with a Gigabyte BXD
> board and I doubt that Ingo used an BP6. Perhaps 82093AA specific (the
> IO APIC chip used for SMP 440BX board)

It isn't. But I just meant to indicate that the mere fact that I could not find
any problem-report for that combination does not indicate that there ARE no
problems...

> I can't find any spec updates for that chip: either it's the first
> perfect chip Intel ever produced, or ...

:-)

Well, the BX chipset is one of their better attempts I think...

Frank
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
