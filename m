Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271975AbRH2OJ4>; Wed, 29 Aug 2001 10:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271977AbRH2OJq>; Wed, 29 Aug 2001 10:09:46 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:4860 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S271975AbRH2OJf>; Wed, 29 Aug 2001 10:09:35 -0400
Date: Wed, 29 Aug 2001 15:11:05 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Tobias Diedrich <ranma@gmx.at>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vga16fb.c, length should be 65536
In-Reply-To: <20010829124403.A25494@router.ranmachan.dyndns.org>
Message-ID: <Pine.LNX.4.21.0108291509020.2236-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2001, Tobias Diedrich wrote:
> 
> I noticed that the vga16 framebuffer driver returns a smem_len of
> 65535. Shouldn't that be 65536 ? (Realmode Segment A000-AFFF)
> 
> I already wrote about this to Ben Pfaff <pfaffen@msu.edu>, ...

Are you sure that shouldn't be Ben Pfb00?

Hugh

