Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266810AbUAXAGR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 19:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266811AbUAXAGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 19:06:17 -0500
Received: from mail2-116.ewetel.de ([212.6.122.116]:694 "EHLO mail2.ewetel.de")
	by vger.kernel.org with ESMTP id S266810AbUAXAGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 19:06:15 -0500
Date: Sat, 24 Jan 2004 01:06:12 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make ide-cd handle non-2kB sector sizes
In-Reply-To: <200401240050.54792.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.44.0401240103590.934-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jan 2004, Bartlomiej Zolnierkiewicz wrote:

> Maybe you've tested them differently?
> You can start from your first patch then incrementally:
> apply some changes, check, repeat.

Looks like I have to. This is getting tiring after half a dozen
reboots already.

Since ide-scsi seems to work okay with the latest fixes in 
Linus' tree, maybe this whole MO support stuff should dropped
from ide-cd?

-- 
Ciao,
Pascal

