Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265851AbSKBBRZ>; Fri, 1 Nov 2002 20:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265853AbSKBBRZ>; Fri, 1 Nov 2002 20:17:25 -0500
Received: from quechua.inka.de ([193.197.184.2]:56220 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S265851AbSKBBRY>;
	Fri, 1 Nov 2002 20:17:24 -0500
From: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [announce] swap mini-howto
In-Reply-To: <Pine.LNX.4.33L2.0211011540140.28320-100000@dragon.pdx.osdl.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E187n11-0004ET-00@sites.inka.de>
Date: Sat, 2 Nov 2002 02:23:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33L2.0211011540140.28320-100000@dragon.pdx.osdl.net> you wrote:
> I'm sure that it has some things that need to be corrected,

You say that linux needs swap=ram and old linux needs swap=2xram which is
not true. There is no "need" for swap size (like in BSD where you need to
have at least as much swap as you have ram).

If your system is doing a lot of memory intense work you may need swap space
up to dozents of gigabyte :)

Normally it is enough to have 1-2 times of your ram, if you have a normal
128-1gb system.

Swap usage can be monitored with the "free" command.

> Anyone have suggestions for where this should/could live,
> like tldp.org or kernelnewbies.org etc.?
> (other than where it is :)

i would suggest you send it to the LDP (tldp.org) cause they will be
mirrored everywhere.


Greetings
Bernd
