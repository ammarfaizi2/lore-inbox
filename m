Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267468AbSLNBCS>; Fri, 13 Dec 2002 20:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267474AbSLNBCS>; Fri, 13 Dec 2002 20:02:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50700 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267468AbSLNBCR>; Fri, 13 Dec 2002 20:02:17 -0500
Date: Fri, 13 Dec 2002 17:11:20 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: James Simmons <jsimmons@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [BK fbdev] Yet again more fbdev updates.
In-Reply-To: <Pine.LNX.4.33.0212131745130.1882-100000@maxwell.earthlink.net>
Message-ID: <Pine.LNX.4.44.0212131707350.6750-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 Dec 2002, James Simmons wrote:
>
> If it happens only when you press a key which is always true:
>
> 1) Its the same place on the screen or a different place every time?

I think it's at the last line of the screen every time.

> 3) Always the last column?

Nope, I don't think so.

> If you don't mind me asking what is model of your laptop to see if
> someone else is having the same exact problem.

This is a HP ze5155 (big, heavy and horrible, but cheap). But I seriously
doubt that is the real issue: I suspect that the reason I see it on that
machine is (a) I was travelling the last three days and that was the only
machine I had and (b) because X is flaky at starting up on it, I wasn't in
X all the time like I normally am.

		Linus

