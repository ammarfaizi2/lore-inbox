Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129219AbRBVXxi>; Thu, 22 Feb 2001 18:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129290AbRBVXx2>; Thu, 22 Feb 2001 18:53:28 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:22066 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129219AbRBVXxR>; Thu, 22 Feb 2001 18:53:17 -0500
Date: Fri, 23 Feb 2001 00:54:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: ll_rw_block/submit_bh and request limits
Message-ID: <20010223005404.E30330@athlon.random>
In-Reply-To: <20010222235700.B30330@athlon.random> <Pine.LNX.4.21.0102221915370.2435-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0102221915370.2435-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Thu, Feb 22, 2001 at 07:44:11PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2001 at 07:44:11PM -0200, Marcelo Tosatti wrote:
> The global limit on top of the per-queue limit sounds good. 

Probably.

> Since you're talking about the "total_ram / 3" hardcoded value... it
> should be /proc tunable IMO. (Andi Kleen already suggested this)

Yes, IIRC Andi also proposed that a few weeks ago.

Andrea
