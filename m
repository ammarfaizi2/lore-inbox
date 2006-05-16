Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWEPNsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWEPNsk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 09:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWEPNsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 09:48:39 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:20105 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751089AbWEPNsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 09:48:39 -0400
Date: Tue, 16 May 2006 09:48:25 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Marc Perkel <marc@perkel.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Wiretapping Linux?
In-Reply-To: <4469D296.8060908@perkel.com>
Message-ID: <Pine.LNX.4.58.0605160939290.10890@gandalf.stny.rr.com>
References: <4469D296.8060908@perkel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2006, Marc Perkel wrote:

> As most of you know the United States is tapping you telephone calls and
> tracking every call you make. The next logical step is to start tapping
> your computer implanting spyware into operating systems. Since Windows
> and OS-X are proprietary this can be done more easilly with the
> cooperation of Microsoft and Apple.
>
> So what about Linux? With thousands of people working on the Kernel if
> someone from the NSA wanted to slip a back door into the Kernel, could
> the do that?

Well, yes and no.

It's highly unlikely that it would get into the kernel. Definitely not
kernel.org, since all patches are public.

But it's not the kernel that you have to always worry about.  But it's
what you install.  Especially as root.

There's so much free stuff out there, that people download and install
blindly, that I'm sure if someone wanted to really badly, they could get
it on some boxes.  If they were slime and added something to a binary,
and supplied the source without the backdoor, that might last a while.
Unless you compile everything yourself, it's not easy to make sure that
all binaries came from the source you have.

But there are a lot of hackers out there (the good kind, not the crackers
that the press call "hackers").  And they are aways looking at things
and breaking them to see how they work.

So, really, I doubt anyone could really get a lot on lots of people's
Linux boxes.  But, if we ever had an evil Debian maintainer, that allowed
it, then it might happen.  But that would usually be discovered rather
quickly.

-- Steve

> I know it's open source and it could be found if anyone
> looks but is anyone looking? Is this something that would get noticed if
> someone tried to do it? I'd like to think it would, but I'm going to ask
> anyway just to make sure.
>
> Conversely, if Microsoft or Apple cooperated with the US government
> could they implant sptware without packets or hidden files being noticed?
>
> I'm in the process of writing some articles about it and want to raise
> the issue of US government implanted spyware everywhere. I know some
> people might think this a little off topic but I'd rather be safe than
> sorry. Who better to ask this question of than those who develop the kernel?
>
> Thanks in advance.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
