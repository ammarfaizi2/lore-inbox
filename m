Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129094AbQKCRb3>; Fri, 3 Nov 2000 12:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130620AbQKCRbN>; Fri, 3 Nov 2000 12:31:13 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:9076 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129094AbQKCRau>; Fri, 3 Nov 2000 12:30:50 -0500
Date: Fri, 3 Nov 2000 18:30:37 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Michael Boman <michael.boman@usa.net>, linux-kernel@vger.kernel.org
Subject: Re: ext3 vs. JFS file locations...
Message-ID: <20001103183037.K857@athlon.random>
In-Reply-To: <3A02D150.E7E87398@usa.net> <E13rivh-0003bS-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E13rivh-0003bS-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Nov 03, 2000 at 03:38:56PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2000 at 03:38:56PM +0000, Alan Cox wrote:
> [..] while thats very
> sensible [..]

Not that it matters much but jfs means "journalling filesystem" and fs/jfs
isn't a filesystem in the ext3 patch, so it doesn't look that sensible to me.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
