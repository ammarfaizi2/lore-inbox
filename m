Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269558AbRHAARa>; Tue, 31 Jul 2001 20:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269562AbRHAARU>; Tue, 31 Jul 2001 20:17:20 -0400
Received: from b0rked.dhs.org ([216.99.196.11]:50817 "HELO b0rked.dhs.org")
	by vger.kernel.org with SMTP id <S269556AbRHAARM>;
	Tue, 31 Jul 2001 20:17:12 -0400
Date: Tue, 31 Jul 2001 17:17:17 -0700 (PDT)
From: Chris Vandomelen <chrisv@b0rked.dhs.org>
X-X-Sender: <chrisv@linux.local>
To: Nerijus Baliunas <nerijus@users.sourceforge.net>
Cc: Guest section DW <dwguest@win.tue.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: Re[4]: cannot copy files larger than 40 MB from CD
In-Reply-To: <200108010004.CAA1062359@mail.takas.lt>
Message-ID: <Pine.LNX.4.31.0107311708450.10245-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> On Tue, 31 Jul 2001 16:58:06 -0700 (PDT) Chris Vandomelen <chrisv@b0rked.dhs.org> wrote:
>
> CV> > Tried vfat, ext2 and reiserfs.
> CV> >
> CV> > BTW, kernel is compiled with gcc-2.96-85, glibc-2.2.2-10 (RH 7.1) if
> CV>                                ^^^^^^^^^^^
> CV> > that matters.
> CV>
> CV> Have you tried compiling your kernel using kgcc?
>
> No.
>
> CV> gcc-2.96.* is known to compile code incorrectly AFAIK, and shouldn't be
> CV> used for compiling kernels. (kgcc is egcs-1.1.2, I think.)
>
> As I remember Alan said recent 2.4 kernels should be compiled with gcc 2.95
> or 2.96 (preferably?).

Everything that I've seen recommends egcs-1.1.2. The kernel documentation
(linux/Documentation/Changes) recommends that version of egcs, as do some
list messages around 12/00.

Chris


