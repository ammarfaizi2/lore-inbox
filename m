Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129602AbQKGMZR>; Tue, 7 Nov 2000 07:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129745AbQKGMZH>; Tue, 7 Nov 2000 07:25:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13176 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129602AbQKGMY6>; Tue, 7 Nov 2000 07:24:58 -0500
Subject: Re: ne2k/wd3018 driver
To: Ruth.Ivimey-Cook@arm.com (Ruth Ivimey-Cook)
Date: Tue, 7 Nov 2000 12:26:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4.3.2.7.2.20001107104110.00e0f530@cam-pop.cambridge.arm.com> from "Ruth Ivimey-Cook" at Nov 07, 2000 10:44:11 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13t7pE-0007LY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does anyone know why a Linux ethernet driver might appear to be up & 
> working (that is, no errors, ifconfig says UP, etc), and the board has a 
> link light on it, but the hub link light is not on and no packets are 
> transmitted or received? rmmod/insmod of the driver doesn't help.
> 
> I have an ne2k/ISA Atlantic card that is doing this in either wd or ne mode 
> with a 2.2.14 kernel, and can't get it running... help!

Plug the cable into the hub before powering up the chip ? I have at least one
crap ne2k clone that only does the detect at boot


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
