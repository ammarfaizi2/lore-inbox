Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129632AbQK2BjT>; Tue, 28 Nov 2000 20:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129638AbQK2BjJ>; Tue, 28 Nov 2000 20:39:09 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:41245 "EHLO
        penguin.e-mind.com") by vger.kernel.org with ESMTP
        id <S129632AbQK2Bi6>; Tue, 28 Nov 2000 20:38:58 -0500
Date: Wed, 29 Nov 2000 02:08:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, "David S. Miller" <davem@redhat.com>,
        viro@math.psu.edu, linux-kernel@vger.kernel.org, tytso@valinux.com
Subject: Re: 2.4.0-test11 ext2 fs corruption
Message-ID: <20001129020852.C20971@athlon.random>
In-Reply-To: <E2C40AB5D29@vcnet.vc.cvut.cz> <20001129014329.C23771@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001129014329.C23771@suse.de>; from axboe@suse.de on Wed, Nov 29, 2000 at 01:43:29AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Side note: that could generate mem/io corruption only on headactive devices
(like IDE).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
