Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274824AbTHKVJa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 17:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272796AbTHKVJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 17:09:30 -0400
Received: from main.gmane.org ([80.91.224.249]:5025 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S274859AbTHKVJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 17:09:28 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jens Benecke <usenet@jensbenecke.de>
Subject: Re: Linux 2.4.22-rc2
Date: Mon, 11 Aug 2003 22:57:21 +0200
Message-ID: <bh8vv8$3qc$1@sea.gmane.org>
References: <Pine.LNX.4.44.0308081751390.10734-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1474120.dtPh4Wnd94"
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.6
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1474120.dtPh4Wnd94
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit

Marcelo Tosatti wrote:

> Here goes release candidate 2.
> It contains yet another bunch of important fixes, detailed below.
> Nice weekend for all of you!

I'm having problems.  had them with -pre10 as well, posted here, but th=
ey
somehow didn't appear in the list.

Here's the short story: No network (3c509) because the card gets IRQ 22=
 (or
something) and doesn't like it, no USB, no firewire, no X11 (yeah, shou=
ld
have recompiled the NVIDIA drivers, duh), and a total crash on shutdown=
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--nextPart1474120.dtPh4Wnd94--
