Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132046AbQKXGmQ>; Fri, 24 Nov 2000 01:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132042AbQKXGl4>; Fri, 24 Nov 2000 01:41:56 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:46826 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S131987AbQKXGlp>;
        Fri, 24 Nov 2000 01:41:45 -0500
Date: Fri, 24 Nov 2000 01:11:40 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andre Hedrick <andre@linux-ide.org>
cc: Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        Guest section DW <dwguest@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <Pine.LNX.4.10.10011232155540.2957-100000@master.linux-ide.org>
Message-ID: <Pine.GSO.4.21.0011240103021.12702-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Nov 2000, Andre Hedrick wrote:

> What the F*** does that have to do with the price of eggs in china, heh?
> Just maybe if you could follow a thread, you would see that that Alex Viro
> has pointed out that changes in the FS layer as dorked things.

?
If you have a l-k feed from future - please share. I'm not saying that
fs/* is not the source of that stuff, but I sure as hell had not said
that it is. I simply don't know yet.
 
> Since there have been not kernel changes to the driver that effect the
> code since 2.4.0-test5 or test6 and it now randomly shows up after five or
> six revisions out from the change, and the changes were chipset only.

generic_unplug_device() was changed more or less recently. I doubt that
it is relevant, but...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
