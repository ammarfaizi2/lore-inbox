Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276709AbRJGWYn>; Sun, 7 Oct 2001 18:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276708AbRJGWYd>; Sun, 7 Oct 2001 18:24:33 -0400
Received: from [195.223.140.107] ([195.223.140.107]:2544 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S276704AbRJGWYO>;
	Sun, 7 Oct 2001 18:24:14 -0400
Date: Mon, 8 Oct 2001 00:24:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.4.11pre3aa1
Message-ID: <20011008002426.I726@athlon.random>
In-Reply-To: <20011004225708.A724@athlon.random> <20011007013558.M724@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011007013558.M724@athlon.random>; from andrea@suse.de on Sun, Oct 07, 2001 at 01:35:58AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2001 at 01:35:58AM +0200, Andrea Arcangeli wrote:
> On Thu, Oct 04, 2001 at 10:57:09PM +0200, Andrea Arcangeli wrote:
> > 2) Hugh's locking cleanups
> 
> checked now (of course it's just in pre4), very nice.

btw, while playing with the code I now noticed a swap_list_unlock
leftover in vmscan.c.

Andrea
