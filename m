Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288946AbSATTB7>; Sun, 20 Jan 2002 14:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288932AbSATTBu>; Sun, 20 Jan 2002 14:01:50 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:3596 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S288930AbSATTBm>;
	Sun, 20 Jan 2002 14:01:42 -0500
Date: Fri, 18 Jan 2002 23:01:33 +0100
From: Pavel Machek <pavel@suse.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ronald Wahl <Ronald.Wahl@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
Message-ID: <20020118220132.GE6918@elf.ucw.cz>
In-Reply-To: <20020112063412.F511@toy.ucw.cz> <m26669olcu.fsf@goliath.csn.tu-chemnitz.de> <E16Oocq-0005tX-00@the-village.bc.nu> <3535.1011375513@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3535.1011375513@redhat.com>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  RPM does not help. Think new machine failed, but you still have some
> > trash with 386 on it, so you connect your disk to it, boot from
> > floppy, and expect it to work.
> 
> What if my spare machine is an ARM? Should I still expect it to work?

Let's say "It is easy in 386 case and hard in ARM case". Besides, we
do FPU emulation already. Way harder than CMOV emulation, and serves
exactly same purpose.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
