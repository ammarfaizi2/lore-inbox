Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130006AbQK1NIj>; Tue, 28 Nov 2000 08:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130774AbQK1NI3>; Tue, 28 Nov 2000 08:08:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23840 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S130006AbQK1NIU>; Tue, 28 Nov 2000 08:08:20 -0500
Subject: Re: Dell 5000e APM (fixed!)
To: s.torri@lancaster.ac.uk (Stephen Torri)
Date: Tue, 28 Nov 2000 12:38:36 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.21.0011280840590.3537-100000@dyn545.dhcp.lancs.ac.uk> from "Stephen Torri" at Nov 28, 2000 08:43:01 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E140k1u-0004SB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On the topic of APM, I have a supermicro P6DBE motherboard (SMP).
> APM does not work because its not safe with SMP systems. What can I do to
> get power management for this motherboard?

Run 2.4test and hope the vendor implements ACPI. In actualf act ona desktop
you'll get a lot of the power saving from the hlt loop and the screen
blanking

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
