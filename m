Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315208AbSEDWFf>; Sat, 4 May 2002 18:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315221AbSEDWFe>; Sat, 4 May 2002 18:05:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7443 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315208AbSEDWFd>; Sat, 4 May 2002 18:05:33 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] initramfs
Date: 4 May 2002 15:05:24 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ab1lv4$2gf$1@cesium.transmeta.com>
In-Reply-To: <1744hw-0EYlYuC@fwd01.sul.t-online.com> <Pine.GSO.4.21.0205041509300.23892-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.GSO.4.21.0205041509300.23892-100000@weyl.math.psu.edu>
By author:    Alexander Viro <viro@math.psu.edu>
In newsgroup: linux.dev.kernel
> 
> Until that is done the ungzip/uncpio part is pretty much pointless...  It
> can go into the kernel anytime, but what would it give us if we don't have
> stuff to put in there?
> 

Something to develop further with.  A stepping stone, if you want.

	-hpa


-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
