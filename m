Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262716AbREOJzM>; Tue, 15 May 2001 05:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262715AbREOJzC>; Tue, 15 May 2001 05:55:02 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:42480 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262718AbREOJyy>;
	Tue, 15 May 2001 05:54:54 -0400
Date: Tue, 15 May 2001 05:54:52 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Lars Brinkhoff <lars.spam@nocrew.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        Larry McVoy <lm@bitmover.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <85vgn3lz8k.fsf@junk.nocrew.org>
Message-ID: <Pine.GSO.4.21.0105150550110.21081-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 15 May 2001, Lars Brinkhoff wrote:

> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > > Larry, go read up on TOPS-20. :-) SunOS did give unix mmap(), but it
> > > did not come up the idea.
> > Seems to be TOPS-10 ....
> > http://www.opost.com/dlm/tenex/fjcc72/ 
> 
> TENEX is not TOPS-10.  TOPS-10 didn't get virtual memory until around
> 1974.  By then, TENEX had been around for years.
> 
> TOPS-20 was developed from TENEX starting around 1973.

... and Multics had all access to files through equivalent of mmap()
in 60s. "Segments" in ls(1) got that name for a good reason.

