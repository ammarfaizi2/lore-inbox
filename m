Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154215-8316>; Sat, 12 Sep 1998 20:23:21 -0400
Received: from dialup202-2-52.swipnet.se ([130.244.202.116]:2183 "HELO braindamage.linux.bogus" ident: "qmailr") by vger.rutgers.edu with SMTP id <154200-8316>; Sat, 12 Sep 1998 20:22:53 -0400
Message-ID: <19980913052909.B194@braindamage.linux.bogus>
Date: Sun, 13 Sep 1998 05:29:09 +0200
From: Erik Elmgren <erik.elmgren@swipnet.se>
To: linux-kernel@vger.rutgers.edu
Subject: Re: RTO [was Re: my broken TCP is faster on broken networks [Re: Very poor TCP/SACK performance]]
Mail-Followup-To: linux-kernel@vger.rutgers.edu
References: <19980912201217.A13373@castle.nmd.msu.ru> <Pine.LNX.3.96.980912183333.578B-100000@dragon.bogus> <19980913034849.A194@braindamage.linux.bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <19980913034849.A194@braindamage.linux.bogus>; from Erik Elmgren on Sun, Sep 13, 1998 at 03:48:49AM +0200
X-Operating-System: Linux 2.1.120
X-Disclaimer: Speaking only for myself.
Sender: owner-linux-kernel@vger.rutgers.edu

Quoting Erik Elmgren (erik.elmgren@swipnet.se):
> Quoting Andrea Arcangeli (andrea@e-mind.com):
> > On Sat, 12 Sep 1998, Savochkin Andrey Vladimirovich wrote:
> > 
> > >I suppose you can find the algorithms in the bibliography at the end of
> > >the RFC. 
> > 
> > [TCP:6] "Round Trip Time Estimation," P. Karn & C. Partridge, ACM
> >      SIGCOMM-87, August 1987.
> > 
> > Which is the URL? ;-)
> 
> http://www.acm.org/pubs/articles/journals/tocs/1991-9-4/p364-karn/p364-karn.pdf

And to be utterly lame and correct myself, if you don't want to pay acm USD 10 to
see it, get it gratis at:

http://www.net-tech.bbn.com/craig/karn.ps

This time I actually downloded it..

--

Don't mess with the Net - it is bigger than you, and it bites.
--- David Gerard

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html
