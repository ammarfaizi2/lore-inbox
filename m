Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131621AbQLVC1U>; Thu, 21 Dec 2000 21:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131750AbQLVC1K>; Thu, 21 Dec 2000 21:27:10 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:64641 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131621AbQLVC1C>;
	Thu, 21 Dec 2000 21:27:02 -0500
Date: Thu, 21 Dec 2000 20:56:11 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jan Niehusmann <jan@gondor.com>, linux-kernel@vger.kernel.org,
        adilger@turbolinux.com
Subject: Re: [PATCH] Re: fs corruption with invalidate_buffers()
In-Reply-To: <Pine.LNX.4.10.10012211634440.945-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012212054350.5877-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Dec 2000, Linus Torvalds wrote:

> 
> 
> On Fri, 22 Dec 2000, Jan Niehusmann wrote:
> > 
> > This is the result - against test12-pre7, but works well with 
> > test13-pre3:
> 
> This looks bogus.

It is bogus. My apologies.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
