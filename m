Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269552AbRHAAET>; Tue, 31 Jul 2001 20:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269553AbRHAAEJ>; Tue, 31 Jul 2001 20:04:09 -0400
Received: from srvr2.telecom.lt ([212.59.0.1]:23572 "EHLO mail.takas.lt")
	by vger.kernel.org with ESMTP id <S269552AbRHAADz>;
	Tue, 31 Jul 2001 20:03:55 -0400
Message-Id: <200108010004.CAA1062359@mail.takas.lt>
Date: Wed, 1 Aug 2001 02:03:36 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re[4]: cannot copy files larger than 40 MB from CD
To: Chris Vandomelen <chrisv@b0rked.dhs.org>
cc: Guest section DW <dwguest@win.tue.nl>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
In-Reply-To: <Pine.LNX.4.31.0107311656420.10245-100000@linux.local>
In-Reply-To: <Pine.LNX.4.31.0107311656420.10245-100000@linux.local>
X-Mailer: Mahogany, 0.63 'Saugus', compiled for Linux 2.4.7 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 31 Jul 2001 16:58:06 -0700 (PDT) Chris Vandomelen <chrisv@b0rked.dhs.org> wrote:

CV> > Tried vfat, ext2 and reiserfs.
CV> >
CV> > BTW, kernel is compiled with gcc-2.96-85, glibc-2.2.2-10 (RH 7.1) if
CV>                                ^^^^^^^^^^^
CV> > that matters.
CV> 
CV> Have you tried compiling your kernel using kgcc?

No.

CV> gcc-2.96.* is known to compile code incorrectly AFAIK, and shouldn't be
CV> used for compiling kernels. (kgcc is egcs-1.1.2, I think.)

As I remember Alan said recent 2.4 kernels should be compiled with gcc 2.95
or 2.96 (preferably?).

Regards,
Nerijus


