Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262424AbSJ2ROH>; Tue, 29 Oct 2002 12:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbSJ2ROH>; Tue, 29 Oct 2002 12:14:07 -0500
Received: from precia.cinet.co.jp ([210.166.75.133]:11648 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262424AbSJ2ROF>; Tue, 29 Oct 2002 12:14:05 -0500
Date: Wed, 30 Oct 2002 02:20:29 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Osamu Tomita <tomita@cinet.co.jp>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCHSET 4/23] add support for PC-9800 architecture (core #1)
Message-ID: <20021030022029.E4772@precia.cinet.co.jp>
References: <20021029023003.A2241@precia.cinet.co.jp> <1035847087.1945.105.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: =?iso-8859-1?Q?=3C1035847087=2E1945=2E105?=
	=?iso-8859-1?B?LmNhbWVsQGlyb25nYXRlLnN3YW5zZWEubGludXgub3JnLnVrPjsgZnJv?=
	=?iso-8859-1?B?bSBhbGFuQGx4b3JndWsudWt1dS5vcmcudWsgb24gstAsIDEwtw==?=
	=?iso-8859-1?Q?=EE?= 29, 2002 at 08:18:07 +0900
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2002.10.29 08:18, Alan Cox wrote:
> On Mon, 2002-10-28 at 17:30, Osamu Tomita wrote:
> > This is a part 4/23 of patchset for add support NEC PC-9800
> architecture,
> > against 2.5.44.
> 
> Ok I've merged bits from this. I redid the vm86 patches by moving the
> checks and the range limit into arch/i386/mach-*/irq_vector.h which I
> think is tidier, and hopefully still correct.
Thank you very much. I will be happy if other parts will be merged 
later.

Best regards,
Osamu Tomita
