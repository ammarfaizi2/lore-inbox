Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282498AbRLOMz5>; Sat, 15 Dec 2001 07:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282499AbRLOMzr>; Sat, 15 Dec 2001 07:55:47 -0500
Received: from [195.66.192.167] ([195.66.192.167]:4360 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S282498AbRLOMzf>; Sat, 15 Dec 2001 07:55:35 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Mike Galbraith <mikeg@wen-online.de>
Subject: Re: pivot_root and initrd kernel panic woes
Date: Sat, 15 Dec 2001 14:51:14 -0200
X-Mailer: KMail [version 1.2]
Cc: Alexander Viro <viro@math.psu.edu>, Joy Almacen <joy@empexis.com>,
        <wa@almesberger.net>, <linux-kernel@vger.kernel.org>,
        "Stephen C. Tweedie" <sct@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0112151238450.306-100000@mikeg.weiden.de>
In-Reply-To: <Pine.LNX.4.33.0112151238450.306-100000@mikeg.weiden.de>
MIME-Version: 1.0
Message-Id: <01121514511400.01834@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 December 2001 10:14, Mike Galbraith wrote:
> On Thu, 13 Dec 2001, vda wrote:
> > On Thursday 13 December 2001 06:19, Alexander Viro wrote:
> > > On Thu, 13 Dec 2001, vda wrote:
> > > > BTW, don't go for 2.4x, x>10. initrd is broken there and is still
> > > > unfixed.
> > >
> > > Bullshit.
> >
> > I have a slackware initrd (minix) which is booting fine with 2.4.10
> > but fails to boot with 2.4.12 and later (same .config, same bootloader,
> > same hardware, same AC voltage in the wall outlet, time of day differs by
> > 1 minute), so it might be true :-)
>
> Hmm.. works here with 2.5.1-pre8.
>
> 	-Mike
> ...
> RAMDISK driver initialized: 16 RAM disks of 12288K size 1024 blocksize
> ...
> RAMDISK: Compressed image found at block 0
> Freeing initrd memory: 5161k freed
> MINIX-fs: mounting unchecked file system, running fsck is recommended.
> VFS: Mounted root (minix filesystem).
> Freeing unused kernel memory: 236k freed

I'd like to try it, can you send a .config?
--
vda
