Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVAICb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVAICb5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 21:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbVAICb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 21:31:57 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:7415 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262242AbVAICbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 21:31:53 -0500
Subject: Re: starting with 2.7
From: "M. Edward Borasky" <znmeb@cesmail.net>
Reply-To: znmeb@cesmail.net
To: John Richard Moser <nigelenki@comcast.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41DEC5F1.9070205@comcast.net>
References: <1697129508.20050102210332@dns.toxicfilms.tv>
	 <41DD9968.7070004@comcast.net>
	 <1105045853.17176.273.camel@localhost.localdomain>
	 <1105115671.12371.38.camel@DreamGate>  <41DEC5F1.9070205@comcast.net>
Content-Type: text/plain
Date: Sat, 08 Jan 2005 18:31:50 -0800
Message-Id: <1105237910.11255.92.camel@DreamGate>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-07 at 12:25 -0500, John Richard Moser wrote:

> Try /join #hardened-gentoo and ask about how stable 2.6 is once.  The
> hardened team has been having a hard time because 2.6 keeps changing.
> 
> I was told that gentoo-dev-sources and hardened-dev-sources will become
> gentoo-sources and hardened-sources when they're considered stable.
> They're still -dev.  What does this tell you?
> 
> <@tseng> stable? sometimes
> <@tseng> production, nope.

Well, the story I'm hearing on the Gentoo mailing lists (I don't
frequent IRC) is that the next Gentoo release, which is scheduled for
sometime this month (Jan 2005) will be 2.6-based, although, like all
Gentoo releases, you will be able to customize it to 2.4 if that's what
you want and/or need to do. There is some pushback from those who fear
2.6 isn't ready for prime time. I think 2.6 is winning and will prevail.

Gentoo is admittedly an "expert's" distro and I am admittedly biased
towards it. But there are simply too many things that aren't *ever*
going to get done in 2.4, especially with RHEL 4 being 2.6-based. I held
off on 2.6 because of a few minor glitches -- a touchy touchpad on the
laptop and some difficulties with dhcpcd picking up an IP address from
my cable modem were the worst ones. They're fixed now, and 2.6.10 has
the best audio latency performance "out of the box" ever for a Linux
kernel, and I had a three-day weekend -- case closed! Hooray for 2.6!
Long Live 2.6! 2.6 or Fight! Give Me 2.6 Or Give Me Death! :)

> I wouldn't recommend it to businesses, because a fuck-up means they lose
> money.  You ever see a production server go down?  You can totally wipe
> out a business that way.  If a glitch trashes the filesystem, you might
> as well stop trying.  Unless of course you can ship your off-site
> backups back on-site and restore the whole damn thing to working order
> within 3 days.  Better hope the kernel you were using when it was
> working is in the backups.

A poorly managed IT operation can wipe out a business, whether the
"production server" is Windows-based, RHEL-based, Tru64-based,
Solaris-based, "woody"-based or Gentoo-based. Much as I hate Windows, I
work in a company with a Windows-based IT infrastructure, and I go out
of my way to help them keep it safe and productive, despite my obvious
Linux bias. That's part of being a good corporate citizen.

Are you claiming that a 2.4-kernel-based IT infrastructure has less need
for **competent** security, privacy, performance and data integrity
policies, procedures and people than a 2.6-kernel-based one, all other
things being equal?

> | Given all that, what about 2.6 and 2.7? Here's where I break away from
> | the mainstream -- big-time. I'd like to see 2.6 live forever as the
> | "stable general purpose kernel of choice for multiple architectures"
> | that it is today. And I'd like to see the broad "kernel community" move
> | to a 64-bit-only microkernel-based "GNU/Whatever".
> 
> Dreamer.

Exactly! I am a dreamer, and proud of it! I want a nice 64-bit real-time
lab/studio for algorithmic composition and synthesis of music. I want
something that can address memory over a gigabyte without contorting the
memory management into a bizarre scheme reminiscent of the "good old
days" when one had to run big programs in little machines using (gag,
retch) overlays!

Are you aware how large 2^64 - 1 is? Don't they teach the old fable
about grains of rice on the chessboard any more? :) Please don't make me
go back to the days when Thomas Watson said there was a world-wide
market for ten to twelve computers, or when Ken Olsen asked why anyone
would want a computer in their home! Please don't make me use a LISP or
R or whatever language that can't handle a data structure larger than
2^32 - 1! Please don't make me talk to my computer in 7-bit code on a
300-baud modem! Is this the 21st century? Am I the *only* dreamer?

> Linus hates microkernels :o

When Linus chose the "monolithic yet modular" approach for Linux over
the microkernel approach, the state of the art in compilers and hardware
was on his side. We're talking 386, GCC 1, right? It was the correct
decision. I don't think he "hates" microkernels (Linus, correct me if
I'm wrong :), he simply made an implementation decision to go another
way. Again, I'm a dreamer. :)

By the way, I never owned a 286 or 386. I went straight from 80186/DOS
5.0 to a Pentium MMX running Windows 95. I missed out on a lot of fun,
eh?

