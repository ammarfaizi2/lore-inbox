Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131938AbQK0A6t>; Sun, 26 Nov 2000 19:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132202AbQK0A6j>; Sun, 26 Nov 2000 19:58:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:42000 "EHLO virtualhost.dk")
        by vger.kernel.org with ESMTP id <S131938AbQK0A6X>;
        Sun, 26 Nov 2000 19:58:23 -0500
Date: Mon, 27 Nov 2000 01:28:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Sasi Peter <sape@iq.rulez.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andre Hedrick <andre@linux-ide.org>
Subject: Re: ATA-4, ATA-5 TCQ status
Message-ID: <20001127012812.A31641@suse.de>
In-Reply-To: <Pine.LNX.4.10.10011181220390.17557-100000@master.linux-ide.org> <Pine.LNX.4.30.0011270042320.21801-100000@iq.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0011270042320.21801-100000@iq.rulez.org>; from sape@iq.rulez.org on Mon, Nov 27, 2000 at 12:52:02AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27 2000, Sasi Peter wrote:
> Hi!
> 
> I would like to ask if the tagged command queueing capability in the
> decent ATA standards is utilized in the linux IDE driver (2.2 2.2ide
  ^^^^^^
> patches, or 2.4 maybe...)?

I hope that is supposed to be 'recent', because with the current TCQ
implementation listed in the specs Linux might as well not support it :)
It's simply not worth it.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
