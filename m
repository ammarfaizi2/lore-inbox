Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbQLOBAS>; Thu, 14 Dec 2000 20:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133066AbQLOBAL>; Thu, 14 Dec 2000 20:00:11 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62724 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129325AbQLOA76>; Thu, 14 Dec 2000 19:59:58 -0500
Subject: Re: Signal 11
To: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
Date: Fri, 15 Dec 2000 00:32:10 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <91bnhg$vij$1@enterprise.cistron.net> from "Miquel van Smoorenburg" at Dec 15, 2000 12:10:24 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146inG-0000O0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, but 2.96 is also binary incompatible with all non-redhat distro's.
> And since redhat is _the_ distro that commercial entities use to
> release software for, this was very arguably a bad move.

Except you conveniently ignore a few facts

o	Someone else moved to 2.95 not RH . In fact some of us felt 2.95 wasnt 
	fit to ship at the time. 

o	We tell vendors to build RPMv3 , glibc 2.1.x

o	Vendors not being stupid understand that they have a bigger market
	share if they do that.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
