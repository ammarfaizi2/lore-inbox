Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUDSTII (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 15:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUDSTIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 15:08:07 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:25732 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261712AbUDSTIF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 15:08:05 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Randy.Dunlap" <rddunlap@osdl.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] floppy98.c: use kernel min/max
Date: Mon, 19 Apr 2004 21:06:23 +0200
User-Agent: KMail/1.5.3
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, zwane@linuxpower.ca
References: <20040418194357.4cd02a06.rddunlap@osdl.org> <20040419180522.A14468@infradead.org> <20040419110553.47a588d1.rddunlap@osdl.org>
In-Reply-To: <20040419110553.47a588d1.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404192106.23306.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 of April 2004 20:05, Randy.Dunlap wrote:
> On Mon, 19 Apr 2004 18:05:22 +0100 Christoph Hellwig wrote:
> | On Mon, Apr 19, 2004 at 06:59:29PM +0200, Bartlomiej Zolnierkiewicz wrote:
> | > BTW at least PC9800 IDE support needs reworking - it is one BIG hack
> |
> | Please just kill it then.  PC9800 wasn't completly merged ever and there
> | haven't been atempts for ages.  No need to stall development because of
> | it.
>
> Is some development stalled because of it?

Well, for IDE there are bigger problems than PC9800... ;-)

> The current (status quo) isn't good.
> It either needs to be fixed or removed.

Yep, there is no doubt that it slow downs development,
i.e. recent i386 standard resources fixups/cleanups.

Bartlomiej

