Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267652AbUH0UlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267652AbUH0UlE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266756AbUH0UkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:40:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:58592 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267605AbUH0Uiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 16:38:55 -0400
Date: Fri, 27 Aug 2004 13:38:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?ISO-8859-1?Q?Markus_T=F6rnqvist?= <mjt@nysv.org>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Hans Reiser <reiser@namesys.com>,
       Andrew Morton <akpm@osdl.org>, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040827203216.GC1284@nysv.org>
Message-ID: <Pine.LNX.4.58.0408271335421.14196@ppc970.osdl.org>
References: <412D9FE6.9050307@namesys.com> <200408261812.i7QICW8r002679@localhost.localdomain>
 <20040827203216.GC1284@nysv.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Aug 2004, Markus Törnqvist wrote:
> 
> People will say it when people stop using Linux on servers because
> they can integrate metadata easier in other operating systems ;)

Heh. Considering that WinFS seems to be delayed yet more, I don't think 
that's a very strong argument.

Hell will freeze over before Microsoft does a filesystem right. Besides,
WinFS is likely almost in user mode anyway, ie mostly a library, rather
like the gnome people are already doing with nome storage.

So there's really no point in trying to push your agenda by trying to 
scare people with MS activities. Linux kernel developers do what's right 
because it is _right_, not because somebody else does it.

		Linus
