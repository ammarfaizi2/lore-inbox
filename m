Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267015AbSLPSu4>; Mon, 16 Dec 2002 13:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267013AbSLPSur>; Mon, 16 Dec 2002 13:50:47 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:7125 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266993AbSLPSuR> convert rfc822-to-8bit; Mon, 16 Dec 2002 13:50:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: Where is this printk?
Date: Mon, 16 Dec 2002 19:57:54 +0100
User-Agent: KMail/1.4.3
Cc: "Randy.Dunlap" <rddunlap@osdl.org>
References: <Pine.LNX.4.33L2.0212161049090.5099-100000@dragon.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.33L2.0212161049090.5099-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212161957.54808.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 December 2002 19:49, Randy.Dunlap wrote:

Hi Randy,

> Nope, it's in linux/init/main.c, line 357 in 2.4.20:
> 	printk(linux_banner);
> and linux_banner is in linux/init/version.c.
perfect! Thnx :)

ciao, Marc
