Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289075AbSANVSY>; Mon, 14 Jan 2002 16:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289063AbSANVKj>; Mon, 14 Jan 2002 16:10:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44040 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289071AbSANVJw>; Mon, 14 Jan 2002 16:09:52 -0500
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
To: esr@thyrsus.com
Date: Mon, 14 Jan 2002 21:21:30 +0000 (GMT)
Cc: linux@discworld.dyndns.org (Charles Cazabon), linux-kernel@vger.kernel.org,
        arjan@fenrus.demon.nl
In-Reply-To: <20020114151942.A20309@thyrsus.com> from "Eric S. Raymond" at Jan 14, 2002 03:19:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QEXq-0002zZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > "Crap." Melvin thinks.  "I don't remember what kind of network card I
> > > compiled in.  Am I going to have to open this puppy up just to eyeball
> > > the hardware?"
> > 
> > Uh, no.  Try `lsmod`.
> 
> He hard-compiled in that driver.  lsmod(1) can't see it.

You mean he broke the carefully designed vendor set up by running a poorly
designed autoconfig script ? See if he'd run a sensible modular one he would
be fine
