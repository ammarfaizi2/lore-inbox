Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267882AbTAMRER>; Mon, 13 Jan 2003 12:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267884AbTAMRER>; Mon, 13 Jan 2003 12:04:17 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:16857 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S267882AbTAMREP> convert rfc822-to-8bit; Mon, 13 Jan 2003 12:04:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: root@chaos.analogic.com, Richard Stallman <rms@gnu.org>
Subject: Re: Nvidia and its choice to read the GPL "differently"
Date: Mon, 13 Jan 2003 11:09:48 -0600
User-Agent: KMail/1.4.1
Cc: R.E.Wolff@BitWizard.nl, jalvo@mbay.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.3.95.1030113091004.20746A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1030113091004.20746A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301131109.48727.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 January 2003 08:32 am, Richard B. Johnson wrote:
[snip]
> As previously shown, most of the programs that "come with" Linux,
> and therefore are part of the "Operating System" to which you lay
> claim, were developed by students at the University of California,
> Berkeley. They even contain a Copyright notice, embedded in the
> executable files. Anybody can do:
>
> 		strings /usr/bin/* | grep Regents
> 		strings /bin/* | grep Regents
>
> ...and see all the copyright notices embedded in the programs to
> which you now claim credit.

And by my count (RH 7.3) that comes to 52 for /usr/bin/*
of those 52:

	rdist has 12 entries of its' own.
	rdistd has 7 more.

The majority of the comands deal with mail(7), and postgres (8).
Of the compiling ones: lex and yacc show one each, gprof has two.

The rest all have one reference.

Of these only those dealing with the network (telnet, ftp rdist,rdistd...) 
would be considered part of the core utilities - and even then they are
discouraged in use (weak security).

The rest of the files (3080) do not have a BSD base.

In /bin/* I find only 4. /bin/csh, /bin/mail, /bin/ping and /bin/tcsh.
Of these I only consider /bin/ping  a core utility.


In my opinion, that is not enough to claim a BSD foundation.
-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
