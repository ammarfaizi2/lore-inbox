Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316656AbSEQTDO>; Fri, 17 May 2002 15:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSEQTDN>; Fri, 17 May 2002 15:03:13 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32526 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316656AbSEQTDM>; Fri, 17 May 2002 15:03:12 -0400
Subject: Re: Aralion and IDE blasphemy
To: jpm@it-he.org (J.P. Morris)
Date: Fri, 17 May 2002 20:22:19 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020517194544.6c97490b.jpm@it-he.org> from "J.P. Morris" at May 17, 2002 07:45:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178nIx-00077W-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > The culprit is an ARALION ARS106S chipset card.  Interestingly it works
> > > in DOS, and if the hard disks are attached to it, it will even boot
> > 
> > What does lspci say the chipset really is ?
> 
> Here's the entry for it from lspci -v.  I can quote the entire file if you prefer.
> 
> 00:11.0 RAID bus controller: ARALION Inc: Unknown device 0301

Just the one controller shows up despite it being four ports ?

> However.  I put the thing in to try and relieve a problem of drive bays and
> connector lengths.  A bit of lateral thinking has provided another solution
> and I no longer need the card urgently.

Aralion claim Linux support so might be worth asking them ?
http://www.aralion.com/products/raidControl/ideRaid/ideRaid_ultimaRaid100.htm
