Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSEITPB>; Thu, 9 May 2002 15:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314139AbSEITPA>; Thu, 9 May 2002 15:15:00 -0400
Received: from [195.39.17.254] ([195.39.17.254]:41365 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S314138AbSEITPA>;
	Thu, 9 May 2002 15:15:00 -0400
Date: Thu, 9 May 2002 13:18:30 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
Message-ID: <20020509131830.B37@toy.ucw.cz>
In-Reply-To: <E1758Ra-00081f-00@the-village.bc.nu> <Pine.LNX.4.44.0205070953420.2509-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 	/driverfs/root/pci0/00:1f.4/usb_bus/000/
> 
> and it wouldn't be impossible (or even necessarily very hard) to make an
> IDE controller export the "IDE device tree" the same way a USB controller
> now exports the "USB device tree".

Look harder, it should be already there.
 								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

