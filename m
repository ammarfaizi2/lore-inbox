Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbUB2DBH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 22:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbUB2DBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 22:01:06 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:45956 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261969AbUB2DBE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 22:01:04 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeff Garzik <jgarzik@pobox.com>, Matt Mackall <mpm@selenic.com>
Subject: Re: Worrisome IDE PIO transfers...
Date: Sun, 29 Feb 2004 04:08:12 +0100
User-Agent: KMail/1.5.3
Cc: Jens Axboe <axboe@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <4041232C.7030305@pobox.com> <20040229015041.GQ3883@waste.org> <40415152.8040205@pobox.com>
In-Reply-To: <40415152.8040205@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402290408.12917.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 of February 2004 03:41, Jeff Garzik wrote:
> Matt Mackall wrote:
> > On Sun, Feb 29, 2004 at 01:21:30AM +0100, Bartlomiej Zolnierkiewicz wrote:
> >>I like Alan's idea to use loopback instead of "bswap".
> >
> > Or, more likely, device mapper.
>
> Somehow I doubt anybody cares enough to write a whole driver just for
> this unlikely case.

Any TiVo hacker reading this? :)

> For now let's at least record the knowledge...  (patch attached)

Ok, thanks.

Bartlomiej

