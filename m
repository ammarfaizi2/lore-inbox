Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266030AbUAEXrk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266035AbUAEXoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:44:01 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:48648 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266030AbUAEXnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:43:05 -0500
Date: Mon, 5 Jan 2004 23:43:03 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 vs. vga option
In-Reply-To: <173a01c3cceb$0432e110$43ee4ca5@DIAMONDLX60>
Message-ID: <Pine.LNX.4.44.0401052342200.7347-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have the smae hardware. Give my latest patch a try.

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz


> Oddly, I have found some combination of drivers to compile as built-in and
> some to compile as modules, so that early in the boot sequence the screen
> automatically switches from 80x25 to somewhere around 128x40 even without
> the vga= parameter.  No free penguin though.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

