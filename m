Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290757AbSARR1c>; Fri, 18 Jan 2002 12:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290759AbSARR1W>; Fri, 18 Jan 2002 12:27:22 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:2058 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S290757AbSARR1I>; Fri, 18 Jan 2002 12:27:08 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 18 Jan 2002 09:32:40 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <5.1.0.14.2.20020118021222.04e4caa0@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.40.0201180928500.934-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002, Anton Altaparmakov wrote:

> Since the new IDE core from Andre is now solid as reported by various
> people on IRC, here is my local patch (stable for me) which you can apply
> to play with the shiny new IDE core (IDE core fix is same as
> ata-253p1-2.bz2 from Jens). (-:

I would like to say the same. I worked with the fixed kernel
2.5.3-pre1+ata-253p1-2 yesterday w/out problems. I rebootedt the machine
before leaving the office yesterday night and this morning it had a full
screen :

hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt

I have to say that something like :

All work and no play makes Jack a dull boy ...
All work and no play makes Jack a dull boy ...
All work and no play makes Jack a dull boy ...

would have scared me more, but still i think there's some tuning to play
with ...




- Davide


