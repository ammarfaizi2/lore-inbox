Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318771AbSIFPmG>; Fri, 6 Sep 2002 11:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318767AbSIFPlX>; Fri, 6 Sep 2002 11:41:23 -0400
Received: from chaos.analogic.com ([204.178.40.224]:11648 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318746AbSIFPkU>; Fri, 6 Sep 2002 11:40:20 -0400
Date: Fri, 6 Sep 2002 11:44:52 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mike Dresser <mdresser_l@windsormachine.com>
cc: DevilKin <devilkin-lkml@blindguardian.org>, linux-kernel@vger.kernel.org
Subject: Re: ide drive dying?
In-Reply-To: <Pine.LNX.4.33.0209061123550.30387-100000@router.windsormachine.com>
Message-ID: <Pine.LNX.3.95.1020906113826.1557A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2002, Mike Dresser wrote:

> > The drive involved is an IBM-DTLA-307060, which has served me without problems
> > now for about 2 years.
> 
> IBM DeathStar 75gxp.
> 
> One of the worst hard drives ever made.  It's quite likely it's failed,
> and in fact, two years is pretty impressive out of one of these.
> 
> Make backups immediately.  Run ibm's DFT tool, get the code to RMA this
> thing back to IBM.  Sell the replacement they send you to a sucker on
> eBAY, and buy yourself a new drive.  You can pickup 80 gig drives for
> around 80 bucks nowadays.  I used to recommend Maxtors, until they said
> they're cutting their warranty to one year from three.  I don't know what
> to use anymore.
> 
> Mike
> 

             IBM DeathStar 75gxp.

Well put. Also, don't turn off this drive --ever. If possible, back-up
to something on a network, not to anything on the IDE bus. If you don't
have anything available, borrow something from work and make a temporary
LAN. With bad sectors and a relocation list already full, this drive
will seize the IDE bus and never let go once you trip it into failure.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

