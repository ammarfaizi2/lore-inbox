Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264367AbUFGJTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264367AbUFGJTs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 05:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264365AbUFGJTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 05:19:47 -0400
Received: from webbox24.server-home.net ([195.137.212.20]:11431 "EHLO
	webbox24.server-home.net") by vger.kernel.org with ESMTP
	id S264367AbUFGJTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 05:19:40 -0400
To: linux-kernel@vger.kernel.org
From: Walter Hofmann <linux-kernel-040607111815-5c1d@secretlab.mine.nu>
Subject: Re: Possible bug: ext3 misreporting filesystem usage
In-Reply-To: <22GWW-28x-43@gated-at.bofh.it>
References: <22GWW-28x-43@gated-at.bofh.it>
Date: Mon, 7 Jun 2004 11:19:35 +0200
Message-Id: <E1BXGI3-0003pA-00@gimli.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been getting a possible bug after running my system a few weeks. The
> ext3 partition's usage is being misreported. Right now, df -h says ive got
> no space left, but according to du /, I'm only using 17 gigs of my 40 gig
> drive. Restarting fixes the problem, so I'm thinking it might be some
> mis-handled variable in memory, not something on the disc itself? And, yes,
> I do know that du is right, not df, because I keep good track of my disc
> usage. This is pretty serious, it killed a 40+ hour process that i'll have
> to start over again from the beginning!

I have seen this too. See
 http://marc.theaimsgroup.com/?l=linux-kernel&m=108549779731780&w=2

No replies yet.

Walter
