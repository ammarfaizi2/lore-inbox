Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284556AbRLDANF>; Mon, 3 Dec 2001 19:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276424AbRLDAFg>; Mon, 3 Dec 2001 19:05:36 -0500
Received: from donna.siteprotect.com ([64.41.120.44]:64005 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S284914AbRLCSHd>; Mon, 3 Dec 2001 13:07:33 -0500
Date: Mon, 3 Dec 2001 13:07:11 -0500 (EST)
From: John Clemens <john@deater.net>
X-X-Sender: <john@pianoman.cluster.toy>
To: Pavel Machek <pavel@suse.cz>
cc: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Re: ACPI+HP omnibook -- freeze until power is pressed?
In-Reply-To: <20011202121922.A2356@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0112031303010.18581-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


YES!  Same problem here.  HP Pavilion N5430 (Duron/ALI MAgik1 notebook).
Seems to happen a lot under X as well.  2.4.16 (been happening for a long time).

Machine seems to freeze up, w/ interrupts disabled, but just hitting the
power switch for a quick second (not long enough to shut it off), seems to
make the machine unstuck.  Happens a lot for me if i happen to switch
consoles to X and start using the touchpad before X is fully switched in.

been bothering me for a while...

john.c

On Sun, 2 Dec 2001, Pavel Machek wrote:

> Hi!
>
> I'm seeing strange thing on hp omnibook... I work on console, and
> machine suddenly locks up without me doing anything strange. So I
> press powerbutton for a short while, and ... machine continues to work
> as if nothing happened. Not even keyboard presses are lost.
>
> But its annoying, anyway. 2.4.14-acpi. Happened ~10 times so
> far. Anyone seen something similar?
> 								Pavel
>

-- 
John Clemens          http://www.deater.net/john
john@deater.net     ICQ: 7175925, IM: PianoManO8
      "I Hate Quotes" -- Samuel L. Clemens



