Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131324AbQLFUYZ>; Wed, 6 Dec 2000 15:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131330AbQLFUYP>; Wed, 6 Dec 2000 15:24:15 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:12298
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131324AbQLFUYK>; Wed, 6 Dec 2000 15:24:10 -0500
Date: Wed, 6 Dec 2000 11:40:14 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
cc: Skip Collins <bernard.collins@jhuapl.edu>, linux-kernel@vger.kernel.org
Subject: Re: system hang and corrupt ext2 filesystem with test12-pre5
In-Reply-To: <3A2E5FAA.FF29E9D7@Hell.WH8.TU-Dresden.De>
Message-ID: <Pine.LNX.4.10.10012061137521.21407-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2000, Udo A. Steinberg wrote:

> I also have an A7V and both of my IBM IDE drives are connected to the
> Promise controller, running in UDMA-5 mode. There hasn't been any
> corruption on either of the drives that had to do with UDMA-5 mode.
> And the ext2 bugs that 2.4 kernels had, have been fixed in the latest
> versions.
> 
> What drive are you using? AFAIR, Andre Hedrick once said certain Maxtor
> drives aren't quite safe with DMA.

WHOA!!!!  That was more than 3 years ago but that is not to day.
I have been working with them internally to make things work with Linux.
They have the fastest drive to date.  When running internal benchmarks one
can see XFER rates that go beyond 85MB/sec.

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
