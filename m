Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSFDRUe>; Tue, 4 Jun 2002 13:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315282AbSFDRUd>; Tue, 4 Jun 2002 13:20:33 -0400
Received: from www.transvirtual.com ([206.14.214.140]:34322 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S315279AbSFDRUc>; Tue, 4 Jun 2002 13:20:32 -0400
Date: Tue, 4 Jun 2002 10:20:28 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Miles Lane <miles@megapathdsl.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.20-dj1 + fbcmap.c patch -- neofb.c:71: video/neomagic.h: No
 such file or directory
In-Reply-To: <1023209774.20260.24.camel@agate>
Message-ID: <Pine.LNX.4.44.0206040945150.29334-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> gcc -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
> -pipe -mpreferred-stack-boundary=2 -march=i686
> -DKBUILD_BASENAME=neofb  -c -o neofb.o neofb.c
> neofb.c:71: video/neomagic.h: No such file or directory

Yipes. Didn't sync up into Linus tree. I'm going to sync up soon again.
Just as soon as I get approval from a few driver maintainers.


