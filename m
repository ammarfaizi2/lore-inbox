Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290594AbSAYHs6>; Fri, 25 Jan 2002 02:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290596AbSAYHst>; Fri, 25 Jan 2002 02:48:49 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:8703 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S290594AbSAYHsi> convert rfc822-to-8bit;
	Fri, 25 Jan 2002 02:48:38 -0500
Date: Fri, 25 Jan 2002 02:48:37 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Timothy Covell <timothy.covell@ashavan.org>
cc: Xavier Bestel <xavier.bestel@free.fr>, Robert Love <rml@tech9.net>,
        Oliver Xymoron <oxymoron@waste.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
In-Reply-To: <200201250720.g0P7KeL09793@home.ashavan.org.>
Message-ID: <Pine.GSO.4.21.0201250244070.23657-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Jan 2002, Timothy Covell wrote:

> > > le sam 26-01-2002 à 00:09, Timothy Covell a écrit :
> > > >         char x;
> > > >
> > > >         if ( x )
> > > >         {
> > > >                 printf ("\n We got here\n");
> > > >         }
> > > >         else
> > > >         {
> > > >                 // We never get here
> > > >                 printf ("\n We never got here\n");
> > > >         }
> > > >         exit (0);

> I realize that '\0' is a legit character.

Then I am at loss - WTF did you mean in the code (and comments) above?

Seriously, learn C.  The fact that you don't understand it is _your_
problem - l-k is not a place to teach you the langauge.

