Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267462AbRGLKGo>; Thu, 12 Jul 2001 06:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267464AbRGLKGe>; Thu, 12 Jul 2001 06:06:34 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:10506 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S267462AbRGLKGZ>; Thu, 12 Jul 2001 06:06:25 -0400
Message-ID: <3B4D7685.9AC1DED@idb.hist.no>
Date: Thu, 12 Jul 2001 12:05:57 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7-pre6 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Kai Henningsen <kaih@khms.westfalen.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Switching Kernels without Rebooting?
In-Reply-To: <Pine.LNX.4.33.0107112310590.962-100000@fogarty.jakma.org> <Pine.LNX.4.33L.0107111913010.9899-100000@imladris.rielhome.conectiva> <84jaVrwXw-B@khms.westfalen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Henningsen wrote:

> What I'd *really* like (but don't see how to get there) would be a "save
> system state, shutdown, change kernel and/or hardware, reboot, restore
> state" system (where state is like "I'm logged in on this console, in this
> current directory, and under X I have Netscape running and this page
> displayed" but I don't care about the exact state of Squid or even if my
> ISDN line is dialled in, because those "fix themselves").

Consider os/2 then.  All workplace-shell aware programs is supposed to
save
state in this way.  And yes - they do start up in the same state after
reboot if you want to.  Editors come up on the page you left, filesystem
folders comes up, and so on.  

> and then every user-visible non-transient program
> needs to implement it - and I don't see *that* happen in the next ten
> years.

Consider a patch for konqueror or a few other webpage/fs-view programs
and you'll go a long way - all in userspace.

Helge Hafting
