Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318785AbSHGSk5>; Wed, 7 Aug 2002 14:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319119AbSHGSk4>; Wed, 7 Aug 2002 14:40:56 -0400
Received: from quechua.inka.de ([212.227.14.2]:35122 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S318785AbSHGSkz>;
	Wed, 7 Aug 2002 14:40:55 -0400
From: Bernd Eckenfels <ecki-news2002-08@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ethtool documentation
In-Reply-To: <Pine.LNX.3.95.1020807070841.28061A-100000@chaos.analogic.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E17cVnR-0002r3-00@sites.inka.de>
Date: Wed, 7 Aug 2002 20:44:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.3.95.1020807070841.28061A-100000@chaos.analogic.com> you wrote:
> That capability is not permanent. If you let users write to the
> SEEPROM, permanently changing the IEEE Station Address, you have
> let users permanently break their network boards. I do protest
> when this capability is in the kernel.

It does not break it permanently. You just need to write a sane address and
it will work again. 

Greetings
Bernd
y
