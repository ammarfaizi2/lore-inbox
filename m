Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <155526-18252>; Thu, 19 Nov 1998 12:57:02 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:4762 "EHLO math.psu.edu" ident: "root") by vger.rutgers.edu with ESMTP id <156019-18252>; Thu, 19 Nov 1998 08:08:20 -0500
Date: Thu, 19 Nov 1998 09:04:37 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Manuel J. Galan" <manolow@step.es>
cc: root@chaos.analogic.com, Linux Kernel List <linux-kernel@vger.rutgers.edu>
Subject: [OFFTOPIC] Re: Linux-asm (was A patch for linux 2.1.127)
In-Reply-To: <3652D8AF.52285D5C@step.es>
Message-ID: <Pine.SOL.3.95.981119085051.25055A-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu



[sorry for over-the-head reply, but I missed Richard's posting]
On Wed, 18 Nov 1998, Manuel J. Galan wrote:

> "Richard B. Johnson" wrote:
> > 
> > On Tue, 17 Nov 1998, Manuel J. Galan wrote:
> > 
> > > Some common places and/or common sense:
> > >
> > > * UNIX was built on C and C was built for UNIX.
> > >
> > 
> > Unix was built on a Digital PDP-11/34, using tools available
> > in the RSX-11 Digital Operation system. Most of the 'hardware stuff'
> > was done in DEC MACRO Assembly under RSX-11.

Bull. Original development went _for_ PDP-7 on GE-645. OS was either GCOS
or Multics. When they switched to -11 they bootstrapped their own
assembler (BTW, they didn't have RSX around).

> > 'C' came later.

Right. Original beast is circa '69, C - '73.

> > > * UNIX/C were devised with portability in mind.
> > >
> > 
> > Unix and C are not the same thing. Once Unix was running, a
> > 'C' compiler was built (from the ideas of 'B') so that the
> > machine would not have to be rebooted to get at the DEC tools
> > to continue development.

	Bullshit. They had assembler waay before C. Read v1 user manual.
It's Nov 3rd, 1971. Two years before C. as(1) is there. The system was
_NOT_ double-booting UNIX/RSX. BTW, IIRC RSX appeared a bit later than
UNIX (sorry, last time I looked into RSX manuals was 9 years ago).
	Look at the www.cs.bell-labs.com/~dmr and poke around there.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
