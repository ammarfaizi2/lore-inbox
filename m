Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285099AbSACJTd>; Thu, 3 Jan 2002 04:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285147AbSACJTP>; Thu, 3 Jan 2002 04:19:15 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:56781 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S285073AbSACJS5>; Thu, 3 Jan 2002 04:18:57 -0500
Date: Thu, 3 Jan 2002 11:15:48 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix loop BIO breakage (memory corruption)
In-Reply-To: <20020103094832.E482@suse.de>
Message-ID: <Pine.LNX.4.33.0201031114450.32040-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Jens Axboe wrote:

> > Patch tested with read/write losetup type mounts, plain file backed mounts
> > and block backed mounts (these fail in ll_rw_blk:1365 BUG check now)
>
> Oh? Care to look into this?

Will do.

Cheers,
	Zwane Mwaikambo


