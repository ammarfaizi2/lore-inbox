Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQKPSrf>; Thu, 16 Nov 2000 13:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129132AbQKPSrZ>; Thu, 16 Nov 2000 13:47:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15424 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129069AbQKPSrK>; Thu, 16 Nov 2000 13:47:10 -0500
Subject: Re: APM oops with Dell 5000e laptop
To: dax@gurulabs.com (Dax Kelson)
Date: Thu, 16 Nov 2000 18:17:50 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.30.0011161054420.16124-100000@ultra1.inconnect.com> from "Dax Kelson" at Nov 16, 2000 10:59:27 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wTbc-0008BC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The kernel works around/ignores/disables other broken hardware or broken
> features of otherwise working hardware with black lists.  There will be
> many *many* of these laptops sold.

And I hope many many of these people demand BIOS upgrades or send them back.

> Is there a way to uniquely identify the affected BIOSes at boot time and

Im looking at one with some pointers from Dell. It won't be in 2.2.18 so its
quite likely a fixed BIOS will be out first anyway.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
