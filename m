Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129167AbRBAIDz>; Thu, 1 Feb 2001 03:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129272AbRBAIDp>; Thu, 1 Feb 2001 03:03:45 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:13364 "EHLO
	amsmta01-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129167AbRBAIDl>; Thu, 1 Feb 2001 03:03:41 -0500
Date: Thu, 1 Feb 2001 10:10:28 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: bert hubert <ahu@ds9a.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Vanilla 2.4.0 ext2fs error
In-Reply-To: <20010131184152.A3287@home.ds9a.nl>
Message-ID: <Pine.LNX.4.21.0102011009420.11829-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, bert hubert wrote:

> On Wed, Jan 31, 2001 at 06:21:04PM +0100, Igmar Palsenberg wrote:
> 
> > Jan 31 18:01:57 base kernel: EXT2-fs error (device ide0(3,71)):
> > ext2_new_inode:
> > reserved inode or inode > inodes count - block_group = 0,inode=1
> 
> does fsck run on this fs find any errors?

Haven't tried, but highly unlikely.. The FS was formatted about 20 seconds
before the error :)

I'll give it a try.

> Huge .sig!

I like them :)


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
