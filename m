Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136149AbRAWGdh>; Tue, 23 Jan 2001 01:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136204AbRAWGd1>; Tue, 23 Jan 2001 01:33:27 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:21764 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S136149AbRAWGdS>; Tue, 23 Jan 2001 01:33:18 -0500
Date: Tue, 23 Jan 2001 00:33:45 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Trever Adams <vichu@digitalme.com>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Total loss with 2.4.0 (release)
In-Reply-To: <20010115215047Z131660-403+523@vger.kernel.org>
Message-ID: <Pine.LNX.4.32.0101230026490.7610-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2001, Trever Adams wrote:

>I had a similar experience.  All I can say is windows 98
>and ME seem to have it out for Linux drives running late
>2.3.x and 2.4.0 test and release.  I had windows completely
>fry my Linux drive and I lost everything.  I had some old
>backups and was able to restore at least the majority of
>older stuff.
>
>Sorry and good luck.

I don't see how Windows 9x can be at fault in any way shape or
form, if you can boot between 2.2.x kernel and 9x no problem, but
lose your disk if you boot Win98 and then 2.3.x/2.4.x and lose
everything.  Windows does not touch your Linux fs's, so if there
is a problem, it most likely is a kernel bug of some kind that
doesn't initialize something properly.

Windows sucks, and I hate it as much (probably more) than the
next guy.  It's not fair to blame every computer problem on it
though unless you KNOW that Windows directly caused the problem.

Pick one of the 1000000000 good reasons to say Windows sucks
instead...

For what it is worth, I have a similar problem where if I boot
Windows (to show people what "multicrashing" is), if I boot back
into Linux, my network card no longer works (via-rhine).  Most
definitely a Linux bug.  In this case, "via-rhine.o" sucks.

;o)


----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------
I'd offer to change your mind for you, but I don't have a fresh diaper.
  -- Leah to pro-spammer in news.admin.net-abuse.email

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
