Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265584AbRF1Htf>; Thu, 28 Jun 2001 03:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265586AbRF1HtZ>; Thu, 28 Jun 2001 03:49:25 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:11016 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S265584AbRF1HtP>; Thu, 28 Jun 2001 03:49:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Patrick Dreker <patrick@dreker.de>
Organization: Chaos Inc.
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Cosmetic JFFS patch.
Date: Thu, 28 Jun 2001 09:43:21 +0200
X-Mailer: KMail [version 1.2]
Cc: David Woodhouse <dwmw2@infradead.org>, <jffs-dev@axis.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0106271514260.7355-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0106271514260.7355-100000@penguin.transmeta.com>
MIME-Version: 1.0
Message-Id: <01062809432100.00590@wintermute>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello...

Am Donnerstag, 28. Juni 2001 00:16 schrieb Linus Torvalds:
> I don't _have_ any instances of my name being printed out to annoy the
> user, so that's a very theoretical argument.

Err.... Just nitpicking...

dreker@wintermute:~> dmesg | grep -C Linus
hub.c: 2 ports detected
uhci.c:  Linus Torvalds, Johannes Erdfelt, Randy Dunlap, Georg Acher, Deti 
Fliegl, Thomas Sailer, Roman Weissgaerber

dreker@wintermute:~> uname -a
Linux wintermute 2.4.5-ac15 #1 Son Jun 17 12:44:01 CEST 2001 i686 unknown

> This is my current patch in my tree. I refuse to have bickering in
> printk's. You can edit the comment all you want.
>
> 		Linus
>

-- 
Patrick Dreker
