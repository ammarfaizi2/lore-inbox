Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132353AbRADBYL>; Wed, 3 Jan 2001 20:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132348AbRADBYB>; Wed, 3 Jan 2001 20:24:01 -0500
Received: from zeus.kernel.org ([209.10.41.242]:15631 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132296AbRADBXm>;
	Wed, 3 Jan 2001 20:23:42 -0500
Date: Thu, 4 Jan 2001 01:32:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache 2nd chance replacement
Message-ID: <20010104013201.B6256@athlon.random>
In-Reply-To: <20010103221221.I32185@athlon.random> <Pine.LNX.4.21.0101032107550.1917-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0101032107550.1917-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Wed, Jan 03, 2001 at 09:09:01PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2001 at 09:09:01PM -0200, Rik van Riel wrote:
> Ever heard of slocate / updatedb ?

ever heard of somebody killing all other tasks while updatedb is running?

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
