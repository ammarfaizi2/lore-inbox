Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbUB1S0T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 13:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbUB1S0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 13:26:19 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:8900 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261897AbUB1S0N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 13:26:13 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Kyle" <kyle@southa.com>
Subject: Re: Is "ACARD" AEC-6885S 4-CH ATA133 supported?
Date: Sat, 28 Feb 2004 19:33:21 +0100
User-Agent: KMail/1.5.3
References: <02dd01c3fe1f$095df660$353ffea9@kyle>
In-Reply-To: <02dd01c3fe1f$095df660$353ffea9@kyle>
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="big5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402281933.21959.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 of February 2004 18:19, Kyle wrote:
> Hi!
>
> Is this product work with kernel 2.6.x?
> http://www.acard.com/eng/product/adapter/pc/ide/aec-6885s.html

No.

> It mentioned that it's compatible with Linux RedHat 7.3 & 8.0 & 9.0, but I

They provide binary only / 2.4 only drivers.

> seached through the whole mail list with keyword "ATP-867" and "AEC6885"
> with no luck. Anyone tried this?

I wasn't aware that there is a new ATP chip (867), interesting...

Bartlomiej

