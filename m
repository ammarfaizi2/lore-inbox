Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131699AbQKWMBb>; Thu, 23 Nov 2000 07:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129507AbQKWMBW>; Thu, 23 Nov 2000 07:01:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25616 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S131699AbQKWMBC>; Thu, 23 Nov 2000 07:01:02 -0500
Subject: Re: 2.4.0-test11 reports CPU inconsistent variable MTRR settings
To: yusufg@outblaze.com (Yusuf Goolamabbas)
Date: Thu, 23 Nov 2000 11:31:23 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001123031951.1726.qmail@yusufg.portal2.com> from "Yusuf Goolamabbas" at Nov 23, 2000 03:19:51 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13yub7-0007Ee-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> mtrr: your CPUs had inconsistent variable MTRR settings
> mtrr: probably your BIOS does not setup all CPUs
> 
> Am not sure if this is going to lead to bad juju. Anybody else seeing
> this on a similar mobo

This is a BIOS bug the kernel detects and fixes providing you have mtrr
enabled so you should be just fine
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
