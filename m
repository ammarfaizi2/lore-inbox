Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280700AbRKGOfe>; Wed, 7 Nov 2001 09:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280801AbRKGOfY>; Wed, 7 Nov 2001 09:35:24 -0500
Received: from yoda.planetinternet.be ([195.95.30.146]:3856 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S280700AbRKGOfJ>; Wed, 7 Nov 2001 09:35:09 -0500
Date: Wed, 7 Nov 2001 15:34:59 +0100 (CET)
From: Dirk Moerenhout <dirk@staf.planetinternet.be>
X-X-Sender: <dmoerenh@dirk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Using %cr2 to reference "current"
In-Reply-To: <E161TWH-0004G9-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0111071527390.204-100000@dirk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > somehow encouraged by the compiler comparisions between gcc and intel's
> > free compiler, which use the register passing for anything local
> > to the actual code, where the speed gains are up to 20% im currently
>
> I was under the impression intels compiler was profoundly non-free ?

Thought that too untill a minute ago. Went to the Intel site and read the
information.

http://developer.intel.com/software/products/eval/

Gives details about _two_ ways to get it free. The known 30 day free trial
with support but also a less known "non commercial unsupported" option. So
for non-commercial use you can use it as much as you want, you just don't
get support.

Downloading it now to play some with it :-)

Dirk Moerenhout ///// System Administrator ///// Planet Internet NV

