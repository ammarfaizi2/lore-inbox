Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131736AbQKXGaS>; Fri, 24 Nov 2000 01:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131991AbQKXGaI>; Fri, 24 Nov 2000 01:30:08 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:57870
        "EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
        id <S131736AbQKXG37>; Fri, 24 Nov 2000 01:29:59 -0500
Date: Thu, 23 Nov 2000 21:59:36 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
cc: Guest section DW <dwguest@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <200011240458.eAO4wdf20288@moisil.dev.hydraweb.com>
Message-ID: <Pine.LNX.4.10.10011232155540.2957-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2000, Ion Badulescu wrote:

> > Yesterday I had a diff -r showing that the old version
> > was corrupted and the new was OK. Of course a second
> > look showed that the old version also was OK, the corruption
> > must have been in the buffer cache, not on disk.)
> 
> Are these disks IDE disks by any chance?

What the F*** does that have to do with the price of eggs in china, heh?
Just maybe if you could follow a thread, you would see that that Alex Viro
has pointed out that changes in the FS layer as dorked things.

Since there have been not kernel changes to the driver that effect the
code since 2.4.0-test5 or test6 and it now randomly shows up after five or
six revisions out from the change, and the changes were chipset only.

Please make your point.

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
