Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129780AbRAOASy>; Sun, 14 Jan 2001 19:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129825AbRAOASp>; Sun, 14 Jan 2001 19:18:45 -0500
Received: from mail.courier-mta.com ([216.254.50.2]:62731 "EHLO
	mail.courier-mta.com") by vger.kernel.org with ESMTP
	id <S129780AbRAOASi>; Sun, 14 Jan 2001 19:18:38 -0500
Date: Sun, 14 Jan 2001 19:18:35 -0500 (EST)
From: Sam Varshavchik <mrsam@courier-mta.com>
Reply-To: mrsam@courier-mta.com
To: Paul Bristow <paul@paulbristow.net>
cc: Linus Torvalds <torvalds@transmeta.com>,
        linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide-floppy ATAPI format capability (official)
In-Reply-To: <3A623265.A2D49E80@paulbristow.net>
Message-ID: <Pine.LNX.4.30.0101141912520.30136-100000@ny.email-scan.com>
X-No-Archive: Yes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2001, Paul Bristow wrote:

> is welcome to format 1.44MB floppies with it.  You will need Sams floppy
> formatting utility which is available at
> http://www.email-scan.com/floppy.

Err...

That should be http://www.email-scan.com/idefloppy/

Don't bookmark the URL just yet -- I'll move the whole thing to
sourceforge shortly.

The patch is also included in the tarball over there.  The userland format
utility handles both IDE floppy drives and floppy controller (/dev/fd
drives) drives, transparently.


-- 
Sam

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
