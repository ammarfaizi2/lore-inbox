Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129722AbQK2CF1>; Tue, 28 Nov 2000 21:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129742AbQK2CFS>; Tue, 28 Nov 2000 21:05:18 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:2564
        "EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
        id <S129722AbQK2CFF>; Tue, 28 Nov 2000 21:05:05 -0500
Date: Tue, 28 Nov 2000 17:32:16 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: Andrea Arcangeli <andrea@suse.de>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        "David S. Miller" <davem@redhat.com>, viro@math.psu.edu,
        linux-kernel@vger.kernel.org, tytso@valinux.com
Subject: Re: 2.4.0-test11 ext2 fs corruption
In-Reply-To: <20001129021150.A24264@suse.de>
Message-ID: <Pine.LNX.4.10.10011281730380.398-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Jens Axboe wrote:

> On Wed, Nov 29 2000, Andrea Arcangeli wrote:
> > Side note: that could generate mem/io corruption only on headactive devices
> > (like IDE).
> 
> Yep, that's why I told Linus it was a long shot and couldn't possibly
> account for all the corruption cases reported. And one would expect
> fs corruption to go with that as well. So it's of course a long shot,
> but still worth trying for Petr.

Okay, I have spent part of the afternoon kicking my FW around and have not
followed all of the thread.  However we are talking FSC and ATA so what
are the details?  And where are we poking into the driver.

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
