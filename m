Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285110AbRL3WDf>; Sun, 30 Dec 2001 17:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285227AbRL3WDZ>; Sun, 30 Dec 2001 17:03:25 -0500
Received: from bs1.dnx.de ([213.252.143.130]:50655 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S285110AbRL3WDU>;
	Sun, 30 Dec 2001 17:03:20 -0500
Date: Sun, 30 Dec 2001 23:02:57 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: AMD SC410 boot problems with recent kernels
In-Reply-To: <a05d93$a37$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.33.0112302247150.3056-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Dec 2001, H. Peter Anvin wrote:
> #ifdef CONFIG_SC410 time?

What would be the best place to include this into the kernel config
scheme?  Make an option, e.g. 'AMD Elan SC410 support' in "Processor type
and features"?

I'll make an update for my SC410 patchlet on

  http://www.schwebel.de/software/dnp/index_en.html

during the next days, to add the fix for the serial port bug and the A20
problem.

Do these problems (A20, serial port, timer) only exist on AMD's SC410
chips or are they also present on the SC520s?

Robert
--
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+

