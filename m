Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <156653-7620>; Wed, 5 Aug 1998 21:25:01 -0400
Received: from diala156.ppp.lrz-muenchen.de ([129.187.24.156]:1052 "HELO fred.muc.de" ident: "TIMEDOUT2") by vger.rutgers.edu with SMTP id <154887-7620>; Wed, 5 Aug 1998 19:46:57 -0400
Message-ID: <19980806012318.B530@kali.lrz-muenchen.de>
Date: Thu, 6 Aug 1998 01:23:18 +0200
From: Andi Kleen <ak@muc.de>
To: linker@z.ml.org, Andi Kleen <ak@muc.de>
Cc: Fredrik Sjoholm <fsjoholm@netspeak.com>, linux-kernel@vger.rutgers.edu
Subject: Re: new networking code, ipv4/arp.c and net/core/neighbour.c
References: <k2k95386w8.fsf@zero.aec.at> <Pine.LNX.3.96.980805144952.12731B-100000@z.ml.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.3.96.980805144952.12731B-100000@z.ml.org>; from linker@z.ml.org on Wed, Aug 05, 1998 at 08:50:31PM +0200
Sender: owner-linux-kernel@vger.rutgers.edu

On Wed, Aug 05, 1998 at 08:50:31PM +0200, linker@z.ml.org wrote:
> On 24 Jul 1998, Andi Kleen wrote:
> [snip]
> > 
> > The traffic shaper is obsolete and replaced by CBQ or TBF.
> > 
> > -Andi
> 
> Want to point use to docs on how to use this? (and the needed software)

Documentation is non existent so far (except for the original CBQ papers 
from LBL and the extensive comments in the source code)

Needed software is iproute - at ftp.inr.ac.ru:/ip-routing/

-Andi



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
