Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155016AbPFKJ07>; Fri, 11 Jun 1999 05:26:59 -0400
Received: by vger.rutgers.edu id <S154844AbPFKJ0s>; Fri, 11 Jun 1999 05:26:48 -0400
Received: from styx.cs.kuleuven.ac.be ([134.58.40.3]:52011 "EHLO styx.cs.kuleuven.ac.be") by vger.rutgers.edu with ESMTP id <S154807AbPFKJ0Z>; Fri, 11 Jun 1999 05:26:25 -0400
Date: Fri, 11 Jun 1999 11:26:09 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Denis Oliver Kropp <dok@fischlustig.de>
cc: LKML <linux-kernel@vger.rutgers.edu>
Subject: Re: FBIO_COPYBOX, FBIO_RECTFILL
In-Reply-To: <99060823022501.00994@master>
Message-ID: <Pine.LNX.4.10.9906111124590.19262-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Tue, 8 Jun 1999, Denis Oliver Kropp wrote:
> I like fbdev very well, but I would apreciate a method
> for hardware blits and fills.
> Would be very easy to add this functionality to fbcon.
> I tested it with matroxfb.
> E.g. ClanLib that uses fbdev would be times faster.
> 
> Any oppinions?

Generic hardware blits do not belong in the kernel.

Reasoning: http://www.cs.kuleuven.ac.be/~geert/Linux/Expo/.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
