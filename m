Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286679AbSALN2T>; Sat, 12 Jan 2002 08:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286338AbSALN2J>; Sat, 12 Jan 2002 08:28:09 -0500
Received: from B9071.pppool.de ([213.7.144.113]:20206 "HELO schottelius.org")
	by vger.kernel.org with SMTP id <S286311AbSALN2A>;
	Sat, 12 Jan 2002 08:28:00 -0500
Message-ID: <3C407FF6.3C4C0968@pcsystems.de>
Date: Sat, 12 Jan 2002 19:27:02 +0100
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: de-DE, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: why do i get kernel panic?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello dear list!

Can somebody help me to find out, why I get a kernel panic (init not
found ) when I boot ?
I can't understand why the kernel does not find init.
The system I try to boot is brandnew-selfmade.
I copied it via nfs to the hd. I ran lilo after I copied the files.
The kernel and init resist on the second partition of the first scsi
disc.
The kernel includes scsi controller (aic7xxx) and disc support.
I thought possibly the kernel tries to mount the wrong root, but there
is
just /dev/discs/disc0/part2 to mount, /dev/discs/disc0/part1 is swap and
there
are no more harddiscs.
Passing init=/bin/sh results in the same message, although both files
exist
and have the x - bit set.

Anyone any idea what's wrong ?
Please cc: me if you answer, I am not subscribed to the list anymore.


--
{Greetings,Gruss},
Nico Schottelius

I am some kind of busy -
Do not expect an answer within 24 hours.
Instead use the telephon: +49 (0) 173 - 750 7022.



