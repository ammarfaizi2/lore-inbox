Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262606AbTCMWMs>; Thu, 13 Mar 2003 17:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262700AbTCMWMr>; Thu, 13 Mar 2003 17:12:47 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:47030 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S262606AbTCMWMr>;
	Thu, 13 Mar 2003 17:12:47 -0500
Message-Id: <200303132121.h2DLLdcp005933@eeyore.valparaiso.cl>
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone 
In-Reply-To: Your message of "Thu, 13 Mar 2003 01:41:45 +0100."
             <20030313004145.GG5958@zaurus.ucw.cz> 
Date: Thu, 13 Mar 2003 17:21:39 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc: chopped _way_ down]
Pavel Machek <pavel@ucw.cz> dijo:

[...]

> Take a look at e2fsck. That's similar to
> bk -- awfull lot of corner cases. And
> guess what, if you mess up your disk
> badly enough, it will just tell you to
> fix it by hand (deallocate block free bitmap
> in full group). And its okay.
> (Plus I believe chkdsk has *way* bigger
> problems than that.)
> I'm sure you are not going to throw away
> ext2 just because it has 1-person-per-3-years
> problem. 99% solution is going to be
> good enough for me, Andrea and
> Martin. Linus can keep using bk.

"Sorry, corner case encountered. Your repository is toast, get a fresh
copy" will make you an extremely popular sort of game...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
