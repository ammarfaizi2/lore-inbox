Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129465AbQK0XTw>; Mon, 27 Nov 2000 18:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129480AbQK0XTm>; Mon, 27 Nov 2000 18:19:42 -0500
Received: from iq.sch.bme.hu ([152.66.226.168]:9296 "EHLO iq.rulez.org")
        by vger.kernel.org with ESMTP id <S129465AbQK0XTd>;
        Mon, 27 Nov 2000 18:19:33 -0500
Date: Mon, 27 Nov 2000 23:51:30 +0100 (CET)
From: Sasi Peter <sape@iq.rulez.org>
To: Jens Axboe <axboe@suse.de>, Andre Hedrick <andre@linux-ide.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ATA-4, ATA-5 TCQ status
In-Reply-To: <Pine.LNX.4.10.10011261721420.12346-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.30.0011272349270.27635-100000@iq.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2000, Jens Axboe wrote:

> On Mon, Nov 27 2000, Sasi Peter wrote:
> > > implementation listed in the specs Linux might as well not support it :)
> > > It's simply not worth it.
> > But seriously, how come?
> > I thought they just somewhat like copied the SCSI implementation...
> I wish they would have, and based it on atapi. But they didn't...
> Basically it requires you to poll for completion of tags with a
> service command.

On Sun, 26 Nov 2000, Andre Hedrick wrote:
> On Mon, 27 Nov 2000, Jens Axboe wrote:
> > On Mon, Nov 27 2000, Sasi Peter wrote:
> > > I would like to ask if the tagged command queueing capability in the
> > > decent ATA standards is utilized in the linux IDE driver (2.2 2.2ide
> >   ^^^^^^
> > > patches, or 2.4 maybe...)?

Ok, so anybody knows a multichannel adapter? At least 4 channels?
Andre? Where do I get one? Where does the ATA revolution start?

-- 
SaPE - Peter, Sasi - mailto:sape@sch.hu - http://sape.iq.rulez.org/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
