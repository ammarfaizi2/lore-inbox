Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314132AbSEITOh>; Thu, 9 May 2002 15:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSEITOg>; Thu, 9 May 2002 15:14:36 -0400
Received: from [195.39.17.254] ([195.39.17.254]:39829 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S314132AbSEITOg>;
	Thu, 9 May 2002 15:14:36 -0400
Date: Thu, 9 May 2002 13:13:42 +0000
From: Pavel Machek <pavel@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
Message-ID: <20020509131341.A37@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.44.0205070953420.2509-100000@home.transmeta.com> <3CD8DAA2.6080907@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> BTW. If one needs the size of the disk well we could
> attach it as a file size to the device file in /dev IMHO. Why not?

Seems like good idea. (I don't know how happy du is going to be that. OTOH
is du is not happy, we should fix it not to count block devices...)
								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

