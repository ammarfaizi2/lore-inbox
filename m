Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131565AbQLPOKC>; Sat, 16 Dec 2000 09:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131665AbQLPOJw>; Sat, 16 Dec 2000 09:09:52 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:17210 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131565AbQLPOJk>; Sat, 16 Dec 2000 09:09:40 -0500
Date: Sat, 16 Dec 2000 14:39:10 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, J Sloan <jjs@toyota.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [lkml]Re: VM problems still in 2.2.18
Message-ID: <20001216143910.A25150@inspiron.random>
In-Reply-To: <E146zsJ-0001fT-00@the-village.bc.nu> <Pine.LNX.4.10.10012160244200.30931-100000@home.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10012160244200.30931-100000@home.suse.com>; from mason@suse.com on Sat, Dec 16, 2000 at 02:49:40AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2000 at 02:49:40AM -0800, Chris Mason wrote:
> GFP_BUFFER.  As far as I know that should be safe, but the change is

Yes that's ok.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
