Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTLCWM2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 17:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbTLCWM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 17:12:28 -0500
Received: from chaos.analogic.com ([204.178.40.224]:13184 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262109AbTLCWLW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 17:11:22 -0500
Date: Wed, 3 Dec 2003 17:11:56 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Kendall Bennett <KendallB@scitechsoft.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <3FCDE5CA.2543.3E4EE6AA@localhost>
Message-ID: <Pine.LNX.4.53.0312031648390.3725@chaos>
References: <3FCDE5CA.2543.3E4EE6AA@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Dec 2003, Kendall Bennett wrote:

> Hi All,
>
> I have heard many people reference the fact that the although the Linux
> Kernel is under the GNU GPL license, that the code is licensed with an
> exception clause that says binary loadable modules do not have to be
> under the GPL. Obviously today there are vendors delivering binary
> modules (not supported by the kernel maintainers of course), so clearly
> people believe this to be true. However I was curious about the wording
> of this exception clause so I went looking for it, but I cannot seem to
> find it. I downloaded the 2.6-test1 kernel source code and looked at the
> COPYING file, but found nothing relating to this (just the note at the
> top from Linus saying user programs are not covered by the GPL). I also
> looked in the README file and nothing was mentioned there either, at
> least from what I could see from a quick read.
>
> So does this exception clause exist or not? If not, how can the binary
> modules be valid for use under Linux if the source is not made available
> under the terms of the GNU GPL?
>

I'll jump into this fray first stating that it is really great
that the CEO of a company that is producing high-performance graphics
cards and acceleration software is interested in finding out this
information. It seems that some other companies just hack together some
general-purpose source-code under GPL and then link it with a secret
object file. This, of course, defeats the purpose of the GPL (which is
or was to PUBLISH software in human readable form).

It is certainly time for a definitive answer.

Maybe Linus knows the answer.

> Lastly I noticed that the few source code modules I looked at to see if
> the exception clause was mentioned there, did not contain the usual GNU
> GPL preable section at the top of each file. IMHO all files need to have
> such a notice attached, or they are not under the GNU GPL (just being in
> a ZIP/tar achive with a COPYING file does not place a file under the GNU
> GPL). Given all the current legal stuff going on with SCO, I figured
> every file would have such a header. In fact some of the files I looked
> at didn't even contain a basic copyright notice!!
>

I have been told by lawyers who do intellectual property
law for a living that under US Copyright law, the INSTANT
that something is written anywhere in a manner that allows
it to be read back, it is protected by the writer's default
copyright protection. The writer may alter that protection or
even assign ownership to something or somebody else, but nobody
needs to  put a copyright notice anywhere in text. Now, if you
intend to sue, before that suit starts, the text must be registered
with the United States Copyright Office. In that case, it still
doesn't need a copyright notice or the famous (c) specified by
the act. It just needs to be identified by the writer, like:

File:     TANGO.FOR        Created 12-DEC-1988     John R. Doe

Grin... from my VAX/VMS days.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


