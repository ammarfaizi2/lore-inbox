Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131559AbQKXF7f>; Fri, 24 Nov 2000 00:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131591AbQKXF70>; Fri, 24 Nov 2000 00:59:26 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:60451 "EHLO kweetal.tue.nl")
        by vger.kernel.org with ESMTP id <S131559AbQKXF7R>;
        Fri, 24 Nov 2000 00:59:17 -0500
Message-ID: <20001124062915.A5263@win.tue.nl>
Date: Fri, 24 Nov 2000 06:29:15 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <20001123135252.A4149@win.tue.nl> <200011240458.eAO4wdf20288@moisil.dev.hydraweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200011240458.eAO4wdf20288@moisil.dev.hydraweb.com>; from Ion Badulescu on Thu, Nov 23, 2000 at 08:58:39PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 08:58:39PM -0800, Ion Badulescu wrote:

> > (I am reorganizing my disks, copying large trees from
> > one place to the other. Always doing a diff -r between
> > old and new before removing the old version.
> > Yesterday I had a diff -r showing that the old version
> > was corrupted and the new was OK. Of course a second
> > look showed that the old version also was OK, the corruption
> > must have been in the buffer cache, not on disk.)
> 
> Are these disks IDE disks by any chance?

Yes.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
