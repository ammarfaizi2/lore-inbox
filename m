Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271832AbTHHUGu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 16:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271831AbTHHUGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 16:06:47 -0400
Received: from h234n2fls24o900.bredband.comhem.se ([217.208.132.234]:45036
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S271827AbTHHUGG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 16:06:06 -0400
Date: Fri, 8 Aug 2003 22:08:21 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]O14int
Message-Id: <20030808220821.61cb7174.lista1@telia.com>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003-08-08 15:49:25 Con Kolivas wrote:

> More duck tape interactivity tweaks

Do you have a premonition... Game-test goes down in flames. Volatile to
the extent where I can't catch head or tail. It can behave like in
A3-O12.2 or as an unpatched 2.6.0-test2. Trigger badness by switching to
a text console. Sometimes it recovers, sometimes not. Sometimes fast,
sometimes slowly (when it does recover).

I'll withdraw under my rock now. Won't come forth until everything
smells of roses. Getting stressed by being a bringer of bad news only.
Please speak up, all you other testers. Divide the burden. Even out the
scores.

Greetings,
Mats Johannesson
