Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274424AbRJJDKv>; Tue, 9 Oct 2001 23:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274426AbRJJDKl>; Tue, 9 Oct 2001 23:10:41 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:6686 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S274424AbRJJDKi>; Tue, 9 Oct 2001 23:10:38 -0400
Date: Wed, 10 Oct 2001 05:11:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Robert Macaulay <robert_macaulay@dell.com>,
        Stephan von Krawczynski <skraw@ithnet.com>
Subject: 2.4.11aa1 [was Re: 2.4.11pre6aa1]
Message-ID: <20011010051104.F726@athlon.random>
In-Reply-To: <20011009205516.F724@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011009205516.F724@athlon.random>; from andrea@suse.de on Tue, Oct 09, 2001 at 08:55:16PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 08:55:16PM +0200, Andrea Arcangeli wrote:
> Allocation faliures with highmem seems cured (at least under heavy
> emulation, didn't tested real hardware yet).  Robert, could you give it
> a spin and see if you can still reproduce the faliures now?
> 
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.11pre6aa1.bz2

Only moved on top to 2.4.11 and picked the latest subsystem updates from
Jeff and Ingo:

Only in 2.4.11pre6aa1: 50_uml-patch-2.4.10-6.bz2
Only in 2.4.11aa1: 50_uml-patch-2.4.10-7.bz2

	Picked last update from user-mode-linux.sourceforge.net .

Only in 2.4.11aa1: 60_tux-2.4.10-ac10-D2.bz2
Only in 2.4.11pre6aa1: 60_tux-2.4.10-ac4-A4.bz2

	Picked last update from www.redhat.com/~mingo/ .

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.11aa1.bz2
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.11aa1/00_vm-1

(ftp.kernel.org will get it faster)

Andrea
