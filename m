Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316309AbSFJV2K>; Mon, 10 Jun 2002 17:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316342AbSFJV2J>; Mon, 10 Jun 2002 17:28:09 -0400
Received: from p50887BDF.dip.t-dialin.net ([80.136.123.223]:1688 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316309AbSFJV2H>; Mon, 10 Jun 2002 17:28:07 -0400
Date: Mon, 10 Jun 2002 15:28:02 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Dan Aloni <da-x@gmx.net>
cc: Lightweight patch manager <patch@luckynet.dynu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5.21 - list.h cleanup
In-Reply-To: <20020610152824.GC9581@callisto.yi.org>
Message-ID: <Pine.LNX.4.44.0206101527090.6159-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 10 Jun 2002, Dan Aloni wrote:
>  + replace __inline__ with inline.
>  + use list_t intead of struct list_head (no bytes we harmed, bla.. bla..)
>  + add the new list_move and list_move_tail mutators as inline functions.

Deja vu feeling...

It's already in the Linus tree, why do you resend it?!

Regards,
Thunder
-- 
German attitude becoming        |	Thunder from the hill at ngforever
rightaway popular:		|
       "Get outa my way,  	|	free inhabitant not directly
    for I got a mobile phone!"	|	belonging anywhere

