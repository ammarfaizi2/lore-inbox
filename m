Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTFCXgA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 19:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbTFCXgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 19:36:00 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:30896 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261868AbTFCXf7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 19:35:59 -0400
Date: Wed, 4 Jun 2003 01:49:02 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Arne Brutschy <abrutschy@xylon.de>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Re[2]: [PATCH] ide driver 2.4.21-rc6
In-Reply-To: <1821158975.20030603152224@xylon.de>
Message-ID: <Pine.SOL.4.30.0306040131330.26979-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It MUST work.

Clean your kernel source with 'make mrproper' (just in case) and compile
again with Special FastTrak Feature enabled (CONFIG_PDC202XX_FORCE=y).

If it really won't work contact me.
--
Bartlomiej

On Tue, 3 Jun 2003, Arne Brutschy wrote:

> Bartlomiej Zolnierkiewicz wrote:
> BZ> What about turning on "Special FastTrak Feature" instead...
> Didn't work for me, don't know why.
>
> Arne



