Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316632AbSE3NWO>; Thu, 30 May 2002 09:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316635AbSE3NWN>; Thu, 30 May 2002 09:22:13 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:57995 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316632AbSE3NWM>; Thu, 30 May 2002 09:22:12 -0400
Date: Thu, 30 May 2002 08:22:10 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.19 - What's up with the kernel build?
In-Reply-To: <3CF5E698.2020806@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0205300820220.16047-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2002, Jeff Garzik wrote:

> A small request to add to the list:
> 
> Current 2.4.x kernels build (at least on x86) with
>      -nostdinc -I /usr/lib/gcc-lib/i586-mandrake-linux-gnu/3.0.4/include
> added to CFLAGS...  IMOit is a good idea in general to build all kernel 
> code this way.  (note that userland programs created during build should 
> not use this rule, of course)

Yep, sure make sense. - It was on my list of things to look at anyway, I 
didn't realize it's in 2.4 already, though - so that saves some testing ;)

--Kai


