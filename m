Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266923AbSKKSIF>; Mon, 11 Nov 2002 13:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266924AbSKKSIE>; Mon, 11 Nov 2002 13:08:04 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:60689 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266923AbSKKSIA>; Mon, 11 Nov 2002 13:08:00 -0500
Date: Mon, 11 Nov 2002 18:14:42 +0000 (GMT)
From: James Simmons <jsimmons@phoenix.infradead.org>
To: Matt Reppert <arashi@arashi.yi.org>
cc: Neilen Marais <brick@adept.co.za>, <linux-kernel@vger.kernel.org>
Subject: Re: aty128fb.c does not compile in linux 2.5.46
In-Reply-To: <20021109134059.27e467a0.arashi@arashi.yi.org>
Message-ID: <Pine.LNX.4.44.0211111813410.29629-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yep. There was a recent fbdev API rewrite, not all of the drivers have
> been converted yet. (The radeonfb driver, eg, does this too.)
> 
> You can fix it by looking at the changesets from the PPC Bitkeeper tree
> at http://ppc.bkbits.net:8080/linuxppc-2.5 ... the changes are fairly

Cool. Ben would the ppc guys mind if I grab those files and placed them 
into my latest BK tree. The reason is I want to make them work with the 
latest changes for fbdev. 

