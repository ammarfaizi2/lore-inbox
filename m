Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135692AbRAYSeb>; Thu, 25 Jan 2001 13:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135850AbRAYSeV>; Thu, 25 Jan 2001 13:34:21 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:28016 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S135692AbRAYSeE>; Thu, 25 Jan 2001 13:34:04 -0500
Message-ID: <3A707239.9F88FB7B@ngforever.de>
Date: Thu, 25 Jan 2001 11:36:41 -0700
From: Thunder from the hill <thunder@ngforever.de>
X-Mailer: Mozilla 4.76 [en]C-CCK-MCD QXW03240  (WinNT; U)
X-Accept-Language: de,en-US
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Probably Off-topic Question...
In-Reply-To: <Pine.LNX.4.10.10101222129310.3031-100000@clueserver.org> <3A6F0D6B.34EB2CB0@coppice.org> <20010124123001.52317@winksmith.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Smith wrote:
> 
> On Thu, Jan 25, 2001 at 01:14:19AM +0800, Steve Underwood wrote:
> > > This is probably a user-land and/or undocumented thing, but I am not
> > > certain where to get the correct info.
> > >
> > > Does anyone know how to get the screen brightness control to work on a
> > > Sony Vaio N505VE?  There seems to be some sort of proprietary hook to get
> > > it to work that requires their install of Windows.  (This is a problem as
> > > it was removed immediatly after purchacing the laptop.)
> >
> > All the newer Vaios seem to have this problem. They rely on support from
> > Windows to control the brightness, instead of doing it through the BIOS,
> > like older machines. I don't know a solution. More annoyingly, they
> > won't hibernate, as they rely on Windows Me or 2000 doing it for them.
> > The APM hibernate in the BIOS seems to have gone. I have a Z505GAT,
> > which I think is the Asian version of the model sold in the US as the
> > Z505LE. I guess this will become the norm now none of the current
> > versions of Windows require any hibernation support from the BIOS. The
> > hibernate to swap patch for Linux really needs to get into the
> > mainstream, and be more thoroughly exercised.
> 
> if anyone finds a way of dimming the brightness make sure you post!
> besides killing the battery, it also makes it hard to use in dark
> places such as night flights.  i feel as if i'm lighting up the
> cabin in these cases.
> 
> my vaio F-series used to sleep correctly under RH6.1.  it now hangs
> forever making the sleep mode much less useful.
Maybe it has some problems with the way you send it to sleep. It could
have changed through the times...

Cheers!
Thunder
---
I did a "cat /boot/vmlinuz >> /dev/audio" - and I think I heard god...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
