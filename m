Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVEWEKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVEWEKd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 00:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbVEWEKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 00:10:32 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:34571 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261834AbVEWEK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 00:10:28 -0400
Date: Mon, 23 May 2005 06:09:05 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: When we detect that a 16550 was in fact part of a NatSemi SuperIO chip
Message-ID: <20050523040905.GH18600@alpha.home.local>
References: <200505220008.j4M08uE9025378@hera.kernel.org> <1116763033.19183.14.camel@localhost.localdomain> <20050522135943.E12146@flint.arm.linux.org.uk> <20050522144123.F12146@flint.arm.linux.org.uk> <1116796612.5730.15.camel@localhost.localdomain> <Pine.LNX.4.58.0505221438260.2307@ppc970.osdl.org> <1116800555.5744.21.camel@localhost.localdomain> <Pine.LNX.4.58.0505221535370.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505221535370.2307@ppc970.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

On Sun, May 22, 2005 at 03:40:24PM -0700, Linus Torvalds wrote:
(...)
> -        Developer's Certificate of Origin 1.0
> +        Developer's Certificate of Origin 1.1
(...)
>  then you just add a line saying
>  
>  	Signed-off-by: Random J Developer <random@developer.org>

Why not change this slightly to something like :

       DCO-1.1-Signed-off-by: Random J Developer <random@developer.org>

which would imply that this person has read (and agreed with) version 1.1 ?

Willy

