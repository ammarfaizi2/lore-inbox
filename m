Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265299AbUEZDgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265299AbUEZDgn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 23:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265297AbUEZDgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 23:36:43 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:41633 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265299AbUEZDgl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 23:36:41 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Giuliano Pochini <pochini@denise.shiny.it>,
       "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
Subject: Re: Linux Kernel 2.6.6 IDE shutdown problems.
Date: Tue, 25 May 2004 17:03:42 +0200
User-Agent: KMail/1.5.3
Cc: Tom Vier <tmv@comcast.net>, linux-kernel@vger.kernel.org
References: <BAY18-F105X7rz6AvEm0002622f@hotmail.com> <20040524171656.GA19026@bounceswoosh.org> <Pine.LNX.4.58.0405251101240.1197@denise.shiny.it>
In-Reply-To: <Pine.LNX.4.58.0405251101240.1197@denise.shiny.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405251703.43000.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 of May 2004 11:05, Giuliano Pochini wrote:
> On Mon, 24 May 2004, Eric D. Mudama wrote:
> > Picture a nice fast drive doing 100 writes/second to the media... if
> > you give it over 200 writes at a time, it'll occupy your 2 seconds.
> > Newer drives with 8MB or larger buffers are certainly capable of
> > caching a lot more than 200 writes...
>
> Quite unlikely. Usually disks have a big cache but it can hold a very
> limited number of blocks. 8MB of cache is probably divided in 8 blocks
> of 1MB each.

No.

