Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261487AbREZPlZ>; Sat, 26 May 2001 11:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261628AbREZPlP>; Sat, 26 May 2001 11:41:15 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:22546 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261487AbREZPlD>; Sat, 26 May 2001 11:41:03 -0400
Date: Sat, 26 May 2001 17:40:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
Message-ID: <20010526174042.D9634@athlon.random>
In-Reply-To: <20010526172444.A9634@athlon.random> <Pine.LNX.4.21.0105261226160.30264-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105261226160.30264-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Sat, May 26, 2001 at 12:26:38PM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2001 at 12:26:38PM -0300, Rik van Riel wrote:
> Guess what's in my patch?

that part is fine indeed, it's ages that I am telling that alloc_pages
must always be allowed to fail or things will deadlock, go back to the
discussion with Ingo of a few months ago, finally you seems convinced
about that.

Andrea
