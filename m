Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277294AbRKVQBj>; Thu, 22 Nov 2001 11:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277258AbRKVQBa>; Thu, 22 Nov 2001 11:01:30 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:10564 "EHLO
	c0mailgw12.prontomail.com") by vger.kernel.org with ESMTP
	id <S279912AbRKVQB0>; Thu, 22 Nov 2001 11:01:26 -0500
Message-ID: <3BFD210F.58495F37@starband.net>
Date: Thu, 22 Nov 2001 11:00:15 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James A Sutherland <jas88@cam.ac.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Swap vs No Swap.
In-Reply-To: <3BFC5A9B.915B77DF@starband.net> <E166rbB-0005LC-00@mauve.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Incorrect, my point is I have enough ram where I am not going to run out for the
things I do.

Using swap simply slows the system down!


James A Sutherland wrote:

> On Thursday 22 November 2001 1:53 am, war wrote:
> > I do not understand something.
> >
> > How can having swap speed ANYTHING up?
>
> By providing ADDITIONAL storage. Yes, it's slower than RAM - but it's faster
> than not having the storage at all.
>
> > RAM = 1000MB/s.
> > DISK = 10MB/s
> >
> > Ram is generally 1000x faster than a hard disk.
> >
> > No swap = fastest possible solution.
>
> BS. You don't use swap INSTEAD of RAM, but AS WELL AS. Moving less frequently
> used data to swap allows you to put more frequently used data in RAM, which
> DOES speed things up. (At least, it does if the VM system works properly :P)
>
> By your logic, we should switch off the system RAM, too: after all, L2 cache
> is much faster again, so using RAM can only slow things down?
>
> James.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

