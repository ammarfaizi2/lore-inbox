Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261958AbSJDPDL>; Fri, 4 Oct 2002 11:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261951AbSJDPCb>; Fri, 4 Oct 2002 11:02:31 -0400
Received: from mx2.elte.hu ([157.181.151.9]:34012 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261949AbSJDPCT>;
	Fri, 4 Oct 2002 11:02:19 -0400
Date: Fri, 4 Oct 2002 17:17:55 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: Re: O(1) Scheduler from Ingo vs. O(1) Scheduler from Robert
In-Reply-To: <200210041531.51913.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.44.0210041716330.3477-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Oct 2002, Marc-Christian Petersen wrote:

> say, can anyone explain me why $subject patches are so different? What
> exactly are the important differences, what patch should we use?

well as far as i can tell Robert has put other stuff into his patch, which
isnt really part of the O(1) scheduler. So i'd call it "the O(1) scheduler
plus stuff".

	Ingo

