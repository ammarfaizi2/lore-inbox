Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262681AbUKEPtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbUKEPtk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 10:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbUKEPtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 10:49:40 -0500
Received: from canuck.infradead.org ([205.233.218.70]:48902 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262681AbUKEPsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 10:48:22 -0500
Subject: Re: support of older compilers
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Adam Heath <doogie@debian.org>,
       Chris Wedgwood <cw@f00f.org>, Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org>
References: <41894779.10706@techsource.com>
	 <20041103211353.GA24084@infradead.org>
	 <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
	 <20041103233029.GA16982@taniwha.stupidest.org>
	 <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
	 <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org>
	 <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com>
	 <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org>
	 <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com>
	 <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org>
	 <20041105014146.GA7397@pclin040.win.tue.nl>
	 <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1099669670.2814.19.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Fri, 05 Nov 2004 16:47:51 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-05 at 07:41 -0800, Linus Torvalds wrote:
> > -rw-r--r--   1 root     root       281572 Jul 30  1995 zImage-1.2.11
> > -rw-r--r--   1 root     root       277476 Apr  1  1995 zImage-1.2.2
> 
> Ok, you da man. What do you use it for? Or is it just lying around for 
> nostalgic reasons?

some people are just a bit stubborn in accepting elf binaries perhaps ;)


