Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbTJXKML (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 06:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTJXKML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 06:12:11 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:49329 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S261719AbTJXKMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 06:12:09 -0400
To: linux-kernel@vger.kernel.org
From: Ruben Puettmann <ruben@puettmann.net>
Subject: Re: 2.6.0-test8 - APM suspend not working
In-Reply-To: <JV2s.4TS.9@gated-at.bofh.it>
References: <JUJf.4p4.29@gated-at.bofh.it> <JV2s.4TS.9@gated-at.bofh.it>
Date: Fri, 24 Oct 2003 12:11:14 +0200
Message-Id: <E1ACyuY-0005Rl-00@baloney.puettmann.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On my Gericom laptop I have exact the same probelm...
> Did you try it in the console without X started? Without X it is working on my
> laptop with the test8 kernel.

here on Thinpad R40 the same. I'm using agpgart and radeon static
compiled in the kernel (no framebuffer).

        Ruben

-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
