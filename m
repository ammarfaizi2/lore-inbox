Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261254AbRE3PAe>; Wed, 30 May 2001 11:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261268AbRE3PAY>; Wed, 30 May 2001 11:00:24 -0400
Received: from [207.106.123.146] ([207.106.123.146]:32384 "EHLO
	mail.newearth.org") by vger.kernel.org with ESMTP
	id <S261254AbRE3PAQ>; Wed, 30 May 2001 11:00:16 -0400
Date: Wed, 30 May 2001 10:59:57 -0400 (EDT)
From: Michael David <michael@newearth.org>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.5 panic while starting aic7xxx
In-Reply-To: <Pine.LNX.4.32.0105300944520.2552-100000@sapphire.newearth.org>
Message-ID: <Pine.LNX.4.32.0105301054100.1827-100000@sapphire.newearth.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 11 for device 00:0c.0
scsi0: Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs
ahc_intr: AWAITING_MSG for an SCB that does not have a waiting message
SCSIID = 7, target_mask = 1
Kernel panic: SCB = 3, SCB Control = 40, MSG_OUT = 80 SCB flags = 6000
In interrupt handler - not syncing

Using AMD Athlon 750MHz, Asus K7V mobo, Adaptec 2940 Ultra2
SCSI.


-- 
Michael V. David, AAO (Acronym Assignment Officer), NewEarth Swedenborg BBS
michael@newearth.org - http://www.newearth.org/~michael - Penguin 2.4.3-XFS
"Never apply a Star Trek solution to a Babylon 5 problem" -- Nicholas C. Weaver

