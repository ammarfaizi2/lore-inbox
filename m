Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbUKEXcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUKEXcx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 18:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbUKEXcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 18:32:17 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:30324 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261258AbUKEX1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 18:27:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=YwxVp4CnnBLegbN7dPqMQ5KIIjfI/5/KSyp9xLxeJxqZib7W+A9lsYjUNBa/ewZkfE22XTgZrBoA8DdLrGnx4lVpWUQjl8wZJJThSC76dgSflUkUszKwRlFgORDdPmrYrgIlgxDmHuaZQtSy3NqPnQOm33eToXNBZW4Of+c69qw=
Message-ID: <1a56ea3904110515274852085c@mail.gmail.com>
Date: Fri, 5 Nov 2004 23:27:23 +0000
From: DaMouse <damouse@gmail.com>
Reply-To: DaMouse <damouse@gmail.com>
To: Grzegorz Kulewski <kangur@polcom.net>
Subject: Re: [PATCH] change Kconfig entry for RAMFS (Was: Re: support of older compilers)
Cc: Linus Torvalds <torvalds@osdl.org>, Chris Wedgwood <cw@f00f.org>,
       Andries Brouwer <aebr@win.tue.nl>, Adam Heath <doogie@debian.org>,
       Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.60.0411052319160.3255@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
	 <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com>
	 <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org>
	 <20041105014146.GA7397@pclin040.win.tue.nl>
	 <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org>
	 <20041105195045.GA16766@taniwha.stupidest.org>
	 <Pine.LNX.4.58.0411051203470.2223@ppc970.osdl.org>
	 <Pine.LNX.4.60.0411052242090.3255@alpha.polcom.net>
	 <Pine.LNX.4.58.0411051406200.2223@ppc970.osdl.org>
	 <Pine.LNX.4.60.0411052319160.3255@alpha.polcom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Nov 2004 00:02:22 +0100 (CET), Grzegorz Kulewski
<kangur@polcom.net> wrote:
>   source "fs/supermount/Kconfig"

what version of the kernel are you patching against that requires
supermount? perhaps it would be better for you to make it against
mainline or -mm for easier patching :)

-DaMouse


-- 
I know I broke SOMETHING but its their fault for not fixing it before me
