Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S133082AbQK0AU3>; Sun, 26 Nov 2000 19:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S135193AbQK0AUT>; Sun, 26 Nov 2000 19:20:19 -0500
Received: from iq.sch.bme.hu ([152.66.226.168]:58016 "EHLO iq.rulez.org")
        by vger.kernel.org with ESMTP id <S133082AbQK0AUF>;
        Sun, 26 Nov 2000 19:20:05 -0500
Date: Mon, 27 Nov 2000 00:52:02 +0100 (CET)
From: Sasi Peter <sape@iq.rulez.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andre Hedrick <andre@linux-ide.org>
Subject: ATA-4, ATA-5 TCQ status
In-Reply-To: <Pine.LNX.4.10.10011181220390.17557-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.30.0011270042320.21801-100000@iq.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I would like to ask if the tagged command queueing capability in the
decent ATA standards is utilized in the linux IDE driver (2.2 2.2ide
patches, or 2.4 maybe...)?

Another question, a little bit offtopic is if anybody on this list is able
to point me to some pci UltraATA controller card, which has more than 2
channels (more than 4 drives w/o cascade magic) (preferrably 6 or 8
channels)? If the exists one, I do not need no HW RAID or anything like
that... I only need a lot of channels, in only one PCI slot.
There have been a lot of rant around here, and why I am addressing Andre
personally too is that in that debate his stated, that because such cards
exist, IDE can fall into line with SCSI in drives possible / PCI slot.

Your help is very much appreciated,

-- 
SaPE - Peter, Sasi - mailto:sape@sch.hu - http://sape.iq.rulez.org/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
