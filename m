Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131476AbRA0Aiq>; Fri, 26 Jan 2001 19:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131525AbRA0Aih>; Fri, 26 Jan 2001 19:38:37 -0500
Received: from adsl-216-102-91-127.dsl.snfc21.pacbell.net ([216.102.91.127]:49397
	"EHLO champ.drew.net") by vger.kernel.org with ESMTP
	id <S131476AbRA0Aib>; Fri, 26 Jan 2001 19:38:31 -0500
From: Drew Bertola <drew@drewb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14962.6274.780427.637829@champ.drew.net>
Date: Sat, 27 Jan 2001 00:38:26 +0000 ()
To: Thunder from the hill <thunder@ngforever.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OT] Vaio Brightness [WAS: Probably Off-topic Question...]
In-Reply-To: <3A707239.9F88FB7B@ngforever.de>
In-Reply-To: <Pine.LNX.4.10.10101222129310.3031-100000@clueserver.org>
	<3A6F0D6B.34EB2CB0@coppice.org>
	<20010124123001.52317@winksmith.com>
	<3A707239.9F88FB7B@ngforever.de>
X-Mailer: VM 6.75 under Emacs 19.34.1
Reply-To: drew@drewb.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I stuffed Tridge's inb / outb program into a little gnome window.  Just
seems easier to have a spinbox to adjust brightness.  Shits and giggles.

You can find it at: http://drew.serialhacker.net/vaio_control.tar.gz

You either have to run it as root or throw the executable into
/usr/local/bin and set the sticky bit.

Drew


Thunder from the hill writes:
> Mark Smith wrote:
> > 
> > On Thu, Jan 25, 2001 at 01:14:19AM +0800, Steve Underwood wrote:
> > > > This is probably a user-land and/or undocumented thing, but I am not
> > > > certain where to get the correct info.
> > > >
> > > > Does anyone know how to get the screen brightness control to work on a
> > > > Sony Vaio N505VE?  There seems to be some sort of proprietary hook to get
> > > > it to work that requires their install of Windows.  (This is a problem as
> > > > it was removed immediatly after purchacing the laptop.)
> > >
> > > All the newer Vaios seem to have this problem. They rely on support from
> > > Windows to control the brightness, instead of doing it through the BIOS,
> > > like older machines. I don't know a solution. More annoyingly, they
> > > won't hibernate, as they rely on Windows Me or 2000 doing it for them.
> > > The APM hibernate in the BIOS seems to have gone. I have a Z505GAT,
> > > which I think is the Asian version of the model sold in the US as the
> > > Z505LE. I guess this will become the norm now none of the current
> > > versions of Windows require any hibernation support from the BIOS. The
> > > hibernate to swap patch for Linux really needs to get into the
> > > mainstream, and be more thoroughly exercised.
> > 
> > if anyone finds a way of dimming the brightness make sure you post!
> > besides killing the battery, it also makes it hard to use in dark
> > places such as night flights.  i feel as if i'm lighting up the
> > cabin in these cases.
> > 
> > my vaio F-series used to sleep correctly under RH6.1.  it now hangs
> > forever making the sleep mode much less useful.
> Maybe it has some problems with the way you send it to sleep. It could
> have changed through the times...
> 
> Cheers!
> Thunder
> ---
> I did a "cat /boot/vmlinuz >> /dev/audio" - and I think I heard god...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Drew Bertola  | Send a text message to my pager or cell ... 
              |   http://jpager.com/Drew

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
