Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbUKDWEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbUKDWEu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbUKDWCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:02:30 -0500
Received: from brown.brainfood.com ([146.82.138.61]:19848 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S262449AbUKDV5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:57:01 -0500
Date: Thu, 4 Nov 2004 15:56:50 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Valdis.Kletnieks@vt.edu
cc: Chris Wedgwood <cw@f00f.org>, Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers 
In-Reply-To: <200411041831.iA4IVqc1000781@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.58.0411041555400.1229@gradall.private.brainfood.com>
References: <41894779.10706@techsource.com> <20041103211353.GA24084@infradead.org>
 <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
 <20041103233029.GA16982@taniwha.stupidest.org>
 <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
 <200411041704.iA4H4sdZ014948@turing-police.cc.vt.edu>           
 <Pine.LNX.4.58.0411041214590.1229@gradall.private.brainfood.com>
 <200411041831.iA4IVqc1000781@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2004,  wrote:

> On Thu, 04 Nov 2004 12:15:47 CST, Adam Heath said:
>
> > Use faster hardware to compile a kernel.  Cross-compiling is easy for kernels
> .
>
> Hmm.. Send some faster hardware to Zwane then - I seem to recall
> that his *faster* hardware was a 3-CPU 400mz box.

my home box is dual celeron 333.  If that machine can't keep up, then the make
system itself is buggy(and yes, I've written a complex automake-like
system(not released)).

