Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131253AbRABXbR>; Tue, 2 Jan 2001 18:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131133AbRABXa5>; Tue, 2 Jan 2001 18:30:57 -0500
Received: from anime.net ([63.172.78.150]:23309 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S131081AbRABXaq>;
	Tue, 2 Jan 2001 18:30:46 -0500
Date: Tue, 2 Jan 2001 14:59:04 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Jens Axboe <axboe@suse.de>
cc: David Woodhouse <dwmw2@infradead.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Hakan Lennestal <hakanl@cdt.luth.se>,
        Andre Hedrick <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Chipsets, DVD-RAM, and timeouts....
In-Reply-To: <20010102235037.B17330@suse.de>
Message-ID: <Pine.LNX.4.30.0101021458510.15782-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2001, Jens Axboe wrote:
> On Tue, Jan 02 2001, Dan Hollis wrote:
> > Also, using CDROM on hpt366 is recipe for disaster...
> ATAPI in general actually, and as I understand it only with DMA.

Nope I can blow it up with PIO also...

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
