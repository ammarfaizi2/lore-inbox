Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVC0SR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVC0SR2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 13:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVC0SR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 13:17:27 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:61320 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261313AbVC0SRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 13:17:22 -0500
Date: Sun, 27 Mar 2005 20:17:15 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dave Jones <davej@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] no need to check for NULL before calling kfree() -fs/ext2/
In-Reply-To: <20050327174026.GA708@redhat.com>
Message-ID: <Pine.LNX.4.61.0503272015480.29017@yvahk01.tjqt.qr>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
 <Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
 <1111825958.6293.28.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
 <Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>
 <1111881955.957.11.camel@mindpipe> <Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost>
 <20050327065655.6474d5d6.pj@engr.sgi.com> <Pine.LNX.4.61.0503271708350.20909@yvahk01.tjqt.qr>
 <20050327174026.GA708@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Am I the only person who is completely fascinated by the
>effort being spent here micro-optimising something thats
>almost never in a path that needs optimising ?
>I'd be amazed if any of this masturbation showed the tiniest
>blip on a real workload, or even on a benchmark other than
>one crafted specifically to test kfree in a loop.
>[...]
Was not me who started it :P

>I guess April 1st came early this year.
DST change for Europe and Australia is a day ahead- hm, does not suffice to 
get onto April 1.


