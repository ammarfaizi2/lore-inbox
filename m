Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273040AbRIIUuj>; Sun, 9 Sep 2001 16:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273042AbRIIUuT>; Sun, 9 Sep 2001 16:50:19 -0400
Received: from mail4.svr.pol.co.uk ([195.92.193.211]:34857 "EHLO
	mail4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S273040AbRIIUuK>; Sun, 9 Sep 2001 16:50:10 -0400
Date: Sun, 9 Sep 2001 21:49:00 +0100
From: Adrian Burgess <kernel@corrosive.freeserve.co.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE Problems on SIS 735? (continued)
Message-ID: <20010909214900.A1135@corrosive.freeserve.co.uk>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20010905085251.A3154@corrosive.freeserve.co.uk> <E15ebN4-0005g4-00@the-village.bc.nu> <20010905185946.A6828@corrosive.freeserve.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010905185946.A6828@corrosive.freeserve.co.uk>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux corrosive.freeserve.co.uk 2.4.9-ac10 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I've now changed the IDE cable attached to my hard drives twice, and I'm
still getting IDE DMA problems - has anyone else with a SIS 735 based
motherboard been having any problems, because I'm running short of ideas?
Also - what are the chances of data corruption from these errors?
Thanks,
Adrian.


(error report)
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command
hda: status timeout: status=0xd0 { Busy }
hdb: DMA disabled
hda: drive not ready for command
ide0: reset: success

-- 
PGP Public Key at http://www.corrosive.freeserve.co.uk/text/pubkey.asc
