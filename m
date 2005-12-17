Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbVLQK7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbVLQK7W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 05:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbVLQK7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 05:59:22 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:41096 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932440AbVLQK7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 05:59:21 -0500
Date: Sat, 17 Dec 2005 11:59:14 +0100
From: Sander <sander@humilis.net>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux@horizon.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051217105914.GA12080@favonius>
Reply-To: sander@humilis.net
References: <20051215135812.14578.qmail@science.horizon.com> <Pine.LNX.4.64.0512150752240.3292@g5.osdl.org> <20051215165255.GA5510@harddisk-recovery.com> <20051216121754.GC18210@harddisk-recovery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051216121754.GC18210@harddisk-recovery.com>
X-Uptime: 11:40:54 up 29 days, 22:22, 23 users,  load average: 13.47, 13.48, 13.49
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote (ao):
> On Thu, Dec 15, 2005 at 05:52:55PM +0100, Erik Mouw wrote:
> > Just FYI, according to Dijkstra[1] V means "verhoog" which is dutch for
> > "increase". P means "prolaag" which isn't a dutch word, just something
> > Dijkstra invented. I guess he did that because "decrease" is "verlaag"
> > in dutch and that would give you the confusing V() and V()
> > operations...
> 
> Last night I've been browsing a little more through Dijkstra's papers,
> and in a completely unrelated paper[1] about a now obsolete computer I
> found that "prolaag" is a neologism coming from "probeer te verlagen",
> which means "try and decrease".

"probeer te verlagen" translates to "try to decrease".

"try and decrease" would be "probeer en verlaag".

-- 
Humilis IT Services and Solutions
http://www.humilis.net
