Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbTIYQ1H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 12:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbTIYQ1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 12:27:07 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:30412 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261413AbTIYQ1F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 12:27:05 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Erik Mouw <erik@harddisk-recovery.nl>
Subject: Re: 128G Limit in Reiserfs? Or the Kernel? Or something else?
Date: Thu, 25 Sep 2003 18:29:17 +0200
User-Agent: KMail/1.5
Cc: "Norris, Brent" <bnorris@Edmonson.k12.ky.us>,
       "'Lou Langholtz'" <ldl@aros.net>, linux-kernel@vger.kernel.org
References: <9A8F8D67DC8ED311BF3E0008C7B9A0ADBAA871@E151000N0> <200309251644.22539.bzolnier@elka.pw.edu.pl> <20030925152837.GF31199@bitwizard.nl>
In-Reply-To: <20030925152837.GF31199@bitwizard.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309251829.17720.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 of September 2003 17:28, Erik Mouw wrote:
> On Thu, Sep 25, 2003 at 04:44:22PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > IDE limit is 137GB, not 128GB.
>
> It's the same limit:
>
> erik@zurix:~ >bc -l
> bc 1.06
> Copyright 1991-1994, 1997, 1998, 2000 Free Software Foundation, Inc.
> This is free software with ABSOLUTELY NO WARRANTY.
> For details type warranty'.
> 128 * 1024 * 1024 * 1024 / 1000000000
> 137.43895347200000000000

No, it's not the same... 137GB == 128GiB ;-).

> Regards,
> Erik

