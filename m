Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287841AbSATB5a>; Sat, 19 Jan 2002 20:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287852AbSATB5U>; Sat, 19 Jan 2002 20:57:20 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:47373 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S287841AbSATB5A>; Sat, 19 Jan 2002 20:57:00 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 19 Jan 2002 18:02:37 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Andre Hedrick <andre@linuxdiskcert.org>
cc: Jens Axboe <axboe@suse.de>, Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <Pine.LNX.4.10.10201191628290.9354-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.40.0201191800250.975-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jan 2002, Andre Hedrick wrote:

>
> Yes,
>
> I have a patch against 2.5.3-pre1 clean, and is up on kernel.org's upload
> site, but k.o is down.  It can also be gotten off
> 	http://www.linuxdiskcert.org/
> It is a tiny 37k patch and bzip2'd to 8k.

By applying the patch posted by Anton ( patch-2.5.3-pre1-aia2 ) the
problem persist. The machine seems usable but time to time the timer hit
and lost interrupt shows up. I'm going to try your patch now.




- Davide


