Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283055AbRLOR71>; Sat, 15 Dec 2001 12:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283057AbRLOR7T>; Sat, 15 Dec 2001 12:59:19 -0500
Received: from www.wen-online.de ([212.223.88.39]:44038 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S283055AbRLOR7J>;
	Sat, 15 Dec 2001 12:59:09 -0500
Date: Sat, 15 Dec 2001 19:03:28 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: pivot_root and initrd kernel panic woes
In-Reply-To: <01121514553501.01834@manta>
Message-ID: <Pine.LNX.4.33.0112151859250.381-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
> Have you tried it with minix initrd from
>
> http://port.imtp.ilyichevsk.odessa.ua/linux/vda/minix.gz

No, I converted my 'fire department' initrd to minix and booted that.

	-Mike

