Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265410AbTFMPII (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 11:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265411AbTFMPIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 11:08:07 -0400
Received: from [65.39.167.210] ([65.39.167.210]:25507 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S265410AbTFMPIE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 11:08:04 -0400
Date: Fri, 13 Jun 2003 11:19:51 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
To: =?iso-8859-1?q?Terje=20F=E5berg?= <terje_fb@yahoo.no>
cc: John Bradford <john@grabjohn.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Real multi-user linux
In-Reply-To: <20030613140111.34979.qmail@web12901.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0306131117280.5168-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jun 2003, Terje Fåberg wrote:
> John Bradford <john@grabjohn.com> skrev:
>
> > This idea has come up before, have a look at:
> >  http://marc.theaimsgroup.com/?.....
>
> Thank you for providing these references.  Especially
> the first thread discusses some thoughts I had, too.
>
> To summarize: People have thought about of one linux
> box directly supporting multiple (X-)consoles before.
> But this is not possible as of now, because X would
> have to be told to stop switching consoles and because
> the kernel cannot activate more than one console at
> one time. Additionately, multiple video cards may
> require mappings into the same memory area for certain
> functions. Some people have started to work on  a
> solution, but these projects were orphaned.
>
> My motivation is simply a private one.  I have a
> P3-866 with 1.5G RAM and a scsi raid here which serves
> its own console and an old P133 as X terminal.
> Although this machine is already some kind of
> outdated, it has plenty of power to serve two users
> with one KDE session each.
>
> I started to think about this, because the P133 died
> away due to a failing processor fan. Although
> replacing the whole machine with a similar one
> probably is cheaper than a good usb keyboard and
> mouse, it is also a question of comfort. No waiting
> for the terminal to boot up, no double administration,
> less power consumption, less space needed and so on.
>
> Although I have some C/C++ expirience, I have
> absolutely no clues about kernel and or X internals,
> so I guess I have to forget this for now.

You can gain most of those advantages by using the machine as a terminal
server.  http://neoware.com has solid state(fanless) clients.   So you
still get the lower admin costs and a nice quiet office.  Hopefully
someone else will reply with an even cheaper thin client.

	Gerhard



--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

