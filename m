Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbSLBCfT>; Sun, 1 Dec 2002 21:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbSLBCfT>; Sun, 1 Dec 2002 21:35:19 -0500
Received: from air-2.osdl.org ([65.172.181.6]:54248 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263491AbSLBCfT>;
	Sun, 1 Dec 2002 21:35:19 -0500
Date: Sun, 1 Dec 2002 18:39:41 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Pavel Machek <pavel@ucw.cz>
cc: Rasmus Andersen <rasmus@jaquet.dk>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.2.23-rc2 & an MCE
In-Reply-To: <20021126220459.GA229@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33L2.0212011838160.25551-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| > I just had an MCE on my aging PPro 200. Before I go out to
| > buy a replacement I would like to hear if it could be
| > caused by anything other than the CPU. Googling a bit
| > gave some indications that sometimes other HW might report
| > failure through this method.
| >
| > The MCE (hand copied):
| >
| > Machine Check Exception: 000000000000004
| > Bank 4: b200000000040151
| > Kernel panic: CPU context corrupt

Rasmus,

If you haven't already done so, you should check out the
MCE decoder from Dave Jones at
  http://www.codemonkey.org.uk/cruft/parsemce.c/

-- 
~Randy

