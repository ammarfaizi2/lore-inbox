Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbUKDSUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbUKDSUJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 13:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbUKDSSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 13:18:13 -0500
Received: from brown.brainfood.com ([146.82.138.61]:29063 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S262309AbUKDSQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 13:16:16 -0500
Date: Thu, 4 Nov 2004 12:15:47 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Valdis.Kletnieks@vt.edu
cc: Chris Wedgwood <cw@f00f.org>, Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers 
In-Reply-To: <200411041704.iA4H4sdZ014948@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.58.0411041214590.1229@gradall.private.brainfood.com>
References: <41894779.10706@techsource.com> <20041103211353.GA24084@infradead.org>
 <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
 <20041103233029.GA16982@taniwha.stupidest.org>           
 <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
 <200411041704.iA4H4sdZ014948@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2004,  wrote:

> On Thu, 04 Nov 2004 10:50:38 CST, Adam Heath said:
>
> > I didn't deny the speed difference of older and newer compilers.
> >
> > But why is this an issue when compiling a kernel?  How often do you compile
> > your kernel?
>
> If you're working on older hardware (note the number of people on this
> list still using 500mz Pentium3 and similar), and a kernel developer, the
> difference between 2 hours to build a kernel and 4 hours to build a
> kernel matters quite a bit.

Use faster hardware to compile a kernel.  Cross-compiling is easy for kernels.

Plus, at least on i386/debian, kernel-package makes it easy.

Again, your argument doesn't hold water.
