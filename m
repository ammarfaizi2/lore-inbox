Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262444AbUKDVsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbUKDVsZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 16:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbUKDVsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 16:48:25 -0500
Received: from brown.brainfood.com ([146.82.138.61]:17544 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S262445AbUKDVsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:48:09 -0500
Date: Thu, 4 Nov 2004 15:47:51 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Chris Wedgwood <cw@f00f.org>, Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
In-Reply-To: <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com>
References: <41894779.10706@techsource.com> <20041103211353.GA24084@infradead.org>
 <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
 <20041103233029.GA16982@taniwha.stupidest.org>
 <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2004, Linus Torvalds wrote:

> > I didn't deny the speed difference of older and newer compilers.
> >
> > But why is this an issue when compiling a kernel?  How often do you compile
> > your kernel?
>
> First off, for some people that is literally where _most_ of the CPU
> cycles go.

So find a fast machine.  As I have already said, you don't need to compile a
kernel for a slow machine/arch *on* a slow machine/arch.

> Second, it's not just that the compilers are slower. Historically, new gcc
> versions are:
>  - slower

Again, that's a straw man.

>  - generate worse code
>  - buggier

I don't doubt these are issues.  That's not what I am discussing.
