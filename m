Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265507AbRGKTFZ>; Wed, 11 Jul 2001 15:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265005AbRGKTFP>; Wed, 11 Jul 2001 15:05:15 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:17256 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265024AbRGKTFD>; Wed, 11 Jul 2001 15:05:03 -0400
Date: Wed, 11 Jul 2001 21:05:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Josh Logan <josh@wcug.wwu.edu>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Andrew Morton <andrewm@uow.edu.au>,
        Klaus Dittrich <kladit@t-online.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7p6 hang
Message-ID: <20010711210502.M3496@athlon.random>
In-Reply-To: <20010711175809.F3496@athlon.random> <Pine.BSO.4.21.0107111129150.26715-100000@sloth.wcug.wwu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSO.4.21.0107111129150.26715-100000@sloth.wcug.wwu.edu>; from josh@wcug.wwu.edu on Wed, Jul 11, 2001 at 11:33:40AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 11:33:40AM -0700, Josh Logan wrote:
> 
> I'm having a hang right after the floppy is initialised with pre5 and pre6
> (2.4.3 works fine)  I tried this patch, but it did not make any

is the problem introduced in pre5? Can you reproduce under 2.4.7pre4?

> improvments.  The machine still has SysRq commands available.  Please let
> me know what other information you would like to debug this problem.

SYSRQ+T

> BTW, I also tried to disable the floppy in the BIOS and got:
> ...
> Floppy OK
> task queue still active
> <HANG>

I'll soon have a look at this message.

Andrea
