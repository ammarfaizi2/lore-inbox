Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbVAJRiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVAJRiY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVAJRhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:37:05 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:3736 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S262367AbVAJRWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:22:04 -0500
Date: Mon, 10 Jan 2005 12:21:48 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Peter Daum <gator@cs.tu-berlin.de>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: 3ware driver (3w-xxxx) in 2.6.10: procfs entry
In-Reply-To: <Pine.LNX.4.30.0501101452590.14606-100000@swamp.bayern.net>
Message-ID: <Pine.GSO.4.33.0501101212500.6604-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2005, Peter Daum wrote:
>On Mon, 10 Jan 2005, Christoph Hellwig wrote:
>> The change came from the driver maintainer at 3ware.  Get the updated
>> tools from their website.
>
>Which website do you mean? The programs in the download section of
>"www.3ware.com" are just the ones that don't work anymore.

Yeap.  The "idiot" removed the proc interface from the driver before
publishing the updated tools  -- and I said so at the time.  At the time
the interface was removed, the new tools weren't available - period.  They
are still "beta" today (several months later.)

Just put the procfs code back in the driver in your local tree and
walk away.  That's what I did -- but it doesn't look like I commited
it to any BK tree :-( (and that box is *ahem* powered off)

--Ricky


