Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131813AbRCUW4y>; Wed, 21 Mar 2001 17:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131817AbRCUW4o>; Wed, 21 Mar 2001 17:56:44 -0500
Received: from viper.haque.net ([64.0.249.226]:21646 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S131813AbRCUW4e>;
	Wed, 21 Mar 2001 17:56:34 -0500
Date: Wed, 21 Mar 2001 17:55:43 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Andreas Dilger <adilger@turbolinux.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ext2_unlink fun
In-Reply-To: <200103212128.f2LLSRx20724@webber.adilger.int>
Message-ID: <Pine.LNX.4.32.0103211750020.31946-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2001, Andreas Dilger wrote:

> > debugfs:  stat 199908231702.txt
> > Inode: 1343489   Type: bad type    Mode:  0000   Flags: 0x0
> > Version/Generation: 0
> > User:     0   Group:     0   Size: 0
> > File ACL: 0    Directory ACL: 0
> > Links: 0   Blockcount: 0
> > Fragment:  Address: 0    Number: 0    Size: 0
> > ctime: 0x00000000 -- Wed Dec 31 19:00:00 1969
> > atime: 0x00000000 -- Wed Dec 31 19:00:00 1969
> > mtime: 0x00000000 -- Wed Dec 31 19:00:00 1969
> > BLOCKS:
>
> Maybe you really _are_ having I/O errors?  That would explain the zero'd
> inode table and the I/O error messages.

*shrug* Maybe. This is beyond the scope of what I know but I'm trying to
learn.

If no one else wants anything, I'll be reformatting that partition
tonight after seeing what fsck does.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

