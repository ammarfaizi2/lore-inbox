Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286804AbRLVP5V>; Sat, 22 Dec 2001 10:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286806AbRLVP5L>; Sat, 22 Dec 2001 10:57:11 -0500
Received: from prahad-1-35.dialup.vol.cz ([212.27.197.35]:34052 "EHLO
	albireo.ucw.cz") by vger.kernel.org with ESMTP id <S286805AbRLVP5F>;
	Sat, 22 Dec 2001 10:57:05 -0500
Date: Sat, 22 Dec 2001 16:24:38 +0100
From: Martin Mares <mj@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Petr Bavorovsky <petr@vt.cs.nstu.ru>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: arcnet bugs in 2.4.x
Message-ID: <20011222162438.A1945@ucw.cz>
In-Reply-To: <200112092255.fB9Mtwg18442@vt.cs.nstu.ru> <E16HhpY-0003Q3-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16HhpY-0003Q3-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, world!\n

> It looks like the drivers are making a few assumptions about headers and
> length they shouldn't be. I don't think anyone is maintaining ARCnet any
> more, all those who worked on it before have moved on to more real
> networking. Its one of those things that may well just vanish in 2.5 if
> nobody becomes a maintainer.

I still use ARCnet in my home network and I'll hopefully find some
free time over the Christmas to fix these bugs.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Outside of a dog, a book is man's best friend. Inside a dog, it's too dark to read.
