Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292707AbSCOPOd>; Fri, 15 Mar 2002 10:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292730AbSCOPON>; Fri, 15 Mar 2002 10:14:13 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15116 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292707AbSCOPOF>; Fri, 15 Mar 2002 10:14:05 -0500
Subject: Re: HPT370 RAID-1 or Software RAID-1, what's "best"?
To: thunder@ngforever.de (Thunder from the hill)
Date: Fri, 15 Mar 2002 15:29:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, nitrax@giron.wox.org (Martin Eriksson)
In-Reply-To: <3C920ABB.6E17E324@ngforever.de> from "Thunder from the hill" at Mar 15, 2002 07:52:43 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lteZ-0003vj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > that comes with the BIOS, but it uses softwareraid.
> That doesn't prevent me from saying that real hardware raid might be
> better. But is the thing you wish to say that there's no difference, or
> what?

The CPU can saturate the I/O bandwidth (if not then go upgrade to a pentium)
At that point its totally disk I/O bound so there will be no difference

