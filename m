Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265816AbRFYA0I>; Sun, 24 Jun 2001 20:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265817AbRFYAZ6>; Sun, 24 Jun 2001 20:25:58 -0400
Received: from paloma14.e0k.nbg-hannover.de ([62.159.219.14]:63622 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S265816AbRFYAZt>; Sun, 24 Jun 2001 20:25:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Some experience of linux on a Laptop
Date: Mon, 25 Jun 2001 02:25:00 +0200
X-Mailer: KMail [version 1.2.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010625002550Z265816-17720+7279@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
>
> > 4: make bzImage && make modules && make modules install && cp 
> > arch/i386/boot/bzImage /boot/'uname -r' something inside make menuconfig
>
> So really you want an outside GUI tool that lets you reconfigure build and
> install kernels. Yeah I'd agree with that. Someone just needs to write the
> killer gnome/kde config tool. I've got C code for parsing/loading config.in
> files and deducing the dependancy constraints if anyone ever wants to try
> and write such a tool 8)

KDE-2.2 will do this.

I have KDE-2.2alpha2 running here (beta1 is around the corner) and it has it 
included. I looked at it but didn't tested it, yet.


KDE Control Center --> System --> Linux Kernel Configurator

> > 8: A way to change kernel without rebooting. I have no diskdrive or
> > cddrive in my laptop so I often do drastic things when I install a new
> > distribution.
>
> Thats actually an incredibly hard problem to solve. The only people who do
> this level of stuff are some of the telephony folks, and the expensive 
> tandem non-stop boxes.

SUN Enterprise
IBM S/390 (zSeries)
etc...

-Dieter

