Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281175AbRK3XRj>; Fri, 30 Nov 2001 18:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281162AbRK3XR3>; Fri, 30 Nov 2001 18:17:29 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:62111 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281170AbRK3XRQ>;
	Fri, 30 Nov 2001 18:17:16 -0500
Date: Fri, 30 Nov 2001 18:17:00 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <akpm@zip.com.au>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Coding style - a non-issue
In-Reply-To: <3C07F0B9.9EE769D3@zip.com.au>
Message-ID: <Pine.GSO.4.21.0111301814530.7125-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Nov 2001, Andrew Morton wrote:

> Jeff Garzik wrote:
> > 
> > We could definitely use a ton more comments... patches accepted.
> > 
> 
> Too late.  Useful comments go in during, or even before the code.
> 
> While we're on the coding style topic: ext2_new_block.

Yes.  I hope that new variant (see balloc.c,v) gets the thing into
better form, but then I'm obviously biased...

