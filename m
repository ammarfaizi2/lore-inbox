Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130927AbRAYSYl>; Thu, 25 Jan 2001 13:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130938AbRAYSYV>; Thu, 25 Jan 2001 13:24:21 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:25636 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S130927AbRAYSYQ>; Thu, 25 Jan 2001 13:24:16 -0500
Message-ID: <3A706FE4.CAA96633@ngforever.de>
Date: Thu, 25 Jan 2001 11:26:44 -0700
From: Thunder from the hill <thunder@ngforever.de>
X-Mailer: Mozilla 4.76 [en]C-CCK-MCD QXW03240  (WinNT; U)
X-Accept-Language: de,en-US
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Probably Off-topic Question...
In-Reply-To: <Pine.LNX.4.10.10101222129310.3031-100000@clueserver.org> <3A6F0D6B.34EB2CB0@coppice.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Underwood wrote:
> 
> Alan Olsen wrote:
> >
> > This is probably a user-land and/or undocumented thing, but I am not
> > certain where to get the correct info.
> >
> > Does anyone know how to get the screen brightness control to work on a
> > Sony Vaio N505VE?  There seems to be some sort of proprietary hook to get
> > it to work that requires their install of Windows.  (This is a problem as
> > it was removed immediatly after purchacing the laptop.)
> 
> All the newer Vaios seem to have this problem. They rely on support from
> Windows to control the brightness, instead of doing it through the BIOS,
> like older machines. I don't know a solution. More annoyingly, they
> won't hibernate, as they rely on Windows Me or 2000 doing it for them.
> The APM hibernate in the BIOS seems to have gone. I have a Z505GAT,
> which I think is the Asian version of the model sold in the US as the
> Z505LE. I guess this will become the norm now none of the current
> versions of Windows require any hibernation support from the BIOS. The
> hibernate to swap patch for Linux really needs to get into the
> mainstream, and be more thoroughly exercised.
Couldn't it be possible to write a "hole" or such into the kernel's vaio
driver - or even a /dev file - which can be used by some program to set
screen brightness?

Cheers!
Thunder
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
