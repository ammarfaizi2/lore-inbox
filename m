Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbUKFMHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbUKFMHf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 07:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUKFMHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 07:07:34 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:36874 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261373AbUKFMHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 07:07:22 -0500
Date: Sat, 6 Nov 2004 13:07:16 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Adam Heath <doogie@debian.org>,
       Chris Wedgwood <cw@f00f.org>, Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
Message-ID: <20041106120716.GA9144@pclin040.win.tue.nl>
References: <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com> <20041103233029.GA16982@taniwha.stupidest.org> <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com> <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org> <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com> <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org> <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com> <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org> <20041105014146.GA7397@pclin040.win.tue.nl> <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# > > There are probably people even using linux-1.2.
# > 
# > # uname -a
# > Linux knuth 1.2.11 #27 Sun Jul 30 03:39:01 MET DST 1995 i486
# > 
# > (486 DX/2, 66MHz, 8 MB)
# > 
# > -rw-r--r--   1 root     root       281572 Jul 30  1995 zImage-1.2.11
# > -rw-r--r--   1 root     root       277476 Apr  1  1995 zImage-1.2.2
# 
# Ok, you da man. What do you use it for? Or is it just lying around for 
# nostalgic reasons?

One strength is the fact that it boots in a couple of seconds, while
my current 2.6.9 with vendor boot scripts takes minutes.
Another strength is the weight - exactly 2 kg.
I write letters, papers, lecture notes and stuff.
It feels faster than modern machines.
Only need X, TeX, emacs and rsh, rcp.

>> to remind us how large the kernel is getting? :)

> Yeah, I know. Damn, it's scary.
> The kernel does do more these days than it did in '95. But 6 times more?

I recall the times where 4K was enough for a multiuser OS that provided
each user its own virtual machine (and could run itself under itself).
Small is beautiful. Six times? Today for me is

-rw-r--r--  1 aeb users 3161708 2004-11-06 01:19 /boot/bzImage-2.6.9test

Probably I select more filesystems than you do.

Andries
