Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130188AbRABXYr>; Tue, 2 Jan 2001 18:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131216AbRABXYh>; Tue, 2 Jan 2001 18:24:37 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:57362 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130188AbRABXYU>;
	Tue, 2 Jan 2001 18:24:20 -0500
Date: Tue, 2 Jan 2001 23:50:37 +0100
From: Jens Axboe <axboe@suse.de>
To: Dan Hollis <goemon@anime.net>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Hakan Lennestal <hakanl@cdt.luth.se>,
        Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: Chipsets, DVD-RAM, and timeouts....
Message-ID: <20010102235037.B17330@suse.de>
In-Reply-To: <Pine.LNX.4.30.0101022222320.612-100000@imladris.demon.co.uk> <Pine.LNX.4.30.0101021441290.15631-100000@anime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0101021441290.15631-100000@anime.net>; from goemon@anime.net on Tue, Jan 02, 2001 at 02:42:39PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02 2001, Dan Hollis wrote:
> Also, using CDROM on hpt366 is recipe for disaster...

ATAPI in general actually, and as I understand it only with DMA.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
