Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269786AbRHNEOM>; Tue, 14 Aug 2001 00:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270366AbRHNEOD>; Tue, 14 Aug 2001 00:14:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26892 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269786AbRHNENz>; Tue, 14 Aug 2001 00:13:55 -0400
Date: Mon, 13 Aug 2001 21:13:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (1/11) fs/super.c fixes
In-Reply-To: <Pine.GSO.4.21.0108140004450.10579-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0108132112180.1277-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Aug 2001, Alexander Viro wrote:
> >
> > ie serious failures starting with 3/11.
>
> Oh, hell... Looks like I'm in for downloading the tarball over 56K link ;-/
> Just in case - md5 of fs/super.c (2.4.9-pre3) here is
> 3e98e0cc929aebcb186698eae026a0b1.  If it differs from your tree...

Nope, thats' the right one. You seem to have a pristine tree.

	3e98e0cc929aebcb186698eae026a0b1  fs/super.c

I suspect that you may have generated the diffs in a different order than
the subject lines imply (ie maybe 3/11 should be 4/11 and vice versa).

		Linus

