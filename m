Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129091AbQKWQ0Q>; Thu, 23 Nov 2000 11:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129153AbQKWQ0H>; Thu, 23 Nov 2000 11:26:07 -0500
Received: from hawk.prod.itd.earthlink.net ([207.217.120.22]:53648 "EHLO
        hawk.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
        id <S129091AbQKWQ0C>; Thu, 23 Nov 2000 11:26:02 -0500
Message-ID: <3A1D3DF9.9199C744@earthlink.net>
Date: Thu, 23 Nov 2000 10:55:38 -0500
From: Robert L Martin <robertlmarti@earthlink.net>
X-Mailer: Mozilla 4.7 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: "Hyper-Mount" option possible???
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not on list just throwing an idea out.
One thing that "bugs" me is if a given drive has more than one partion
each partion has to be mounted seperatly.
With CDs this also means you can not mount "split" cds in full if you
want to. Soo  Given that Super-Mount is already taken, How about (in
2.5??)  hashing out a Hypermount option.
The way it could work is if you mount a full drive say "hdd" and have
each partion mounted on a tree from the mount point
of the drive.


Robert L Martin
Just wishing i could mount the mac side of an AOL cd without mangling
mounting normal cds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
