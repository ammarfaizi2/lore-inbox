Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131745AbRAOGlY>; Mon, 15 Jan 2001 01:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132086AbRAOGlO>; Mon, 15 Jan 2001 01:41:14 -0500
Received: from www.wen-online.de ([212.223.88.39]:44806 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131745AbRAOGkz>;
	Mon, 15 Jan 2001 01:40:55 -0500
Date: Mon, 15 Jan 2001 07:40:51 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: James Mastros <james@rtweb.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Loopback almost-freeze?
In-Reply-To: <20010115011707.A1136@lilith.belledonna.mine.nu>
Message-ID: <Pine.Linu.4.10.10101150738130.980-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2001, James Mastros wrote:

> On Mon, Jan 15, 2001 at 12:34:08AM -0500, James Mastros wrote:
> > Step 3 doesn't have to be a simple cp.  I did tar -cvvI /chris/windows/*
> > |tar -xvvI /mnt/windows (or similar) to check once, and the same thing
> > happened.
> Or bonnie.

Have you tried Jens Axboe's loop patch?

ftp.kernel.org/pub/linux/kernel/people/axboe/patches

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
