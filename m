Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318823AbSG0VU0>; Sat, 27 Jul 2002 17:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318825AbSG0VU0>; Sat, 27 Jul 2002 17:20:26 -0400
Received: from uucp.nl.uu.net ([193.79.237.146]:42429 "EHLO uucp.nl.uu.net")
	by vger.kernel.org with ESMTP id <S318823AbSG0VUZ>;
	Sat, 27 Jul 2002 17:20:25 -0400
Date: Sat, 27 Jul 2002 23:22:52 +0200 (CEST)
From: kees <kees@schoen.nl>
To: Adrian Bunk <bunk@fs.tum.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19.rc3 vs 2.4.17
In-Reply-To: <Pine.NEB.4.44.0207272130340.9592-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.33.0207272317540.4063-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 27 Jul 2002, Adrian Bunk wrote:

> On Sat, 27 Jul 2002, kees wrote:
>
> > Hi
> > I ran 2.4.19rc3 but my feeling is: Netscape 6.2 and (KDE3) Konqueror
> > showed a high number of spontaneous crashes. 256MB Ram xosview shows a few
> >...
>
> You say Netscape and Konqueror crash significantely more often when
> running 2.4.19-rc3 compared to running the same applications under 2.4.17?
>
> Let's try to track it down:
> - Do only Netscape/Konqueror crash or does X crash or does the whole
>   computer crash?

Only the apps, no X crash.

> - Is there any error message when the browsers crash, if yes which?
No messages
> - Are there any suspicious messages in /var/log/syslog or
>   /var/log/messages that might help in tracking this down?
No messages, taht was the fisrt thing I looked.
> - Is your 2.4.17 a plain ftp.kernel.org kernel or a kernel shipped by your
>   distribution?
Plain kernel from source tree
> - Do you apply any patches to your kernels?
Not this kernel(s)
> - Do you ever load non-free kernel modules like e.g. the one from NVidia?
No
>   If yes, are your problems reproducible if no non-free modules were
>   _ever_ loaded since the last reboot?
> - Is there anything "special" or unusual with your machine (is it a
>   laptop, root filesystem is on NFS or XFS, unusual hardware,...)?
SMP, MSI mobo
Nothing that I can think of. Viewing webpages just did crash the app. very
often , something that got away when switching back to 2.4.17
Java(?)
>
> > Kees
>
> cu
> Adrian
>
> --
>
> You only think this is a free country. Like the US the UK spends a lot of
> time explaining its a free country because its a police state.
> 								Alan Cox
>
>

