Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273867AbRIRGkN>; Tue, 18 Sep 2001 02:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273874AbRIRGkE>; Tue, 18 Sep 2001 02:40:04 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:30528 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273867AbRIRGjw>; Tue, 18 Sep 2001 02:39:52 -0400
Date: Tue, 18 Sep 2001 08:40:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010918084006.O698@athlon.random>
In-Reply-To: <20010918081146.J698@athlon.random> <Pine.LNX.4.21.0109180201460.7152-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0109180201460.7152-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Sep 18, 2001 at 02:02:37AM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 02:02:37AM -0300, Marcelo Tosatti wrote:
> Try to run several memory hungry threads (thus hiding more pages).

I did that indeed, not sure why I didn't reproduced (I guess the hogs
were sligthly different). (and of course they were killed but only after
the box was truly oom)

Andrea
