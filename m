Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265214AbUD3OtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265214AbUD3OtN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 10:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUD3OtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 10:49:13 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:49379 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265214AbUD3OtJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 10:49:09 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Peter Williams <peterw@aurema.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Fri, 30 Apr 2004 16:49:56 +0200
User-Agent: KMail/1.5.3
Cc: Marc Boucher <marc@linuxant.com>, Sean Estabrooks <seanlkml@rogers.com>,
       Linus Torvalds <torvalds@osdl.org>, Paul Wagland <paul@wagland.net>,
       Rik van Riel <riel@redhat.com>, Timothy Miller <miller@techsource.com>,
       koke@sindominio.net, Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Gibson <david@gibson.dropbear.id.au>
References: <Pine.LNX.4.44.0404291114150.9152-100000@chimarrao.boston.redhat.com> <200404300618.37718.bzolnier@elka.pw.edu.pl> <4091D6D4.8070507@aurema.com>
In-Reply-To: <4091D6D4.8070507@aurema.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404301649.56477.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 of April 2004 06:32, Peter Williams wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Friday 30 of April 2004 04:15, Marc Boucher wrote:
> >>Dear Sean,
> >>
> >>On Apr 29, 2004, at 7:55 PM, Sean Estabrooks wrote:
> >>>Perhaps others on this list are getting as tired as I am of your using
> >>>the term "religious bias" as a negative connotation against people who
> >>>support and protect the open source nature of Linux.   Maybe you could
> >>>at least pretend to respect the people who you supposedly apologized
> >>>to.
> >>
> >>I not only highly respect Rusty but have closely worked and been
> >>friends with him for several years. The same applies to several other
> >>kernel developers.
> >>
> >>Please don't get me wrong. We are entirely for the open-source nature
> >>of Linux, and I have been personally contributing for the last 15 years
> >>to many open-source projects (for examples, see the AUTHORS section of
> >>"man iptables", or search google for my previous email addresses
> >>marc@mbsi.ca & marc@cam.org to get more historical background).
> >
> > Well, people change over time.  8)
> >
> > from http://www.linuxant.com/driverloader/
> >
> > "DriverLoader technology is the ideal Linux solution to support devices
> > for which no adequate native open-source drivers are available. It also
> > allows vendors to drastically reduce time to market or eliminate the need
> > to support multiple drivers for Windows and Linux. By using the same
> > driver on both platforms, significant resources can be saved."
> >
> > Rusty was right.
>
> Why did you omit the next paragraph (which completes the story):
>
> "We have attempted to reduce the inconvenience of binary-only drivers by
> separating the proprietary code from the operating-system specific code.
> The latter is provided in source form, allowing users to install the
> drivers under any supported version (2.4 or later) of the Linux kernel."

It is unimportant here, using GPL-ed wrappers to load
closed-source drivers is like using LILO to boot Windows. ;)

Open-source drivers are one of the fundamental advantages
of Linux and drivers are part of operating system.

Splitting driver by "separating the proprietary code from the
operating-system specific code." weakens this advantage.

There is a question about integrity when you say that you promote
open-source nature of Linux but you don't promote open-source drivers.

Regards,
Bartlomiej

