Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266937AbRGMHUw>; Fri, 13 Jul 2001 03:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266938AbRGMHUm>; Fri, 13 Jul 2001 03:20:42 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:25609 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S266937AbRGMHUi>; Fri, 13 Jul 2001 03:20:38 -0400
Date: 13 Jul 2001 08:50:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <84ocY8IHw-B@khms.westfalen.de>
In-Reply-To: <3B4D7685.9AC1DED@idb.hist.no>
Subject: Re: Switching Kernels without Rebooting?
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.LNX.4.33.0107112310590.962-100000@fogarty.jakma.org> <Pine.LNX.4.33L.0107111913010.9899-100000@imladris.rielhome.conectiva> <84jaVrwXw-B@khms.westfalen.de> <3B4D7685.9AC1DED@idb.hist.no>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

helgehaf@idb.hist.no (Helge Hafting)  wrote on 12.07.01 in <3B4D7685.9AC1DED@idb.hist.no>:

> Kai Henningsen wrote:
>
> > What I'd *really* like (but don't see how to get there) would be a "save
> > system state, shutdown, change kernel and/or hardware, reboot, restore
> > state" system (where state is like "I'm logged in on this console, in this
> > current directory, and under X I have Netscape running and this page
> > displayed" but I don't care about the exact state of Squid or even if my
> > ISDN line is dialled in, because those "fix themselves").
>
> Consider os/2 then.  All workplace-shell aware programs is supposed to
> save
> state in this way.

The keyword is "supposed". Because I remember from my OS/2 days that most  
didn't.

OTOH, Borland's DOS IDE does. It's a mixed bag.

>  And yes - they do start up in the same state after
> reboot if you want to.  Editors come up on the page you left, filesystem
> folders comes up, and so on.

Most programs from IBM got it right, most others didn't, as far as I can  
recall.

> > and then every user-visible non-transient program
> > needs to implement it - and I don't see *that* happen in the next ten
> > years.
>
> Consider a patch for konqueror or a few other webpage/fs-view programs
> and you'll go a long way - all in userspace.

Well, Netscape *can* sort of do it (for one window).

But how do I make it happen for bash? login? xdm? Amd so on ... anyway, I  
simply don't have the time for such a project. I'm spread too thin as it  
is.

MfG Kai
