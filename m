Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261616AbRFFKsw>; Wed, 6 Jun 2001 06:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261617AbRFFKsm>; Wed, 6 Jun 2001 06:48:42 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:59303 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261616AbRFFKse>;
	Wed, 6 Jun 2001 06:48:34 -0400
Date: Wed, 6 Jun 2001 06:48:32 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Sean Hunter <sean@dev.sportingbet.com>
cc: "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <20010606112207.H15199@dev.sportingbet.com>
Message-ID: <Pine.GSO.4.21.0106060637580.7264-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Jun 2001, Sean Hunter wrote:

> This is completely bogus. I am not saying that I can't afford the swap.
> What I am saying is that it is completely broken to require this amount
> of swap given the boundaries of efficient use. 

Funny. I can count many ways in which 4.3BSD, SunOS{3,4} and post-4.4 BSD
systems I've used were broken, but I've never thought that swap==2*RAM rule
was one of them.

Not that being more kind on swap would be a bad thing, but that rule for
amount of swap is pretty common. ISTR similar for (very old) SCO, so it's
not just BSD world. How are modern Missed'em'V variants in that respect, BTW?

