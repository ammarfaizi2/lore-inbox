Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316991AbSFKKYr>; Tue, 11 Jun 2002 06:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316992AbSFKKYl>; Tue, 11 Jun 2002 06:24:41 -0400
Received: from pD952A4ED.dip.t-dialin.net ([217.82.164.237]:22726 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316991AbSFKKYL>; Tue, 11 Jun 2002 06:24:11 -0400
Date: Tue, 11 Jun 2002 04:24:01 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Russell King <rmk@arm.linux.org.uk>
cc: Lightweight patch manager <patch@luckynet.dynu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] Double quote patches part one: drivers 1/2
In-Reply-To: <20020611084758.B1346@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0206110422110.24261-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 11 Jun 2002, Russell King wrote:
> 1. Spaces -> source bloat.

No spaces -> looks unsatisfying, someone mentioned.

> 2. No tab at the start of the file -> yuck when reading the ASM.

What do you mean by that?

> My preferred way of fixing these in ARM stuff is to add <tab><tab><tab>\n\
> to each line (with the appropriate number of tabs.  See
> arch/arm/kernel/semaphore.c for an example.

Hmm... Wasn't that the behavior we wanted to fix with the concatenated 
strings?

Regards,
Thunder
-- 
German attitude becoming        |	Thunder from the hill at ngforever
rightaway popular:		|
       "Get outa my way,  	|	free inhabitant not directly
    for I got a mobile phone!"	|	belonging anywhere

