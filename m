Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131229AbQLZADd>; Mon, 25 Dec 2000 19:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131519AbQLZADW>; Mon, 25 Dec 2000 19:03:22 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:14658 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131229AbQLZADQ>; Mon, 25 Dec 2000 19:03:16 -0500
Date: Tue, 26 Dec 2000 00:32:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        lvm-devel@sistina.com
Subject: Re: [PATCH] LVM includes userlevel headers
Message-ID: <20001226003244.E25861@athlon.random>
In-Reply-To: <20001225235333.A22731@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001225235333.A22731@caldera.de>; from hch@caldera.de on Mon, Dec 25, 2000 at 11:53:33PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 25, 2000 at 11:53:33PM +0100, Christoph Hellwig wrote:
> The first patch fixes that and the second changes the toplevel Makefile
> to search only the kernel and gcc (for stdarg.h) includes to prevent such
> accidents.

Looks fine, thanks.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
