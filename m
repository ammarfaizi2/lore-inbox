Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282945AbRLORzg>; Sat, 15 Dec 2001 12:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282941AbRLORz0>; Sat, 15 Dec 2001 12:55:26 -0500
Received: from www.wen-online.de ([212.223.88.39]:15109 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S282907AbRLORzP>;
	Sat, 15 Dec 2001 12:55:15 -0500
Date: Sat, 15 Dec 2001 18:59:17 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: pivot_root and initrd kernel panic woes
In-Reply-To: <01121514511400.01834@manta>
Message-ID: <Pine.LNX.4.33.0112151856190.381-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(cc list trimmed.. forgot to do that last time;)

On Sat, 15 Dec 2001, vda wrote:

> On Saturday 15 December 2001 10:14, Mike Galbraith wrote:
> > On Thu, 13 Dec 2001, vda wrote:
> > > On Thursday 13 December 2001 06:19, Alexander Viro wrote:
> > > > On Thu, 13 Dec 2001, vda wrote:
> > > > > BTW, don't go for 2.4x, x>10. initrd is broken there and is still
> > > > > unfixed.
> > > >
> > > > Bullshit.
> > >
> > > I have a slackware initrd (minix) which is booting fine with 2.4.10
> > > but fails to boot with 2.4.12 and later (same .config, same bootloader,
> > > same hardware, same AC voltage in the wall outlet, time of day differs by
> > > 1 minute), so it might be true :-)
> >
> > Hmm.. works here with 2.5.1-pre8.
> >
> > 	-Mike
> > ...
> > RAMDISK driver initialized: 16 RAM disks of 12288K size 1024 blocksize
> > ...
> > RAMDISK: Compressed image found at block 0
> > Freeing initrd memory: 5161k freed
> > MINIX-fs: mounting unchecked file system, running fsck is recommended.
> > VFS: Mounted root (minix filesystem).
> > Freeing unused kernel memory: 236k freed
>
> I'd like to try it, can you send a .config?

.config?.. normal config with initrd+ramdisk+minix in kernel.

	-Mike

