Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264180AbTCXMXz>; Mon, 24 Mar 2003 07:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264181AbTCXMXy>; Mon, 24 Mar 2003 07:23:54 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:2532 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S264180AbTCXMXx>;
	Mon, 24 Mar 2003 07:23:53 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: Deprecating .gz format on kernel.org
References: <20030320165007$503c@gated-at.bofh.it>
	<20030320180014$0e31@gated-at.bofh.it>
	<20030320182006$46bf@gated-at.bofh.it>
	<E18w51O-0000QK-00@neptune.local> <20030320195207.GA739@elf.ucw.cz>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 24 Mar 2003 00:30:44 +0100
In-Reply-To: <20030320195207.GA739@elf.ucw.cz>
Message-ID: <m3y9351x0b.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> I've seen 7(or so) on i386sx/25. Alan seen <1.

Hmm. My 33 MHz i386 with 64 KB cache had 6.8 IIRC. One hour was more than
enough for the kernel to compile I think.

25 MHz i386 with no cache but with pipelined RAM had less bogomips, but
don't remember how much less.

Anyway, I don't use .gz from kernel.org anymore.
-- 
Krzysztof Halasa
Network Administrator
