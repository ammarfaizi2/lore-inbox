Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292688AbSBUSF5>; Thu, 21 Feb 2002 13:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292683AbSBUSFs>; Thu, 21 Feb 2002 13:05:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8456 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292688AbSBUSFm>; Thu, 21 Feb 2002 13:05:42 -0500
Subject: Re: RH7.2 running 2.4.9-21-SMP (dual Xeon's) yields "Illegal instructions"
To: tepperly@llnl.gov (Tom Epperly)
Date: Thu, 21 Feb 2002 18:19:36 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202210810070.19681-100000@tux06.llnl.gov> from "Tom Epperly" at Feb 21, 2002 09:35:40 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dxoe-0007l6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you agree that this is likely to be a kernel problem?  Is upgrading
> the kernel my best course of action?

Almost every other report I have ever seen that looked like that one has always
turned out to be hardware related. The randomness in paticular tends to be 
a pointer to thinks like cache faults.

You do have ECC main memory which is good.

What other hardware is in the machine ?
