Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270795AbRINUhz>; Fri, 14 Sep 2001 16:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270825AbRINUho>; Fri, 14 Sep 2001 16:37:44 -0400
Received: from relay01.cablecom.net ([62.2.33.101]:52747 "EHLO
	relay01.cablecom.net") by vger.kernel.org with ESMTP
	id <S270795AbRINUhg>; Fri, 14 Sep 2001 16:37:36 -0400
Message-ID: <3BA26AA6.CAC6D2D9@bluewin.ch>
Date: Fri, 14 Sep 2001 22:37:58 +0200
From: Otto Wyss <otto.wyss@bluewin.ch>
Reply-To: otto.wyss@bluewin.ch
X-Mailer: Mozilla 4.78 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: Alex Stewart <alex@foogod.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: How errorproof is ext2 fs?
In-Reply-To: <3BA1258F.5CC18A2C@bluewin.ch> <3BA1E670.9010300@foogod.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > it does not need a good  error proof fs. Still can't ext2 be made a little more
> > error proof?
> 
> First, you seem to be making quite a few assumptions which are not
> necessarily correct:
> 
> 1) Just because an OS does not _tell_ you there was a problem does not
> necessarily mean there wasn't one.  In particular, MacOS is notorious
> for not "bothering" users with detailed (or in many cases any)
> information about problems.  I don't know about HFS fragility in
> 
Well I can assure you I used DiskFirstAid and Norton Utilities on the Mac.
Neither found any problems. Since I use MacOS9, my Mac crashes at least once a
month but I never ever lost anything. Most of the time my USB-keyboard/-mouse
doesn't react anymore after switching back from my Linux system. Usually I
simply press the reset switch after a few minutes. 

Besides Linux also does not react occasionally when switching my
USB-keyboard/-mouse but since I also have an AT-keyboard handy I don't have to
reset it.

> 3) You're basing your linux experience on (apparently) only one
> incident.  As a professional sysadmin, I've experienced many many

I'm not bashing linux, I'm only stating that MacOS9 (or HFS+) has a nice feature
Linux (or its fs's) lacks. My experience shows clearly that I had at least 10
craches on the Mac durning the last year but I never lost anything. During the
same time I had 2 crashes on my linux, one due to the USB-problem without a
handy AT-keyboard, the second now due to a malfunction el3diag.

O. Wyss
