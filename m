Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264729AbTFLE2V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 00:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264732AbTFLE2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 00:28:20 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:39691
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S264729AbTFLE2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 00:28:16 -0400
Date: Wed, 11 Jun 2003 21:29:23 -0700 (PDT)
From: Andre Hedrick <andre@pyxtechnologies.com>
To: Michal Jaegermann <michal@harddata.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/bus/pci
In-Reply-To: <20030605144925.A5993@mail.harddata.com>
Message-ID: <Pine.LNX.4.10.10306112129080.30142-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


JG Jeff Garzik
AC Alan Cox
BZ Bartlomiej Zolnierkiewicz
JA Jens Axboe

TF TaskFile
FIS Frame Information Structure

TCQ erm ... obvious
FPDMA First Party Direct Memory Access

SATA erm ... obvious
SCSI erm ... obvious

Cheers


Andre Hedrick
LAD Storage Consulting Group

On Thu, 5 Jun 2003, Michal Jaegermann wrote:

> On Thu, Jun 05, 2003 at 06:41:10PM +0200, Julien Oster wrote:
> > Linus Torvalds <torvalds@transmeta.com> writes:
> > 
> > > A "phb" just makes me go "Whaa?"
> > 
> > But people doing computer stuff *love* abbrevations. Ask any
> > non-kernel-developer (or non-kernel-interested) about ACPI, MSI, MSWR,
> > MTRR, APIC, IO-APIC, TSC, PTE or XT-PIC-IRQ and he will not only go
> > "Whaa?" but "WHAAAAHELP!" :-)
> 
> In a message from 2nd of July, here on lkml, Andre Hedrick wrote
> 
> <quote>
> I need to sit down with JG, AC, BZ, JA and work out a TF <> FIS lib
> for First Party DMA.
>     
> I need to rip the SATA 1.0 out of drivers/ide/* ...
> ....
>     
> Obviously TCQ in FPDMA via direct FIS will map to SCSI with less
> pain.
>     
> I have FPDMA cores.
> </quote>
> 
> In the first moment I started to wonder if this is a spoof; but
> after a while I decided that likely it is not.  Still a translator
> could be handy or it is time to update V.E.R.A. :-)
> 
>   Michal
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

