Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279984AbRKVQ1L>; Thu, 22 Nov 2001 11:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279986AbRKVQ1A>; Thu, 22 Nov 2001 11:27:00 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:9126 "EHLO
	c0mailgw02.prontomail.com") by vger.kernel.org with ESMTP
	id <S279984AbRKVQ0u>; Thu, 22 Nov 2001 11:26:50 -0500
Message-ID: <3BFD2709.31A1A85E@starband.net>
Date: Thu, 22 Nov 2001 11:25:45 -0500
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

Why have SWAP if you don't need it - answer that.?

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

