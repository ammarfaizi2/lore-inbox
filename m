Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316196AbSETSy4>; Mon, 20 May 2002 14:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316209AbSETSyz>; Mon, 20 May 2002 14:54:55 -0400
Received: from chaos.analogic.com ([204.178.40.224]:5760 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316196AbSETSyz>; Mon, 20 May 2002 14:54:55 -0400
Date: Mon, 20 May 2002 14:55:12 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andreas Dilger <adilger@clusterfs.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Mounting 'foreign' file-systems
In-Reply-To: <20020520182457.GA7784@turbolinux.com>
Message-ID: <Pine.LNX.3.95.1020520145306.739A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2002, Andreas Dilger wrote:

> On May 20, 2002  11:22 -0400, Richard B. Johnson wrote:
> > On Linux 2.4.18, I can no longer mount CDROMs that were created
> > using ext2 as the file-system (yes I know this is not specified).
> > I used to use these CDROMs as part of a "rescue" package.
> > 
> > Now, these can still be mounted through the loop device as is
> > shown below....
> 
> Probably a filesystem != CDROM blocksize issue.


Yes, maybe. I'm on a work-break now, but once I get a chance I'll
try block-sizes from 512 bytes to 4 kilobytes and see if that
does it.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

