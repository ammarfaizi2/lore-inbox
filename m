Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSEIN1f>; Thu, 9 May 2002 09:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312279AbSEIN1e>; Thu, 9 May 2002 09:27:34 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45321 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311885AbSEIN1d>; Thu, 9 May 2002 09:27:33 -0400
Subject: Re: [PATCH] IDE 58
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Thu, 9 May 2002 14:22:22 +0100 (BST)
Cc: aia21@cantab.net (Anton Altaparmakov),
        benh@kernel.crashing.org (Benjamin Herrenschmidt),
        bjorn.wesen@axis.com (Bjorn Wesen), paulus@samba.org (Paul Mackerras),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3CDA5ED6.9070701@evision-ventures.com> from "Martin Dalecki" at May 09, 2002 01:34:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175nsE-0003hn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Adaptec 2400 4Ch IDE Raid Controller
> > RocketRaid 404 4Ch ATA133 Raid Host Adaptor
> 
> They appear as SCSI on the host side.

Actually the adaptec appears as a block device.
