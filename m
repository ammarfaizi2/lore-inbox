Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310568AbSCMOpG>; Wed, 13 Mar 2002 09:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310455AbSCMOo4>; Wed, 13 Mar 2002 09:44:56 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:14352 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S310568AbSCMOoo>; Wed, 13 Mar 2002 09:44:44 -0500
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Alexander Viro <viro@math.psu.edu>, Rusty Russell <rusty@rustcorp.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: (FORWARD) =?iso-8859-1?q?Ren=E9?= Scharfe: [PATCH] MS DOS
  filesystem option mistreatment
In-Reply-To: <E16l0Py-0005nk-00@wagner.rustcorp.com.au>
	<Pine.GSO.4.21.0203122333460.20323-100000@weyl.math.psu.edu>
	<20020313050108.GN18882@turbolinux.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 13 Mar 2002 23:36:01 +0900
In-Reply-To: <20020313050108.GN18882@turbolinux.com>
Message-ID: <87adtczga6.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@clusterfs.com> writes:

> On Mar 12, 2002  23:35 -0500, Alexander Viro wrote:
> > On Wed, 13 Mar 2002, Rusty Russell wrote:
> > > This seems correct.  Al?
> > 
> > Looks sane...  I don't know who maintains fs/msdos/* these days (and I
> > seriously suspect that the answer is "nobody"), so probably patch should
> > go straight to Linus.
> 
> Maybe OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>?  He has been sending
> a few FAT patches recently.

If I'm maintainer, I'll apply that patch. Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
