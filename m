Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268160AbTHKPyw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 11:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268751AbTHKPyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 11:54:52 -0400
Received: from filesrv1.system-techniques.com ([199.33.245.55]:37506 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id S268160AbTHKPyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:54:50 -0400
Date: Mon, 11 Aug 2003 11:54:40 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: narancs <narancs@narancs.tii.matav.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: DEC KZPSA SCSI card - is there a linux driver?
In-Reply-To: <3F37A962.4030505@narancs.tii.matav.hu>
Message-ID: <Pine.LNX.4.56.0308111147160.2855@filesrv1.baby-dragons.com>
References: <3F37A962.4030505@narancs.tii.matav.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello Narancs ,  Try a google or altavista on KZPSA .
	I found quite a few mentions for the device .  Another thing to
	try is to look the board over very carefully & see if it might be
	actually made by another company & just re-stamped with the DEC
	name & partno. ,  Like the DAC960's were renamed to KZSPC's by
	DEC .  Hth ,  JimL

On Mon, 11 Aug 2003, narancs wrote:
> Hi people,
> I guess this mail should have gone to a mailing list like linux-scsi,
> but I just couldn't find that list's address - sorry if this mail is not
> to be here :)
> so I have just got a DEC PCI SCSI card which has a sym53c720 chip and an
> intel 930 chip and an LSI chip on board. it is a full-length 32bit PCI
> scsi card. (it was working fine in an alpha axp system with true64 unix,
> and now it is installed in a PC.)
> with linux kernel 2.4.20 (suse8.2) trying all the modules, I just
> couldn't get it working.
> I moved the card to other PCI slots and play with irqs, but no success.
> please help that which driver should get it working if this card is
> supported at all.
> thanks!
> 00:0d.0 SCSI storage controller: Digital Equipment Corporation KZPSA [KZPSA]
>         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B-
>         Status: Cap- 66Mhz- UDF+ FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 66 (2000ns min, 31750ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 7
>         BIST result: 00
>         Region 0: Memory at fedfd000 (64-bit, non-prefetchable) [size=4K]
>         Region 2: I/O ports at d000 [size=4K]
>         Region 3: Memory at feb00000 (64-bit, non-prefetchable) [size=1M]
>         Expansion ROM at <unassigned> [disabled] [size=64K]
-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
