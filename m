Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbVJXCTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbVJXCTJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 22:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbVJXCTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 22:19:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30426 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750927AbVJXCTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 22:19:08 -0400
Date: Sun, 23 Oct 2005 19:18:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] propogate gfp_t changes further
In-Reply-To: <20051024020325.GI7992@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0510231918060.10477@g5.osdl.org>
References: <20051024110736.7bbe004e.sfr@canb.auug.org.au>
 <20051024020325.GI7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Oct 2005, Al Viro wrote:
> 
> Linus, maybe I should just send the entire series your way?  Unless you
> are planning to push 2.6.14 Real Soon Now(tm), it would make sense...

2.6.14 got delayed by a week due to some bugs, but the last one that I 
have on my worry-plate has a patch (I'm just waiting for an ack on it).

So yes, RSN.

		Linus
