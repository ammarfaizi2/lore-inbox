Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154184-14493>; Mon, 30 Nov 1998 00:36:17 -0500
Received: from vindaloo.atnf.CSIRO.AU ([130.155.198.47]:1064 "HELO vindaloo.atnf.CSIRO.AU" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with SMTP id <154170-14493>; Mon, 30 Nov 1998 00:35:48 -0500
Date: Mon, 30 Nov 1998 18:28:13 +1100
Message-Id: <199811300728.SAA02191@vindaloo.atnf.CSIRO.AU>
From: Richard Gooch <rgooch@atnf.csiro.au>
To: Billy Harvey <Billy.Harvey@thrillseeker.net>
Cc: Stefan Monnier <monnier+lists/linux/kernel/news/@tequila.cs.yale.edu>, linux-kernel@vger.rutgers.edu
Subject: Re: [PATCH] APM fixes, workarounds and tidying
In-Reply-To: <3661946D.5EEB352F@thrillseeker.net>
References: <"JS82M1.0.fn2.8_KOs"@tequila.cs.yale.edu> <5l1zmmzany.fsf@tequila.cs.yale.edu> <3661946D.5EEB352F@thrillseeker.net>
Notfrom: spamlog@atnf.csiro.au
Sender: owner-linux-kernel@vger.rutgers.edu

Billy Harvey writes:
> Stefan Monnier wrote:
> > 
> > >>>>> "Richard" == Richard Gooch <rgooch@atnf.csiro.au> writes:
> > > +  is stored in the RTC so it can update the system clock (which is
> > > +  always GMT).
> > 
> > This is nitpicking, but the system time is generally considered as UTC rather
> > than GMT.  Not that I know of any difference.
> 
> 
> http://www.bldrdoc.gov/timefreq/glossary.htm is a good source of
> definitions.  GMT was "committeed" away, and so is no longer a
> politically correct statement.  I've always preferred the term Zulu,
> based on personal background.

Based on my personal background, I'll stick with the bigoted "GMT" :-)
The committee will just have to live with my conservatism...

				Regards,

					Richard....

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
