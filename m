Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265340AbRF2A35>; Thu, 28 Jun 2001 20:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbRF2A3r>; Thu, 28 Jun 2001 20:29:47 -0400
Received: from thetis.deor.org ([207.106.86.210]:27400 "EHLO thetis.deor.org")
	by vger.kernel.org with ESMTP id <S265350AbRF2A3i>;
	Thu, 28 Jun 2001 20:29:38 -0400
Date: Thu, 28 Jun 2001 17:29:36 -0700
From: "A. Melon" <juicy@melontraffickers.com>
Comments: This message did not originate from the Sender address above.
	It was remailed automatically by anonymizing remailer software.
	Please report problems or inappropriate use to the
	remailer administrator at <abuse@melontraffickers.com>.
	Please read http://melontraffickers.com/remailer.html
	before contacting the administrator.
To: linux-kernel@vger.kernel.org
Subject: RE: Cosmetic JFFS patch.
Message-ID: <a1f8a20e896653666c09770f78da67e3@melontraffickers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds hath spoken:
> I don't _have_ any instances of my name being printed out to annoy the
> user, so that's a very theoretical argument.

There is, of course, only one way to be fair about this.

And that is to apply this patch to init/main.c:

518a519
>       printk("Linux is a registered trademark of Linus Torvalds.\n");

