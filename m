Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbQLYX5w>; Mon, 25 Dec 2000 18:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131140AbQLYX5n>; Mon, 25 Dec 2000 18:57:43 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:31808 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129348AbQLYX5g>; Mon, 25 Dec 2000 18:57:36 -0500
Date: Tue, 26 Dec 2000 00:27:00 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: torvalds@transmeta.com, mauelshagen@sistina.com,
        linux-kernel@vger.kernel.org, lvm-devel@sistina.com
Subject: Re: [PATCH][RFC] LVM proc fix
Message-ID: <20001226002700.D25861@athlon.random>
In-Reply-To: <20001225235950.A23247@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001225235950.A23247@caldera.de>; from hch@ns.caldera.de on Mon, Dec 25, 2000 at 11:59:51PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 25, 2000 at 11:59:51PM +0100, Christoph Hellwig wrote:
> Hi Linus & Heinz,
> 
> there has been some discussion about the LVM /proc #ifdefs in
> Linux 2.4.0-test13pre4 (LVM 0.9).  How about just removing
> CONFIG_LVM_PROC_FS? - beople that use LVM and procfs usually do
> not care for the few extra bytes.

I think it's a good idea.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
