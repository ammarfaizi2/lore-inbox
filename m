Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273577AbRIQMDZ>; Mon, 17 Sep 2001 08:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273579AbRIQMDQ>; Mon, 17 Sep 2001 08:03:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23564 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273577AbRIQMDG>; Mon, 17 Sep 2001 08:03:06 -0400
Subject: Re: 2.4.9 deadlock
To: michael.dreher@gmx.net (Michael Dreher)
Date: Mon, 17 Sep 2001 13:08:05 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20010917104847.A8CABFC91@abel.math.tsukuba.ac.jp> from "Michael Dreher" at Sep 17, 2001 07:49:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ixC2-0006xx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> yesterday my box locked up. It happened when I opened a link in a new
> window of konqueror of kde2.2.
> No ping, no sysrq, no keyboard LEDs. Obviously nothing in the logs.
> I had to press reset.

A very long link and with XFree 4.1.0 ? If so its a known XFree86 problem.
It should be fixed in an upcoming xfree release
