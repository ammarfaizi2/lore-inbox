Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129645AbQLHBM2>; Thu, 7 Dec 2000 20:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129805AbQLHBMS>; Thu, 7 Dec 2000 20:12:18 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:29291 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129645AbQLHBMH>; Thu, 7 Dec 2000 20:12:07 -0500
Date: Fri, 8 Dec 2000 01:41:46 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre25
Message-ID: <20001208014146.A24858@inspiron.random>
In-Reply-To: <20001208012052.A23992@inspiron.random> <E144BOL-0003Eg-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E144BOL-0003Eg-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 08, 2000 at 12:27:58AM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2000 at 12:27:58AM +0000, Alan Cox wrote:
> The problem is its hard to know which of your patches depend on what, and
> the complete set is large to say the least.

That's why I use a `proposed' directory that only contains patches that can be
applied to your tree, in this case it was:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/proposed/v2.2/2.2.18pre2/VM-global-2.2.18pre2-6.bz2

(note: the above is outdated so it's not anymore suggested for inclusion of
course)

I sumbitted most of the not-feature-oriented stuff at pre2 time and I plan to
re-submit after 2.2.18 is released.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
