Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265267AbUBPADS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 19:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265271AbUBPADS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 19:03:18 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:60837 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265267AbUBPADN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 19:03:13 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Nico Schottelius <nico-kernel@schottelius.org>
Subject: Re: harddisk or kernel problem?
Date: Mon, 16 Feb 2004 01:09:05 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <20040213075403.GC1881@schottelius.org> <200402131717.34917.bzolnier@elka.pw.edu.pl> <20040215233441.GJ1881@schottelius.org>
In-Reply-To: <20040215233441.GJ1881@schottelius.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402160109.05151.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 of February 2004 00:34, Nico Schottelius wrote:
> Bartlomiej Zolnierkiewicz [Fri, Feb 13, 2004 at 05:17:34PM +0100]:
> > [ ... ]
> > Check your disk with SMART tools: http://smartmontools.sf.net.
>
> Before I continue to report what I've found out:
>
> Thank you all for your good help!
>
> I'm really down as this is the second disk
> dyeing within two month (and the second 2.5" hd even, I begin to think
> notebooks don't like me :/).

:-(  sh*t happens

> I currently collect all data I get / find out to
>
> http://schotteli.us/~nico/hd-problem.02/
> (renamed it, as this does not look like a kernel problem and I don't
> want somebody believe this).
>
> Currently I don't really understand the output of smartctl and cannot
> say what causes the error. Perhaps someone can give me a hint on this?

The most important things are: READ DMA errors were logged,
SMART self tests (short and extended) completed with read failure.

For me this is 100% disk problem (not cable etc.).

