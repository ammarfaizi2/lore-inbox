Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129632AbQKXF3N>; Fri, 24 Nov 2000 00:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131682AbQKXF2y>; Fri, 24 Nov 2000 00:28:54 -0500
Received: from vp175103.reshsg.uci.edu ([128.195.175.103]:57353 "EHLO
        moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
        id <S129632AbQKXF2v>; Fri, 24 Nov 2000 00:28:51 -0500
Date: Thu, 23 Nov 2000 20:58:39 -0800
Message-Id: <200011240458.eAO4wdf20288@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Guest section DW <dwguest@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <20001123135252.A4149@win.tue.nl>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18pre21 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2000 13:52:52 +0100, Guest section DW <dwguest@win.tue.nl> wrote:
> On Thu, Nov 23, 2000 at 05:03:00PM +1100, Neil Brown wrote:
> 
>> Oh, good.  It's not just me and Tigran then.
> 
> You have it all backwards. It would be good if it were
> just you and Tigran. Unfortunately it also hits me.
> 
> (I am reorganizing my disks, copying large trees from
> one place to the other. Always doing a diff -r between
> old and new before removing the old version.
> Yesterday I had a diff -r showing that the old version
> was corrupted and the new was OK. Of course a second
> look showed that the old version also was OK, the corruption
> must have been in the buffer cache, not on disk.)

Are these disks IDE disks by any chance?

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
