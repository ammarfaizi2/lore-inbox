Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275839AbRJBFEi>; Tue, 2 Oct 2001 01:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275806AbRJBFES>; Tue, 2 Oct 2001 01:04:18 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:55812 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S275765AbRJBFEG>; Tue, 2 Oct 2001 01:04:06 -0400
Subject: RE:  2.4.11-ac3 -- unresolved symbols in cramfs.o --
	zlib_fs_inflateInit_, zlib_fs_inflateEnd, zlib_fs_inflate_workspacesize, ...
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99 (Preview Release)
Date: 01 Oct 2001 21:56:44 -0700
Message-Id: <1001998604.8562.4.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problem is still present in 2.4.11-ac3.

> Frank Davis <fdavis@si.rr.com> wrote:
> 
> Hello all,
>     I received the following while 'make modules_install'
> depmod: *** Unresolved symbols in 
> /lib/modules/2.4.9-ac17/kernel/fs/cramfs/cramfs/cramfs.o
> depmod:  zlib_fs_inflateInit_
> depmod:  zlib_fs_inflateEnd
> depmod:  zlib_fs_inflate_workspacesize
> depmod:  zlib_fs_inflate
> depmod:  zlib_fs_inflateReset
> 
> Used the same config that worked with 2.4.9-ac16 . Using gcc 
> 2.91.66..Upgrading to 2.95.4 soon.
> 
> Regards,
> Frank



