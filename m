Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135782AbRA1AMm>; Sat, 27 Jan 2001 19:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135805AbRA1ALx>; Sat, 27 Jan 2001 19:11:53 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:16500 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S135779AbRA1ALn>; Sat, 27 Jan 2001 19:11:43 -0500
Message-ID: <3A73571B.CC83C154@ngforever.de>
Date: Sat, 27 Jan 2001 16:17:47 -0700
From: Thunder from the hill <thunder@ngforever.de>
X-Mailer: Mozilla 4.76 [en]C-CCK-MCD QXW03240  (WinNT; U)
X-Accept-Language: de,en-US
MIME-Version: 1.0
To: mark@winksmith.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Probably Off-topic Question...
In-Reply-To: <Pine.LNX.4.10.10101222129310.3031-100000@clueserver.org> <3A6F0D6B.34EB2CB0@coppice.org> <20010124123001.52317@winksmith.com> <3A707239.9F88FB7B@ngforever.de> <20010125155809.26969@winksmith.com> <3A71BB9D.9B0BAA5C@ngforever.de> <20010126223246.34429@winksmith.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Smith wrote:
> 
> On Fri, Jan 26, 2001 at 11:02:05AM -0700, Thunder from the hill wrote:
> > > > > my vaio F-series used to sleep correctly under RH6.1.  it now hangs
> > > > > forever making the sleep mode much less useful.
> > > i just push the sleep button.  it used to work under RH6.1.  under RH7.0
> > > it never wakes up.
> > Well, this seems not to be right...
> > Already any idea?
> 
> i haven't had a chance to look at it.  i'm not quite sure where to start
> looking either.  i suppose i could track down if there's any resource
> still running?  trying out different configurations.  it's kinda annoying.
> the battery drain on linux is pretty high so it would be useful to sleep
> to save juice.  not quite annoying enough yet to start debugging though.
> too many other things above it on the sliding scale.
Hmmm... Can you access objects on the penguin via network? Try using
telnet, or better ssh, to be sure if it is a crash or a graphic error.

Thunder
---
Woah... I did a "cat /boot/vmlinuz >> /dev/audio" - and I think I heard
god...


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
