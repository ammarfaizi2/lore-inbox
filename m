Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbTLJQJf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 11:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263667AbTLJQJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 11:09:35 -0500
Received: from chaos.analogic.com ([204.178.40.224]:45696 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263679AbTLJQJT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 11:09:19 -0500
Date: Wed, 10 Dec 2003 11:10:59 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jesse Pollard <jesse@cats-chateau.net>
cc: Paul Zimmerman <zimmerman.paul@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <03121008171001.31567@tabby>
Message-ID: <Pine.LNX.4.53.0312101106390.3252@chaos>
References: <000701c3be1c$8a3cfbc0$0301a8c0@comcast.net> <03121008171001.31567@tabby>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Dec 2003, Jesse Pollard wrote:

> On Tuesday 09 December 2003 00:20, Paul Zimmerman wrote:
> > [ Date:  Sometime in the near future. ]
> >
> [snip]
> >
> > [ Cut to:  Bedroom of a comfortable house in the suburbs.  Nighttime. ]
> >
> > [ Linus - suddenly sits bolt upright in the bed, a horrified expression on
> > his face: ]  "AAAAiiiiiiieeeeeeeeaaaaaaarrrrrrgggggghhhhhh!!!!"
> >
> > [ Wife - shaking Linus' shoulder: ]  "Honey, wake up, wake up!  I think
> > you're having that horrible nightmare again!"
> >
> > And that is why binary drivers will always be allowed under Linux.
>
> If that were the problem, then the kernel would be LGPL, and not GPL. LGPL
> permits linking (shared libraries), GPL doesn't. To me, it boils down to:
>
> Link with GPL -> result is GPL.
> Link with LGPL shared libraries -> result may be anything.


I don't understand how so much time, effort, and bandwidth
can be wasted on Richard Stallman's pet project. The Linux
kernel is not about GPL. It's about writing and modifying
a high performance operating system that has published
source-code.

This allows each and every contributor to demonstrate his
or her capabilities in their chosen area of expertise. This
gives ideal visibility and demonstrates competence in an
area that is replete with charlatans calling themselves
programmers.

Already, GPL is preventing this! It started to become evident
when Mr. Stallman took credit for the entire operating system
and all its utilities. If you don't remember that one, you
haven't been awake. He demanded that it be called GNU/Linux,
remember?  This was the first part of the "divide and conquer"
methods that have been used for thousands of years to destroy
whole civilizations. This caused a lot of contributors to
back off and attempt to isolate their work from the work of
others. These factions started to divide up various components
including, of all stupid things, header files, and claim that
they don't want anybody using their work unless it's under
their explicit terms.

I will now cite some information about US copyright law. This
information was provided by an "interested third party" who
practices intellectual property law. It is not legal advice
and is only an opinion. Much of this opinion can be gleaned
from "The law of Computer Technology", Raymond, T. Nimmer;
Waren, Gorham & Lamont, Inc. ISBN 0-88712-355-4.

The Linux kernel is not an unpublished private work. It has
been published for many years. Because it has been published,
anybody can use its published components in the manner
historically reserved for published works. In other words,
you cite your references when you use these published works.

Anybody who commits anything to writing in a manner allowing
it to be read back is, in the United States, entitled to
the protection of copyright law. One of the protections
afforded to the original writer is the ability to control
the use of that written work. However, there are limitations
set forth by the law. One of the limitations is that the
conditions must be "enforceable". Once you publish a work,
there are very few things that remain enforceable.

This is because a published work becomes public. That's what
publish means. So, all of the information within the kernel
becomes public information. Public information is information
that is "owned" by everybody (or nobody, depending upon your
perspective). The mere act of publishing a work revokes
ownership of the information content of that work.  The
author no longer owns the information because he/she has
given it to the public by the act of publishing. This limits
what may be considered enforceable. In general, the courts
have allowed considerable inclusion of copy-written published
works into new works, as long as text has not been inserted
"whole cloth".

As previously shown, "#include <kernel.h>" was not a consideration
when copyright law was written. In fact, copyright law is poorly
suited to software. However, in general, including a header
file in software is done to insert information into the work.
This information is already public, having come from a published
work. It is unlikely that any court would consider restricting
this inclusion of information as being enforceable under current
law.

If you work for a company and writing software is your job,
then you probably have a "standard" header file that your
company requires you to use, something like this:

/*
 *     ##################################################################
 *     #                                                                #
 *     #  Copyright(C) 1999 - 2003,  CatFart Corporation.   All rights  #
 *     #  reserved worldwide.                                           #
 *     #                                                                #
 *     #  This  document contains information proprietary  to CatFart   #
 *     #  Corporation.  If this product is acquired by or on behalf of  #
 *     #  a unit or agency of the United States Government the follow-  #
 *     #  ing applies: (a) This product was not developed with govern-  #
 *     #  ment funds;  (b) is a  trade secret of  CatFart Corporation   #
 *     #  for all purposes of the Freedom of Information Act;  and (c)  #
 *     #  is "Commercial Computer Software".  For units of the Depart-  #
 *     #  ment of Defense (DoD),  this software is  provided only with  #
 *     #  "Restricted Rights"  as defined in the DoD supplement to the  #
 *     #  Federal Acquisition Regulations, 52.227-7013(c)(I)(ii). Use,  #
 *     #  duplication,  or disclosure  is  subject to the restrictions  #
 *     #  set forth in subdivision (c)(ii)  of the Rights in Technical  #
 *     #  Data and Computer Software clause at 52-227-7013.             #
 *     #                                                                #
 *     #  Use, duplication, or disclosure of this proprietary document  #
 *     #  without  the express permission of  CatFart  Corporation is   #
 *     #  prohibited.                                                   #
 *     #                                                                #
 *     ##################################################################
 */

This shows that the software contained within is highly-restricted.
This restriction remains because this document is unpublished. It
is an unpublished, private work of CatFart. Therefore any use or
disclosure is enforceable. To publish this information, requires
that I obtain the permission of CatFart. Just to be safe, I need
to state,  "Reproduced by permission of CatFart Corporation", any
time I reference the contents of this document. Wanna register
CatFart.com?

Once I publish the contents of this document, the statement in the
header is moot (invalid). You can't have it both ways. You either
have an unpublished private document that may contain secret
information or you have a public document that contains no
secrets whatsoever.

Note that I just gave away "CatFart.com" by publishing this
information. That's what "publish" means.

Given that the publishing of a work gives away the information
in that work, one may wonder why anybody publishes anything.
But that's a topic for a whole new discussion, hopefully, not
in the Linux-Kernel list.

Developers need to back off and stop getting hot-under-the-collar
about things that are quite beyond their control. Neither SCO,
IBM, nor Stallman can take credit for your work although they
may try. You need to make it easy for others to use your work
so that it remains visible. Your own perspective should grow
with the proliferation of Linux, not collapse into a tunnel-
vision of; "They ain't gonna use my stuff...". There is a lot
of truth to the adage, "Publish or perish.". You chose to
contribute to a published work, great!  Now, don't pretend
that you own it. You did, after all, contribute it to the
greater good of all, hoping so put M$ and other pretenders
to shame.

This EXPORT_SYMBOL_GPL stuff is absurd. Anybody who knows how to
link object files together can bypass any attempted "protections"
altogether. There is entirely too much of this crap going
on. Surely, one needs to know if there is some unpublished
binary lurking in the kernel that could be screwing up the
works, but beyond that playing with symbols simply makes
the developers look like fools.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


