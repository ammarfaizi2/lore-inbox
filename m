Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293426AbSCKA7d>; Sun, 10 Mar 2002 19:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293429AbSCKA7X>; Sun, 10 Mar 2002 19:59:23 -0500
Received: from coffee.Psychology.McMaster.CA ([130.113.218.59]:58829 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S293426AbSCKA7G>; Sun, 10 Mar 2002 19:59:06 -0500
Date: Sun, 10 Mar 2002 20:01:45 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: Derek J Witt <djw@flinthills.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Suspend support for IDE
In-Reply-To: <009501c1c895$f9008e10$d3c02740@flinthills.com>
Message-ID: <Pine.LNX.4.33.0203101959020.30983-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suppose risking screwing up the IDE cable just to get it to  reach or fit
> properly in a mid-tower isn't worth losing data via CRC errors...

uh, that's an oxymoron - you specifically don't lose data because 
of CRC checking.  

> I now have this IDE setup:
> 
> Primary master: Quantum Fireball SE6.4A
> Primary slave:  Western Digital WDC AC36400L
> Secondary master: Acer ATAPI CD-ROM 40x N0AP
> Secondary slave: Acer ATAPI CD-RW 2x6x CRW6206A.

it's fairly common to have drives from different vendors, 
especially oldish ones, not get along as master/slave.

> working just fine even with dma enabled. I'm using an ATA66 cable for the
> hard drives.

not to be *too* persnickety, but there's no such thing as "ata66 cable", 
just 40 or 80-conductor...

