Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262537AbUKEBsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbUKEBsH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 20:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUKEBsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 20:48:07 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:32010 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262537AbUKEBl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 20:41:57 -0500
Date: Fri, 5 Nov 2004 02:41:46 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adam Heath <doogie@debian.org>, Chris Wedgwood <cw@f00f.org>,
       Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
Message-ID: <20041105014146.GA7397@pclin040.win.tue.nl>
References: <41894779.10706@techsource.com> <20041103211353.GA24084@infradead.org> <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com> <20041103233029.GA16982@taniwha.stupidest.org> <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com> <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org> <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com> <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org> <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com> <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: CollegeOfNewCaledonia: mailhost.tue.nl 1189; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Ob l-k]

I have not yet investigated, but my (vanilla) 2.6.9
has a mouse problem that my vanilla 2.6.8.1 does not have:
it starts selecting text as soon as I touch it for the first
time, as if the initialization created a fake mouse-down event.


[old stuff]

> There are probably people even using linux-1.2.

# uname -a
Linux knuth 1.2.11 #27 Sun Jul 30 03:39:01 MET DST 1995 i486

(486 DX/2, 66MHz, 8 MB)

-rw-r--r--   1 root     root       281572 Jul 30  1995 zImage-1.2.11
-rw-r--r--   1 root     root       277476 Apr  1  1995 zImage-1.2.2


Andries


