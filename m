Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbTJCVUn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 17:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbTJCVUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 17:20:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:34511 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261226AbTJCVUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 17:20:42 -0400
Date: Fri, 3 Oct 2003 14:28:43 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] Some typos
In-Reply-To: <20031001215110.GA5289@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0310031427430.28816-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> --- tmp/linux/kernel/power/swsusp.c	2003-10-01 23:24:42.000000000 +0200
> +++ linux/kernel/power/swsusp.c	2003-10-01 23:18:27.000000000 +0200

> -static void __init software_resume(void)
> +static int __init software_resume(void)

This piece failed. It's easy to fix, but please be more careful when 
sending incremental patches.

Thanks,


	Pat

