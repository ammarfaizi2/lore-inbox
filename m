Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131506AbQK3CwD>; Wed, 29 Nov 2000 21:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130805AbQK3Cvx>; Wed, 29 Nov 2000 21:51:53 -0500
Received: from zeus.kernel.org ([209.10.41.242]:25107 "EHLO zeus.kernel.org")
        by vger.kernel.org with ESMTP id <S130132AbQK3Cvp>;
        Wed, 29 Nov 2000 21:51:45 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDDA8@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Alexander Viro'" <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: RE: usbdevfs mount 2x, umount 1x
Date: Wed, 29 Nov 2000 17:40:48 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
        charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > So umount it twice.
> > I don't see a way to umount it twice or I would have done that.
> > Is there a way?
> 
> Erm... Say umount one more time? If _that_ doesn't work - we've got a
> bug, either in umount(2) or in umount(8). Strace would be welcome.

Or I'm using an old version of umount (from RH 5.2) ?
I'll check on that and the strace.

~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
