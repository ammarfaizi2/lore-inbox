Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315539AbSFJRHL>; Mon, 10 Jun 2002 13:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSFJRHK>; Mon, 10 Jun 2002 13:07:10 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:45990 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S315539AbSFJRHJ>; Mon, 10 Jun 2002 13:07:09 -0400
Date: Mon, 10 Jun 2002 19:07:00 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andreas Dilger <adilger@clusterfs.com>, Dan Aloni <da-x@gmx.net>,
        Lightweight patch manager <patch@luckynet.dynu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 - list.h cleanup
In-Reply-To: <Pine.LNX.4.44.0206100954250.30535-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.05.10206101904480.17299-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Jun 2002, Linus Torvalds wrote:

--snip/snip
> But in the end, maintainership matters. I personally don't want the
> typedef culture to get the upper hand, but I don't mind a few of them, and
> people who maintain their own code usually get the last word.

to sum it up:

using the "struct mystruct" is _recommended_, but not a must.

	tm

-- 
in some way i do, and in some way i don't.

