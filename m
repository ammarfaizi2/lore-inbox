Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266052AbTLIQHV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 11:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266088AbTLIQHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 11:07:21 -0500
Received: from [193.138.115.2] ([193.138.115.2]:41735 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S266052AbTLIQHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 11:07:17 -0500
Date: Tue, 9 Dec 2003 17:04:47 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: =?iso-8859-1?q?moi=20toi?= <mikemaster_f@yahoo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: Physical address
In-Reply-To: <20031208150713.39743.qmail@web25201.mail.ukl.yahoo.com>
Message-ID: <8A43C34093B3D5119F7D0004AC56F4BC0706E5CE@difpst1a.dif.dk>
References: <20031208150713.39743.qmail@web25201.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Dec 2003, moi toi wrote:

> Hi
>
> I am a newbie in the development of Linux driver. I
> have some
> difficulties to understand how the memory management
> works.
>
> I am working on a Pentium IV ( 512M of RAM), with the
> Red Hat 9.0.
> I want to create buffers in the RAM which are
> available for DMA
> transfer, and I want that process can map them.
>

I recently came across a good article in Linux Journal by Robert Love that
explains how to allocate memory in the kernel and the various options you
have.
The article was called "Allocating Memory in the Kernel" and appeared in
the December 2003 issue. You can also find it online here:
http://www.linuxjournal.com/article.php?sid=6930


Hope this helps you.


Kind regards,

Jesper Juhl

