Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286959AbSABLgp>; Wed, 2 Jan 2002 06:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286951AbSABLgf>; Wed, 2 Jan 2002 06:36:35 -0500
Received: from dsl-213-023-043-195.arcor-ip.net ([213.23.43.195]:33039 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286950AbSABLg2>;
	Wed, 2 Jan 2002 06:36:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, timothy.covell@ashavan.org
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
Date: Wed, 2 Jan 2002 12:36:59 +0100
X-Mailer: KMail [version 1.3.2]
Cc: landley@trommello.org (Rob Landley),
        torvalds@transmeta.com (Linus Torvalds),
        akpm@zip.com.au (Andrew Morton), linux-kernel@vger.kernel.org,
        linux-fbdev-devel@lists.sourceforge.net (Linux Frame Buffer Device
	Development),
        marcelo@conectiva.com.br (Marcelo Tosatti)
In-Reply-To: <E16LMNj-0008Gz-00@the-village.bc.nu>
In-Reply-To: <E16LMNj-0008Gz-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Ljhc-00010X-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 1, 2002 11:42 am, Alan Cox wrote:
> > > X11 isn't always an improvement.  I've got an X hang on my laptop (about
> > > once a week) that freezes the keyboard and ignores mouse clicks.  Numlock
> > > doesn't change the keyboard LEDs, CTRL-ALT-BACKSPACE won't do a thing, and
> > > although I can ssh in and run top (and see the CPU-eating loop), kill won't
> > > take X down and kill-9 leaves the video display up so the console that
> > > thinks it's in text mode, but isn't, is still useless.  (And that's
> > > assuming I'm plugged into the network and have another box around to ssh in
> > > from...)
> 
> Neomagic Magicgraph 128XD ? If so check man neomagic first 8)

Right, and check out the neomagic@XFree86.Org mailing list archives.

I feel your pain ;)

--
Daniel
