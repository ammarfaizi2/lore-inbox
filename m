Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315245AbSEYTIE>; Sat, 25 May 2002 15:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315255AbSEYTID>; Sat, 25 May 2002 15:08:03 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:15626 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S315245AbSEYTIC>; Sat, 25 May 2002 15:08:02 -0400
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup parse_options() of fatfs (3/4)
In-Reply-To: <Pine.GSO.4.21.0205251343420.13379-100000@weyl.math.psu.edu>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 26 May 2002 04:07:48 +0900
Message-ID: <87lma8yrjv.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:

> On Sat, 25 May 2002, OGAWA Hirofumi wrote:
> 
> > This patch merges the parse_options() of vfat and fat. And, added the
> > (borrowed from ext3) code for reporting the error of specified
> > options.
> > 
> > Please apply.
> 
> Please, hold on.  If we are going to do that, we'd better do it right...
> I'll resurrect and post the options-parser patch - it covers all that
> stuff with less ad-hackery.

Good. I was actually waiting for it.
Please post that patch.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
