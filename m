Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUH1B6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUH1B6U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 21:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266139AbUH1B6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 21:58:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:7810 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266137AbUH1B6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 21:58:18 -0400
Date: Fri, 27 Aug 2004 18:58:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove unused ext2_panic
In-Reply-To: <20040828011959.GC16444@apps.cwi.nl>
Message-ID: <Pine.LNX.4.58.0408271856071.14196@ppc970.osdl.org>
References: <UTC200408271606.i7RG6tV27596.aeb@smtp.cwi.nl>
 <Pine.LNX.4.58.0408271104300.14196@ppc970.osdl.org> <20040828011959.GC16444@apps.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 28 Aug 2004, Andries Brouwer wrote:
> 
> Don't see it yet.

It's in the "else" part of the if, so you may not have noticed. 

> Something else: ext2_panic is unused, it seems.

Hmm, yes indeed.

		Linus
