Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315222AbSEDWSY>; Sat, 4 May 2002 18:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315223AbSEDWSX>; Sat, 4 May 2002 18:18:23 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:63912 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315222AbSEDWSW>;
	Sat, 4 May 2002 18:18:22 -0400
Date: Sat, 4 May 2002 18:18:21 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initramfs
In-Reply-To: <ab1lv4$2gf$1@cesium.transmeta.com>
Message-ID: <Pine.GSO.4.21.0205041817200.23892-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 4 May 2002, H. Peter Anvin wrote:

> Followup to:  <Pine.GSO.4.21.0205041509300.23892-100000@weyl.math.psu.edu>
> By author:    Alexander Viro <viro@math.psu.edu>
> In newsgroup: linux.dev.kernel
> > 
> > Until that is done the ungzip/uncpio part is pretty much pointless...  It
> > can go into the kernel anytime, but what would it give us if we don't have
> > stuff to put in there?
> > 
> 
> Something to develop further with.  A stepping stone, if you want.

<shrug>  OK, no problem.  I'll port the code over to the current tree
and post it tonight.  Not that there was a lot to port, to start with -
the thing is fairly small and simple...

