Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129761AbQK2J4v>; Wed, 29 Nov 2000 04:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130499AbQK2J4m>; Wed, 29 Nov 2000 04:56:42 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:5830 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S129761AbQK2J4a>;
        Wed, 29 Nov 2000 04:56:30 -0500
Date: Wed, 29 Nov 2000 04:26:02 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Tigran Aivazian <tigran@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <Pine.LNX.4.21.0011290918440.1425-100000@penguin.homenet>
Message-ID: <Pine.GSO.4.21.0011290421060.14112-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Nov 2000, Tigran Aivazian wrote:

> On Wed, 29 Nov 2000, Alexander Viro wrote:
> > 
> > I'ld really like to see details on the box with ext2 corruption on SCSI.
> > Tigran, IIRC you had it on SCSI boxen, right? Could you send me relevant
> > part of logs?
> > 
> 
> I definitely did have this very corruption on a 4xXeon SCSI-only box. But

"This" as in "range of blocks duplicated onto another range", "random
crap in indirect blocks" or both?

> the bad news is that I reinstalled redhat7 on it immediately after this
> happened so I don't have the logs. _However_, I don't need that particular
> root filesystem there anymore (since more disks arrive today and I'm
> rearranging stuff) so I'll try and corrupt it for you right now. Using
> test12-pre3, unless you have better suggestions on what to do to help.

Could you look for duplicates too?
							TIA,
								Al

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
