Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273848AbRIRFJj>; Tue, 18 Sep 2001 01:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273849AbRIRFJ3>; Tue, 18 Sep 2001 01:09:29 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:20784 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273848AbRIRFJY>; Tue, 18 Sep 2001 01:09:24 -0400
Date: Tue, 18 Sep 2001 07:09:43 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010918070943.A698@athlon.random>
In-Reply-To: <20010918063910.U698@athlon.random> <E15jD3c-0000Ga-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15jD3c-0000Ga-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Sep 18, 2001 at 06:04:28AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 06:04:28AM +0100, Alan Cox wrote:
> The O_DIRECT stuff is very clean - its definitely a feature that should
> have gone into 2.5 first and then back, but its one that really doesn't
> bother me too much. blkdev in page cache needs some locking thinking but
> looks ok.

agreed.

Andrea
