Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314221AbSEFGah>; Mon, 6 May 2002 02:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314227AbSEFGag>; Mon, 6 May 2002 02:30:36 -0400
Received: from melancholia.rimspace.net ([210.23.138.19]:40456 "EHLO
	melancholia.danann.net") by vger.kernel.org with ESMTP
	id <S314221AbSEFGaf>; Mon, 6 May 2002 02:30:35 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: Linux-2.5.14..
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com>
From: Daniel Pittman <daniel@rimspace.net>
Organization: Not today, thank you, Mother.
Date: Mon, 06 May 2002 16:30:28 +1000
Message-ID: <87g015bxff.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.5 (bamboo,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 May 2002, Linus Torvalds wrote:
> There's a lot of stuff that has happened in the 2.5.x series lately,
> and you can see the gory details in the ChangeLog files that accompany
> releases these days, but I thought I'd point out 2.5.14, since it has
> some interesting fundamental changes to how dirty state is maintained
> in the VM.
> 
> (The big changes were actually in 2.5.12, but 2.5.13 contained various
> minor fixes and tweaks, and 2.5.14 contains a number of fixes
> especially wrt truncate, so hopefully it's fairly _stable_ as of
> 2.5.14.)

>From the look of the changelog at least a few of the file corruption
bugs with ext3, 2k block file systems and 2.5 have been fixed. Should I
expect this release to address the problems I was seeing?

        Daniel

-- 
I keep my head above the surface, trying to breath, looking for land.
I keep an eye at the distant horizon waiting for help, clutching the sky.
        -- Covenant, _Phoenix_
