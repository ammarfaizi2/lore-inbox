Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263077AbSJaReJ>; Thu, 31 Oct 2002 12:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263081AbSJaReJ>; Thu, 31 Oct 2002 12:34:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44807 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263077AbSJaReI>; Thu, 31 Oct 2002 12:34:08 -0500
Date: Thu, 31 Oct 2002 09:39:42 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Stephen Frost <sfrost@snowman.net>,
       Stephen Wille Padnos <stephen.willepadnos@verizon.net>,
       Dax Kelson <dax@gurulabs.com>, Chris Wedgwood <cw@f00f.org>,
       Rik van Riel <riel@conectiva.com.br>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: What's left over.
In-Reply-To: <Pine.GSO.4.21.0210311226550.16688-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0210310939070.1410-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Oct 2002, Alexander Viro wrote:
> 
> 	No.  I'm saying that ACLs do not have a point until at least basic
> userland gets ready for setups people want ACLs for.  Adding features that
> can't be used until $BIG_WORK is done is idiocy in the best case and
> danger in the worst.  Especially since $BIG_WORK does not depend on these
> features.

I think samba alone counts as enough user-land usage. 

And if it turns out nobody else ever wants to use them, that's fine too.

		Linus

