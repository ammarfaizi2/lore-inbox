Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261736AbTC1AAD>; Thu, 27 Mar 2003 19:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261764AbTC1AAD>; Thu, 27 Mar 2003 19:00:03 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:34974 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S261736AbTC1AAB>; Thu, 27 Mar 2003 19:00:01 -0500
Date: Fri, 28 Mar 2003 01:10:56 +0100 (MET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Andre Hedrick <andre@linux-ide.org>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] 2.5.66 bio traversal + IDE PIO patches on the way
In-Reply-To: <1048809404.3952.6.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.SOL.4.30.0303280106070.11685-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 27 Mar 2003, Alan Cox wrote:

> On Thu, 2003-03-27 at 23:46, Bartlomiej Zolnierkiewicz wrote:
> > 2.5.66-ide-pio-1-A0.diff
> > 2.5.66-ide-pio-2-A0.diff
> > and turn on IDE_TASKFILE_IO config option in IDE menu
> >
> > As always with block or IDE changes special care is _strongly_
> > recommended, don't blame me if it eats your fs :-).
>
> The IDE taskfile stuff for I/O is known broken. Thats why it
> is currently disabled. I plan to keep it that way until 2.7

What is broken?
It works just as good as standard code
(with taskfile fixes from ide-pio-1 and ide-pio-2 patches)
...or I am missing something?

--
Bartlomiej Zolnierkiewicz

