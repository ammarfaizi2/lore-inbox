Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265091AbSKAQNz>; Fri, 1 Nov 2002 11:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265254AbSKAQNz>; Fri, 1 Nov 2002 11:13:55 -0500
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:17356 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265091AbSKAQNs>; Fri, 1 Nov 2002 11:13:48 -0500
Date: Fri, 1 Nov 2002 09:13:37 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Skip Ford <skip.ford@verizon.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK console] console updates.
In-Reply-To: <200211011106.gA1B6EFF001384@pool-141-150-241-241.delv.east.verizon.net>
Message-ID: <Pine.LNX.4.33.0211010913190.6296-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> James Simmons wrote:
> > Okay. Here is the new console system. The patch is against 2.5.45.
> > Please note only vgacon has been fixed to work with this new api.
> >
> > http://phoenix.infradead.org/~jsimmons/console.diff.gz
> >
> > Diff stats:
> >  arch/i386/vmlinux.lds.s                     |  109
>
> Your patch creates the above linker script.  It appears to be a copy
> of vmlinux.lds.S from the same directory.

Strange. I fixed that. All clean.

