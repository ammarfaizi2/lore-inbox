Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268140AbTAMSgr>; Mon, 13 Jan 2003 13:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268171AbTAMSgq>; Mon, 13 Jan 2003 13:36:46 -0500
Received: from chaos.analogic.com ([204.178.40.224]:31621 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268140AbTAMSgk>; Mon, 13 Jan 2003 13:36:40 -0500
Date: Mon, 13 Jan 2003 13:48:11 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jesse Pollard <pollard@admin.navo.hpc.mil>
cc: Richard Stallman <rms@gnu.org>, R.E.Wolff@BitWizard.nl, jalvo@mbay.net,
       linux-kernel@vger.kernel.org
Subject: Re: Nvidia and its choice to read the GPL "differently"
In-Reply-To: <200301131137.29161.pollard@admin.navo.hpc.mil>
Message-ID: <Pine.LNX.3.95.1030113131540.27345A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003, Jesse Pollard wrote:

> On Monday 13 January 2003 11:22 am, Richard B. Johnson wrote:
> [snip]
> >
> > The early Ygddrasil distributions, of which I posted the 'grep'
> > several days ago, show that most of the files are BSD based.
> >
> > I attach it here for your pleasure.
> 
> Ummm you did a "strings *" twice in the /usr/bin directory....
> 

Actually not. I don't know why the "cd to /usr/sbin" didn't show.
Maybe a buffer overflow in `script` ?

Anyway, the point was that GNU made tools in those days. These
tools were useful in porting existing programs (like the BSD programs)
to new environments, including the, then new Linux. Linus was still
in Helsinki at the time.

GNU continued to develop new programs and improve their 'C' compiler.
GNU also started a development program called "HURD". This was
supposed to be the great operating system of the future, completely
free and open. This OS used "Mach 4", not Linux, as its kernel.
This was based upon the BSD "Lite" kernel. In fact a lot of things
that GNU has done is based upon BSD student's original work.

I'm certain that a lot of work was done porting the typical Unix
programs to HURD. Eventually, HURD had everything that Linux and
BSD already had, except for the reputation. Few persons even knew
of the operating system. In the meantime, Linux was recognized by
Fortune 500 companies like IBM. Eventually, Linux got a lot of
help from those companies as well. IBM pays some employees to
work on Linux. The same for some other important companies.

Since HURD didn't get much press, it was certainly unfair. However,
this doesn't give GNU, RMS, or the HURD developers any right to
claim that Linux is "GNU/Linux". It should give them the incentive
to get some decent press for their own hard work such as HURD.
They should be attempting to get distributors to market their
products instead of attempting to rewrite history and claim
credit for somebody else's work.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


