Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270281AbTGNOdr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270609AbTGNOdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 10:33:46 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:40643 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S270281AbTGNOc0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 10:32:26 -0400
Date: Mon, 14 Jul 2003 16:46:35 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: =?iso-8859-1?q?Mike=20Martin?= <redtuxxx@yahoo.co.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Kernel oops with 2.5.74 2.5.75
In-Reply-To: <20030714140127.4336.qmail@web60004.mail.yahoo.com>
Message-ID: <Pine.SOL.4.30.0307141643040.484-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please send dmesg with oops
(make sure you have CONFIG_KALLSYMS enabled).

--
Bartlomiej

On Mon, 14 Jul 2003, [iso-8859-1] Mike Martin wrote:

> I am getting a kernel oops with both these kernels as soon as it the
> kernel loads the ide drivers (hd*)
>
> I am using ALI1542 chipset, K6/2 500 cpu
> I have tried progressively disabling various ide options (cramfs,
> acls tcq etc) to no effect
>
> I run ext3 compiled in
>
> This is on a base of RH9 with updated modutils from rawhide.
>
> The kernel apparrently compiles fine (no errors)
>
> Anyone any ideas what could be the cause of this (2.5.66 worked on
> this machine and runs 2.4.21 fine)
>
> If its not a simple fix I will bugzilla it

