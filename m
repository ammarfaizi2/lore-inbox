Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266019AbUAEXkm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266023AbUAEXiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:38:06 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:40712 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266019AbUAEXet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:34:49 -0500
Date: Mon, 5 Jan 2004 23:34:46 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Dan Egli <dan@eglifamily.dnsalias.net>
cc: Thomas Molina <tmolina@cablespeed.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Blank Screen in 2.6.0
In-Reply-To: <3FF1E83D.7080008@eglifamily.dnsalias.net>
Message-ID: <Pine.LNX.4.44.0401052334110.7347-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> |>The decision to release 2.6.0 with the same broken vga= option that was
> |>reported many times in 2.6.0-test* makes me think that vga= is not
> intended
> |>to work.
> |
> |
> | Maybe it has something to do with RedHat 7.3.  I've used RH8, RH9, and
> | Fedora Core 1 and haven't had a problem with vga= in any of them during
> | the 2.5/2.6 series, right up through the current one.  I've got
> | framebuffer support as a module.
> |
> 
> 
> Not RedHat 9 issue because I'm using RH 9 and I am the one that started
> this thread.

Its a bug in the kernel. Fixed in latest tree.

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz


