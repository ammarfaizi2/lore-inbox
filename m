Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136280AbRAMBzz>; Fri, 12 Jan 2001 20:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136263AbRAMBzs>; Fri, 12 Jan 2001 20:55:48 -0500
Received: from colorfullife.com ([216.156.138.34]:27398 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S136170AbRAMBzc>;
	Fri, 12 Jan 2001 20:55:32 -0500
Message-ID: <3A5FB4BA.37A9C7E5@colorfullife.com>
Date: Sat, 13 Jan 2001 02:51:54 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank de Lange <frank@unternet.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
In-Reply-To: <20010113014807.B29757@unternet.org> <Pine.LNX.4.10.10101121652160.8097-100000@penguin.transmeta.com> <20010113022741.D29757@unternet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank de Lange wrote:
> 
> It could be that people using those cards are not the ones who tend
> to go for the (somewhat tricky) BP6 board...
> 

I doubt that it's BP6 specific: I have the problem with a Gigabyte BXD
board and I doubt that Ingo used an BP6. Perhaps 82093AA specific (the
IO APIC chip used for SMP 440BX board)

I can't find any spec updates for that chip: either it's the first
perfect chip Intel ever produced, or ...

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
