Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTHOKaN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 06:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbTHOKaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 06:30:13 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:31752
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S261874AbTHOKaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 06:30:07 -0400
Date: Fri, 15 Aug 2003 03:17:41 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Erik Andersen <andersen@codepoet.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Promise SATA driver GPL'd
In-Reply-To: <20030813142436.GA3588@gtf.org>
Message-ID: <Pine.LNX.4.10.10308150314410.9444-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff,

Can you drop me on this thread?
To quote Alan Cox, "... don't need you any more."

However when you do need me you (JG) know where to find me.
Anywho, how are those DMA-Timeouts lately?

Cheers,

--a

On Wed, 13 Aug 2003, Jeff Garzik wrote:

> On Wed, Aug 13, 2003 at 03:34:37PM +0200, Vojtech Pavlik wrote:
> > On Wed, Jul 23, 2003 at 11:32:11AM +0100, Alan Cox wrote:
> > > On Mer, 2003-07-23 at 02:59, Andre Hedrick wrote:
> > > > I have already cut all ties with Promise so here is the deal.
> > > > I no longer have to count the number of fingers on my hand between hand
> > > > shakes.  IE no extras and not shortages.
> > > 
> > > Thats ok - now they are doing GPL drivers themselves they don't need
> > > you any more.
> > > 
> > > Promise did a SCSI CAM driver because their hardware can queue commands
> > > without TCQ - which drivers/ide can't cope with. Otherwise I'd just have
> > > used the same type of changes the FreeBSD people did for 2037x.
> > > 
> > > Its also interesting because it has a hardware XOR engine.
> > 
> > I don't think it does. The Promise SATA150 SX4 is the one that has the
> > XOR engine (and the PDC20621 chip) and that one is not supported by the
> > driver.
> 
> hmm, the method of delivering ATA and XOR packets on Promise hardware
> are very, very similar.  And pdc-ultra driver seems to have code to
> deliver XOR packets...
> 
> 	Jeff
> 
> 
> 

