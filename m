Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129572AbQKGWiO>; Tue, 7 Nov 2000 17:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129624AbQKGWiG>; Tue, 7 Nov 2000 17:38:06 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:63494 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129572AbQKGWiA>; Tue, 7 Nov 2000 17:38:00 -0500
Message-ID: <3A08830E.F714C90E@timpanogas.org>
Date: Tue, 07 Nov 2000 15:32:46 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Josefsson <gandalf@wlug.westbo.se>
CC: Tigran Aivazian <tigran@veritas.com>, Anil kumar <anils_r@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4
In-Reply-To: <Pine.LNX.4.21.0011072328050.22346-100000@tux.rsn.hk-r.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So how come NetWare and NT can detect this at run time, and we have to
use a .config option to specifiy it?  Come on guys.....

Jeff

Martin Josefsson wrote:
> 
> On Tue, 7 Nov 2000, Tigran Aivazian wrote:
> 
> > On Tue, 7 Nov 2000, Anil kumar wrote:
> > >   The system hangs after messages:
> > >   loading linux......
> > >   uncompressing linux, booting linux kernel OK.
> > >
> > >   The System hangs here.
> > >
> > >   Please let me know where I am wrong
> >
> > Hi Anil,
> >
> > The only serious mistake you did was using test9 kernel when test11-pre1
> > (or at least test10) was available. So, redo everything you have done with
> > test11-pre1 and if you still cannot boot then send a message to this list
> > with details like your CPUs, motherboard etc. etc.
> 
> Have you chosen the right cpu type in the configuration?
> 
> /Martin
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
