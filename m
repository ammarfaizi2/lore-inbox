Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281841AbRK1BKv>; Tue, 27 Nov 2001 20:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283000AbRK1BKl>; Tue, 27 Nov 2001 20:10:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19469 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281841AbRK1BKY>; Tue, 27 Nov 2001 20:10:24 -0500
Date: Tue, 27 Nov 2001 17:04:46 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Mackerras <paulus@samba.org>, Jens Axboe <axboe@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.1-pre2 does not compile
In-Reply-To: <15364.3457.368582.994067@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.33.0111271701140.1629-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Nov 2001, Paul Mackerras wrote:
>
> Is there a description of the new block layer and its interface to
> block device drivers somewhere?  That would be helpful, since Ben
> Herrenschmidt and I are going to have to convert several
> powermac-specific drivers.

Jens has something written up, which he sent to me as an introduction to
the patch. I'll send that out unless he does a cleaned-up version, but I'd
actually prefer for him to do the sending. Jens?

		Linus

