Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130098AbQK0BNo>; Sun, 26 Nov 2000 20:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130772AbQK0BNZ>; Sun, 26 Nov 2000 20:13:25 -0500
Received: from iq.sch.bme.hu ([152.66.226.168]:22181 "EHLO iq.rulez.org")
        by vger.kernel.org with ESMTP id <S130098AbQK0BNW>;
        Sun, 26 Nov 2000 20:13:22 -0500
Date: Mon, 27 Nov 2000 01:45:20 +0100 (CET)
From: Sasi Peter <sape@iq.rulez.org>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andre Hedrick <andre@linux-ide.org>
Subject: Re: ATA-4, ATA-5 TCQ status
In-Reply-To: <20001127012812.A31641@suse.de>
Message-ID: <Pine.LNX.4.30.0011270143050.21801-100000@iq.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2000, Jens Axboe wrote:

> > I would like to ask if the tagged command queueing capability in the
> > decent ATA standards is utilized in the linux IDE driver (2.2 2.2ide
>   ^^^^^^
> > patches, or 2.4 maybe...)?
> I hope that is supposed to be 'recent', because with the current TCQ

If you think I should have...

> implementation listed in the specs Linux might as well not support it :)
> It's simply not worth it.

But seriously, how come?

I thought they just somewhat like copied the SCSI implementation...

PS: Anybody knowing about a multi (>2) channel UATA host adapter?

-- 
SaPE - Peter, Sasi - mailto:sape@sch.hu - http://sape.iq.rulez.org/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
