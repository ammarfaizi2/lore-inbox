Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261889AbRE3TT1>; Wed, 30 May 2001 15:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261892AbRE3TTR>; Wed, 30 May 2001 15:19:17 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:30242 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261889AbRE3TTB>; Wed, 30 May 2001 15:19:01 -0400
Date: Wed, 30 May 2001 21:18:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Yoann Vandoorselaere <yoann@mandrakesoft.com>
Cc: Rik van Riel <riel@conectiva.com.br>, andrea@e-mind.com,
        Mark Hemment <markhe@veritas.com>, Jens Axboe <axboe@kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 4GB I/O, cut three
Message-ID: <20010530211801.A27129@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0105301542210.12540-100000@imladris.rielhome.conectiva> <87r8x6k6kx.fsf@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r8x6k6kx.fsf@mandrakesoft.com>; from yoann@mandrakesoft.com on Wed, May 30, 2001 at 08:57:50PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2001 at 08:57:50PM +0200, Yoann Vandoorselaere wrote:
> I remember the 2.3.51 kernel as the most usable kernel I ever used 
> talking about VM.

I also don't remeber anything strange in that kernel about the VM (I
instead remeber well the VM breakage introduced in 2.3.99-pre).

Regardless of what 2.3.51 was doing, the falling back into the lower
zones before starting the balancing is fine.

Andrea
