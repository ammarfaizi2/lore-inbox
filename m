Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287817AbSAAKer>; Tue, 1 Jan 2002 05:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287814AbSAAKej>; Tue, 1 Jan 2002 05:34:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9747 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287800AbSAAKd3>; Tue, 1 Jan 2002 05:33:29 -0500
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
To: timothy.covell@ashavan.org
Date: Tue, 1 Jan 2002 10:42:55 +0000 (GMT)
Cc: landley@trommello.org (Rob Landley),
        torvalds@transmeta.com (Linus Torvalds),
        akpm@zip.com.au (Andrew Morton), linux-kernel@vger.kernel.org,
        linux-fbdev-devel@lists.sourceforge.net (Linux Frame Buffer Device
	Development),
        marcelo@conectiva.com.br (Marcelo Tosatti)
In-Reply-To: <200201010704.g01740Sr016296@svr3.applink.net> from "Timothy Covell" at Jan 01, 2002 01:00:13 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LMNj-0008Gz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > X11 isn't always an improvement.  I've got an X hang on my laptop (about
> > once a week) that freezes the keyboard and ignores mouse clicks.  Numlock
> > doesn't change the keyboard LEDs, CTRL-ALT-BACKSPACE won't do a thing, and
> > although I can ssh in and run top (and see the CPU-eating loop), kill won't
> > take X down and kill-9 leaves the video display up so the console that
> > thinks it's in text mode, but isn't, is still useless.  (And that's
> > assuming I'm plugged into the network and have another box around to ssh in
> > from...)

Neomagic Magicgraph 128XD ? If so check man neomagic first 8)
