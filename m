Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130579AbRAWSoV>; Tue, 23 Jan 2001 13:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131388AbRAWSoL>; Tue, 23 Jan 2001 13:44:11 -0500
Received: from site3.talontech.com ([208.179.68.88]:12881 "EHLO
	site3.talontech.com") by vger.kernel.org with ESMTP
	id <S130579AbRAWSoB>; Tue, 23 Jan 2001 13:44:01 -0500
Message-ID: <3A6D602B.E0A3BD22@talontech.com>
Date: Tue, 23 Jan 2001 02:42:51 -0800
From: Ben Ford <bford@talontech.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: David Ford <david@linux.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-test10
In-Reply-To: <Pine.LNX.4.10.10101221711560.1309-100000@penguin.transmeta.com> <3A6CF5B7.57DEDA11@linux.com> <3A6D2D54.619AFA7E@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> David Ford wrote:
> >
> > Linus Torvalds wrote:
> >
> > > The ChangeLog may not be 100% complete. The physically big things are the
> > > PPC and ACPI updates, even if most people won't notice.
> > >
> > >                 Linus
> > >
> > > ----
> > >
> > > pre10:
> > >  - got a few too-new R128 #defines in the Radeon merge. Fix.
> > >  - tulip driver update from Jeff Garzik
> > >  - more cpq and DAC elevator fixes from Jens. Looks good.
> > >  - Petr Vandrovec: nicer ncpfs behaviour
> > >  - Andy Grover: APCI update
> > >  - Cort Dougan: PPC update
> > >  - David Miller: sparc updates
> > >  - David Miller: networking updates
> > >  - Neil Brown: RAID5 fixes
> >
> > Do the tulip driver updates address the increasingly common NETDEV timeout
> > repots?
>
> In general you can answer this yourself by reading
> drivers/net/tulip/ChangeLog.
>
> I don't see increasingly common timeout reports.. with which hardware?
> They are likely on the newer LinkSys 4.1 cards, and there are still
> problesm with PNIC.  Outside of that, other cards should be ok.
>

I have this problem also.

I have several machines that are almost unuseable due to the network device.  I
need to do an ifconfig down/up to get connectivity back again.  That doesn't
work so handy for a headless router . . . .

My desktop machine (2.3.9x - present) has dropped the network 4 or 5 times a day
for months.

-b


>
>         Jeff
>
> --
> Jeff Garzik       | "You see, in this world there's two kinds of
> Building 1024     |  people, my friend: Those with loaded guns
> MandrakeSoft      |  and those who dig. You dig."  --Blondie
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
