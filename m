Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130219AbRBVAo7>; Wed, 21 Feb 2001 19:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130462AbRBVAot>; Wed, 21 Feb 2001 19:44:49 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:20776 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130219AbRBVAon>; Wed, 21 Feb 2001 19:44:43 -0500
Date: Thu, 22 Feb 2001 01:46:06 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Javi Roman <javiroman@wanadoo.es>, linux-kernel@vger.kernel.org
Subject: Re: mke2fs + 8MB + 2.2.5 = hangs
Message-ID: <20010222014606.A3504@athlon.random>
In-Reply-To: <3A944C92.60A1E514@wanadoo.es> <E14Vigc-00030Q-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14Vigc-00030Q-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Feb 21, 2001 at 11:28:39PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2001 at 11:28:39PM +0000, Alan Cox wrote:
> [..] only when creating _very_ large file
> systems with little memory, where the write throttling may still need a bit
> of work.

I posted here a few days ago a little patch that is meant to address that. I
didn't got any feedback on it from the people experiencing those troubles but I
am optimistic it will help ;).

Andrea
