Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287966AbSBIAvO>; Fri, 8 Feb 2002 19:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287924AbSBIAvF>; Fri, 8 Feb 2002 19:51:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29969 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287933AbSBIAuq>; Fri, 8 Feb 2002 19:50:46 -0500
Date: Fri, 8 Feb 2002 16:49:32 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Submitting BK patches...
In-Reply-To: <3C646C74.4EEC674A@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0202081648420.11791-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 8 Feb 2002, Jeff Garzik wrote:
>
> Here's modifying my patch submission method a bit.  I have taken my
> pending changes for you, and split them up into different BK clones.
> Each tree represents a different patch "theme", for different types of
> patches being submitted to you:  net driver maintenance stuff is at
> http://gkernel.bkbits.net/net-drivers-2.5, filesystem-related stuff can
> be stored at fs-2.5, small driver fixes at small-fixes-2.5, etc.  This
> gives you a more fine grain from which to 'bk pull'.

This sounds very good, exactly how I want to work.

		Linus

