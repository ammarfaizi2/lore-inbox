Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277262AbRJLG4l>; Fri, 12 Oct 2001 02:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277260AbRJLG4a>; Fri, 12 Oct 2001 02:56:30 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:33319 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S277262AbRJLG4U>; Fri, 12 Oct 2001 02:56:20 -0400
Date: Fri, 12 Oct 2001 09:56:19 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: "T. A." <tkhoadfdsaf@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which kernel (Linus or ac)?
Message-ID: <20011012095618.R22640@niksula.cs.hut.fi>
In-Reply-To: <XFMail.20011011094548.jkp@riker.nailed.org> <3BC5E152.3D81631@bigfoot.com> <3BC5E3AF.588D0A55@lexus.com> <OE22ITtCsuSYkbAY0Jp0000df3f@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OE22ITtCsuSYkbAY0Jp0000df3f@hotmail.com>; from tkhoadfdsaf@hotmail.com on Fri, Oct 12, 2001 at 12:37:01AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 12:37:01AM -0400, you [T. A.] claimed:
> Well I'd have to agree that for stability I'd also go for 2.2.x.  2.4.x
> isn't bad but 2.2.x is just rock stable right now.  Furthermore its been
> hard to gain confidence in 2.4.x with all the bugs that have yet to be
> worked out.  I'd use 2.2.x almost exclusively if it would just gain support
> for the latest EIDE chipsets, a journaling filesystem, and the latest SMP
> boards.  iptables and large file support would also be great.

Of course, you can get most of the IDE chipset support, fs support (reiserfs
3.5, ext3) and LFS support as patches for 2.2:

ftp://ftp.kernel.org/pub/linux/kernel/people/hedrick/ide-2.2.19/

ftp://ftp.namesys.com/pub/reiserfs-for-2.2/linux-2.2.19-reiserfs-3.5.34-patch.bz2
ftp://ftp.kernel.org/pub/linux/kernel/people/sct/ext3/

http://moldybread.net/patch/kernel-2.2/linux-2.2.19-lfs-1.0.diff.gz



-- v --

v@iki.fi
