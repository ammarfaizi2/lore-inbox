Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266497AbUAWAaG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 19:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUAWAaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 19:30:06 -0500
Received: from gate.crashing.org ([63.228.1.57]:2778 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266497AbUAWA3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 19:29:06 -0500
Subject: Re: 2.6.1 on ATI Rage 128 M3: some thin vertical lines show up
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Oberritter <obi@saftware.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1074805972.2081.85.camel@shiva.eth.saftware.de>
References: <401034E6.70703@t-online.de>
	 <1074805972.2081.85.camel@shiva.eth.saftware.de>
Content-Type: text/plain
Message-Id: <1074817648.967.164.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 23 Jan 2004 11:27:29 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Just to clarify, are you talking about vesafb? I ask, because the
> rage128 driver included in the kernel does not support flat panels.
> That's the reason why I started a new driver for my Dell C600, which I
> haven't ported to 2.6 yet (volunteers are welcome, see
> http://www.saftware.de/r128fb/r128fb-20030819.tar.bz2 ;-).

Interesting... I'll look at this as soon as I'm done with my current
work (in a couple of weeks hopefully). I definitely plan to do some
major work on aty128fb so...

Ben.


