Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277633AbRJLLgV>; Fri, 12 Oct 2001 07:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277630AbRJLLgL>; Fri, 12 Oct 2001 07:36:11 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:32592 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277629AbRJLLf6>; Fri, 12 Oct 2001 07:35:58 -0400
Date: Fri, 12 Oct 2001 13:35:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
Cc: "T. A." <tkhoadfdsaf@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Which kernel (Linus or ac)?
Message-ID: <20011012133551.H714@athlon.random>
In-Reply-To: <XFMail.20011011094548.jkp@riker.nailed.org> <3BC5E152.3D81631@bigfoot.com> <3BC5E3AF.588D0A55@lexus.com> <OE22ITtCsuSYkbAY0Jp0000df3f@hotmail.com> <20011012095618.R22640@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011012095618.R22640@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Fri, Oct 12, 2001 at 09:56:19AM +0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 09:56:19AM +0300, Ville Herva wrote:
> On Fri, Oct 12, 2001 at 12:37:01AM -0400, you [T. A.] claimed:
> > Well I'd have to agree that for stability I'd also go for 2.2.x.  2.4.x
> > isn't bad but 2.2.x is just rock stable right now.  Furthermore its been
> > hard to gain confidence in 2.4.x with all the bugs that have yet to be
> > worked out.  I'd use 2.2.x almost exclusively if it would just gain support
> > for the latest EIDE chipsets, a journaling filesystem, and the latest SMP
> > boards.  iptables and large file support would also be great.
> 
> Of course, you can get most of the IDE chipset support, fs support (reiserfs
> 3.5, ext3) and LFS support as patches for 2.2:

btw, just a reminder, 2.2.20pre10aa1 has full lfs support too
(everything, including getdents64, nfv3, lockd all 64bit).

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.20pre10aa1.bz2
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.20pre10aa1/40_lfs-2.2.20pre10aa1-28.bz2

Andrea
