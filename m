Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbUKFN7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbUKFN7f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 08:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUKFN7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 08:59:35 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:43564 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261395AbUKFN7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 08:59:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=XShaeeCzltJ7L/vXwUDCZA6UKaSdnSUp+GgqBWeuJ1t8goQv76iPgSe/v5+JoLkGSZ7jHY75kLdCgucrmUPOoVpEHBX9ZrVBLi3dKycv3oOIGvvdcYfnI4FjlVdcb2jsP2vkkSFTuvlUJ47BSHO+/0FbWF6LgIxcM16AMkFJWUg=
Message-ID: <1a56ea3904110605595becbf4e@mail.gmail.com>
Date: Sat, 6 Nov 2004 13:59:31 +0000
From: DaMouse <damouse@gmail.com>
Reply-To: DaMouse <damouse@gmail.com>
To: Grzegorz Kulewski <kangur@polcom.net>
Subject: Re: [PATCH] change Kconfig entry for RAMFS (Was: Re: support of older compilers)
Cc: Linus Torvalds <torvalds@osdl.org>, Chris Wedgwood <cw@f00f.org>,
       Andries Brouwer <aebr@win.tue.nl>, Adam Heath <doogie@debian.org>,
       Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.60.0411060046350.3255@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
	 <20041105014146.GA7397@pclin040.win.tue.nl>
	 <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org>
	 <20041105195045.GA16766@taniwha.stupidest.org>
	 <Pine.LNX.4.58.0411051203470.2223@ppc970.osdl.org>
	 <Pine.LNX.4.60.0411052242090.3255@alpha.polcom.net>
	 <Pine.LNX.4.58.0411051406200.2223@ppc970.osdl.org>
	 <Pine.LNX.4.60.0411052319160.3255@alpha.polcom.net>
	 <1a56ea3904110515274852085c@mail.gmail.com>
	 <Pine.LNX.4.60.0411060046350.3255@alpha.polcom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe this one would be more suitable?

http://kernel.damouse.co.uk/RAMFS.patch

-DaMouse


On Sat, 6 Nov 2004 00:49:20 +0100 (CET), Grzegorz Kulewski
<kangur@polcom.net> wrote:
> On Fri, 5 Nov 2004, DaMouse wrote:
> 
> > On Sat, 6 Nov 2004 00:02:22 +0100 (CET), Grzegorz Kulewski
> > <kangur@polcom.net> wrote:
> >>   source "fs/supermount/Kconfig"
> >
> > what version of the kernel are you patching against that requires
> > supermount? perhaps it would be better for you to make it against
> > mainline or -mm for easier patching :)
> 
> Oh, sorry... I forgot that not everyone uses -cko kernels. But they
> should. :-)
> 
> I should start producing more patches into mainline I think. :-)
> 
> Thanks,
> 
> Grzegorz Kulewski
> 
> 


-- 
I know I broke SOMETHING but its their fault for not fixing it before me
