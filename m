Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278737AbRKDUNz>; Sun, 4 Nov 2001 15:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278685AbRKDUNQ>; Sun, 4 Nov 2001 15:13:16 -0500
Received: from postfix2-2.free.fr ([213.228.0.140]:28841 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S278597AbRKDUND> convert rfc822-to-8bit; Sun, 4 Nov 2001 15:13:03 -0500
Date: Sun, 4 Nov 2001 18:28:00 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: John Fremlin <john@fremlin.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [POLITICAL] Re: ECS k7s5a audio sound SiS 735 - 7012
In-Reply-To: <3BE59724.9EB3B816@colorfullife.com>
Message-ID: <20011104180055.F2312-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Nov 2001, Manfred Spraul wrote:

> > Indeed. Could you all please hassle SiS for the datasheet for the 7012
> > integrated audio controller in the SiS 735?
>
> Sis is quite good at writing Linux drivers and they release the source
> under GPL - just search through google for bug reports for the sis900
> network driver.

Agreed, but we need more generic drivers when possible anyway. Just think
about Tekram drivers for DC-390 boards. They just ignored anything
different from Tekram adapters. Btw, my Netgear FA311 board is not handled
by the sis driver of linux-2.2.20 and my little finger tells me that it
could be so given a few code addition.

> And it's probably the only driver with a large list of the PHY's that
> are used by the mobo manufacturers with the nic, and the various ways to
> get at the correct negotiation result. That's something you won't be
> able to write even with the sis datasheet.

Let me adver^H^Hocate: :-)

Just some pricing from France:

- K7S5A (without NIC option) : FF  590
- ASUS A7M (example)         : FF 1300
- CM8378 Mentor sound board  : FF  119

K7S5A + Mentor sound board     -> FF  709
ASUS A7M (with bogus VIA 686B) -> FF 1300

The K7S5A is a great Mobo, good quality, very fast and very cheap, as long
as you donnot want to use on-board sound. :)

The K7S5A I have is used by my children under Windows, but I have stressed
it a lot under Linux and FreeBSD prior to leave them play with it.

> Just wait a bit, or try to convince nvidia that they should release the
> source of their driver if you want to do something now.

Good point.

  Gérard.

