Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317833AbSGaHnU>; Wed, 31 Jul 2002 03:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317836AbSGaHnU>; Wed, 31 Jul 2002 03:43:20 -0400
Received: from [64.105.35.245] ([64.105.35.245]:2503 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id <S317833AbSGaHnT>;
	Wed, 31 Jul 2002 03:43:19 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 31 Jul 2002 00:46:25 -0700
Message-Id: <200207310746.AAA07831@adam.yggdrasil.com>
To: martin@dalecki.de
Subject: Re: cli/sti removal from linux-2.5.29/drivers/ide?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
>        I'd be intersted in knowing what one of those other problems
>is.  Otherwise, I don't understand why I can't eliminate the "lock
>group" stuff.

	Nevermind.  I see that the "lock group" code is used
to implement the "serialize" IDE option.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
