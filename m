Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135670AbRAJWIx>; Wed, 10 Jan 2001 17:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135922AbRAJWIn>; Wed, 10 Jan 2001 17:08:43 -0500
Received: from mail.sun.ac.za ([146.232.128.1]:12562 "EHLO mail.sun.ac.za")
	by vger.kernel.org with ESMTP id <S135670AbRAJWIb>;
	Wed, 10 Jan 2001 17:08:31 -0500
Date: Thu, 11 Jan 2001 00:08:24 +0200 (SAST)
From: Hans Grobler <grobh@sun.ac.za>
To: Dennis <dennis@etinc.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Drivers under 2.4
In-Reply-To: <20010110223836.A7321@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.30.0101110003020.30013-100000@prime.sun.ac.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, Andi Kleen wrote:
> On Wed, Jan 10, 2001 at 04:37:06PM -0500, Dennis wrote:
> >
> > Aren't you supposed to design the spec BEFORE  you implement it?
>
> Try http://www.firstfloor.org/~andi/softnet (minor details outdated)

The softnet changes are most likely the primary source of breakage (for
network drivers).

You should also read the kernel-* docs under Documentation/DocBook
(see Documentation/kernel-doc-nano-HOWTO.txt).

-- Hans

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
