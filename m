Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271740AbTHMKgS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 06:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271742AbTHMKgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 06:36:18 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:24746 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S271740AbTHMKgR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 06:36:17 -0400
Date: Wed, 13 Aug 2003 13:36:13 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: Vid Strpic <vms@bofhlet.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: (no subject)
In-Reply-To: <20030813091453.GJ30507@home.bofhlet.net>
Message-ID: <Pine.LNX.4.56.0308131334580.18973@hosting.rdsbv.ro>
References: <20030813091453.GJ30507@home.bofhlet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Aug 12, 2003 at 04:55:19PM +0300, Catalin BOIE wrote:
> > "cat drivers/built-in.o > /dev/null" gives me i/o error.
> > Can I suspect a bad sector?
>
> Where, in memory? :)  /dev/null is in memory :)
:)
 ran badblocks and the disk is ok.
2.6.0test3mm1 let me read that file without i/o.


> > I use reiserfs.
>
> Any other file gives that?

Nope.

Also in 2.4.22pre? I can read ok the file.

>
> --
>            vms@bofhlet.net, IRC:*@Martin, /bin/zsh. C|N>K
> Linux lorien 2.4.21 #1 Sat Jun 14 01:23:07 CEST 2003 i586
>  11:13:51 up 38 days, 21:33, 10 users,  load average: 0.03, 0.26, 0.18
>

---
Catalin(ux) BOIE
catab@deuroconsult.ro
