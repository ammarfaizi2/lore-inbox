Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbTEHMHy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 08:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbTEHMHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 08:07:54 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56564 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261336AbTEHMHx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 08:07:53 -0400
Date: Thu, 8 May 2003 14:20:08 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
cc: Pascal Schmidt <der.eremit@email.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [IDE] trying to make MO drive work with ide-floppy/ide-cd
In-Reply-To: <20030508120903.GV823@suse.de>
Message-ID: <Pine.SOL.4.30.0305081419311.12362-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 May 2003, Jens Axboe wrote:

> On Thu, May 08 2003, Pascal Schmidt wrote:
> > On Wed, 7 May 2003, Jens Axboe wrote:
> >
> > > Definitely, this looks like a fine start. As far as I'm concerned, it
> > > would be fine to commit to 2.5.
> >
> > As maintainer of ide-cd, would you forward it to Linus, then?
> > CCed Alan for the ide-probe.c change.
>
> Yes I will, I'm checking with Bart too if he's fine with the change.

Looks okay and straightforward.
--
Bartlomiej

> --
> Jens Axboe

