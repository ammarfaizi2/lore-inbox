Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbUKEXta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbUKEXta (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 18:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbUKEXta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 18:49:30 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:4512 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S261277AbUKEXt1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 18:49:27 -0500
Date: Sat, 6 Nov 2004 00:49:20 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: DaMouse <damouse@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Chris Wedgwood <cw@f00f.org>,
       Andries Brouwer <aebr@win.tue.nl>, Adam Heath <doogie@debian.org>,
       Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] change Kconfig entry for RAMFS (Was: Re: support of
 older compilers)
In-Reply-To: <1a56ea3904110515274852085c@mail.gmail.com>
Message-ID: <Pine.LNX.4.60.0411060046350.3255@alpha.polcom.net>
References: <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
  <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com> 
 <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org>  <20041105014146.GA7397@pclin040.win.tue.nl>
  <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org> 
 <20041105195045.GA16766@taniwha.stupidest.org>  <Pine.LNX.4.58.0411051203470.2223@ppc970.osdl.org>
  <Pine.LNX.4.60.0411052242090.3255@alpha.polcom.net> 
 <Pine.LNX.4.58.0411051406200.2223@ppc970.osdl.org> 
 <Pine.LNX.4.60.0411052319160.3255@alpha.polcom.net> <1a56ea3904110515274852085c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2004, DaMouse wrote:

> On Sat, 6 Nov 2004 00:02:22 +0100 (CET), Grzegorz Kulewski
> <kangur@polcom.net> wrote:
>>   source "fs/supermount/Kconfig"
>
> what version of the kernel are you patching against that requires
> supermount? perhaps it would be better for you to make it against
> mainline or -mm for easier patching :)

Oh, sorry... I forgot that not everyone uses -cko kernels. But they 
should. :-)

I should start producing more patches into mainline I think. :-)


Thanks,

Grzegorz Kulewski

