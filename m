Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292316AbSCMFCg>; Wed, 13 Mar 2002 00:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292329AbSCMFC1>; Wed, 13 Mar 2002 00:02:27 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:21748 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S292316AbSCMFCU>; Wed, 13 Mar 2002 00:02:20 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 12 Mar 2002 22:01:08 -0700
To: Alexander Viro <viro@math.psu.edu>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: (FORWARD) =?unknown-8bit?Q?Ren=E9_Scha?=
	=?unknown-8bit?Q?rfe=3A?= [PATCH] MS DOS filesystem option mistreatment
Message-ID: <20020313050108.GN18882@turbolinux.com>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
In-Reply-To: <E16l0Py-0005nk-00@wagner.rustcorp.com.au> <Pine.GSO.4.21.0203122333460.20323-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0203122333460.20323-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 12, 2002  23:35 -0500, Alexander Viro wrote:
> On Wed, 13 Mar 2002, Rusty Russell wrote:
> > This seems correct.  Al?
> 
> Looks sane...  I don't know who maintains fs/msdos/* these days (and I
> seriously suspect that the answer is "nobody"), so probably patch should
> go straight to Linus.

Maybe OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>?  He has been sending
a few FAT patches recently.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

