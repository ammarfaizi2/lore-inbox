Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752684AbVHGUXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbVHGUXu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 16:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752687AbVHGUXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 16:23:50 -0400
Received: from modeemi.modeemi.cs.tut.fi ([130.230.72.134]:55235 "EHLO
	modeemi.modeemi.cs.tut.fi") by vger.kernel.org with ESMTP
	id S1752684AbVHGUXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 16:23:50 -0400
Date: Sun, 7 Aug 2005 23:23:47 +0300
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.13-rc6: aic7xxx testers please..
Message-ID: <20050807202347.GP27323@jolt.modeemi.cs.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
From: shd@modeemi.cs.tut.fi (Heikki Orsila)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> In general, anybody who has reported regressions since 2.6.12, please 
> re-test with -rc6 and report back
> ...
> Herbert Xu:
> tcp: fix TSO cwnd caching bug

The tcp_output panic bug seems to be fixed. I'm referring to:

	http://lkml.org/lkml/2005/8/7/63

-- 
Heikki Orsila			Barbie's law:
heikki.orsila@iki.fi		"Math is hard, let's go shopping!"
http://www.iki.fi/shd
