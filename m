Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291857AbSBHVmq>; Fri, 8 Feb 2002 16:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291862AbSBHVmg>; Fri, 8 Feb 2002 16:42:36 -0500
Received: from pcow034o.blueyonder.co.uk ([195.188.53.122]:8465 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S291857AbSBHVmV>;
	Fri, 8 Feb 2002 16:42:21 -0500
Date: Fri, 8 Feb 2002 18:50:31 +0000
From: Ian Molton <spyro@armlinux.org>
To: Guest section DW <dwguest@win.tue.nl>
Cc: aia21@cam.ac.uk, aia21@cus.cam.ac.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix floppy io ports reservation
Message-Id: <20020208185031.0a9c464f.spyro@armlinux.org>
In-Reply-To: <20020208152348.GA1809@win.tue.nl>
In-Reply-To: <E16Yevs-00054g-00@libra.cus.cam.ac.uk>
	<E16Yevs-00054g-00@libra.cus.cam.ac.uk>
	<5.1.0.14.2.20020207231937.00b0cec0@pop.cus.cam.ac.uk>
	<20020208152348.GA1809@win.tue.nl>
Reply-To: spyro@armlinux.org
Organization: The dragon roost
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a sunny Fri, 8 Feb 2002 16:23:48 +0100 Guest section DW gathered a sheaf
of electrons and etched in their motions the following immortal words:

> >> ports 0x3f0 and 0x3f1 are used on certain PS/2 systems
> >> and on some very old AT clones
> > 
> > [PS/2] Can you point me to the code for the PS/2 systems in question?
> > [AT] And we care because?
> 
> You need not worry - these systems have been dead for over fifteen years.

I dont like that attitude. I have a system that has been 'dead' for a while
(its now 15 years old), and I'm 're'-porting linux to it (Acorn A400).

Linux is meant to be fun, not just 'latest X86 crap'.

Not to say that we should restrict anything for old hardware, but it doesnt
hurt to spare a thought for it. Doing so may even encourage people to write
better code.
