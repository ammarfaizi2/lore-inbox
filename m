Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S135278AbQK0CAD>; Sun, 26 Nov 2000 21:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S135286AbQK0B7x>; Sun, 26 Nov 2000 20:59:53 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:46609
        "EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
        id <S135278AbQK0B7q>; Sun, 26 Nov 2000 20:59:46 -0500
Date: Sun, 26 Nov 2000 17:28:08 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: Sasi Peter <sape@iq.rulez.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ATA-4, ATA-5 TCQ status
In-Reply-To: <20001127012812.A31641@suse.de>
Message-ID: <Pine.LNX.4.10.10011261721420.12346-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2000, Jens Axboe wrote:

> On Mon, Nov 27 2000, Sasi Peter wrote:
> > Hi!
> > 
> > I would like to ask if the tagged command queueing capability in the
> > decent ATA standards is utilized in the linux IDE driver (2.2 2.2ide
>   ^^^^^^
> > patches, or 2.4 maybe...)?
> 
> I hope that is supposed to be 'recent', because with the current TCQ
> implementation listed in the specs Linux might as well not support it :)
> It's simply not worth it.

Exactly, Jens has seen the ugly beast because I have worked on coding it.
I am working to get IBM to change the method of doing this to make it
sane, but its not now.

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
