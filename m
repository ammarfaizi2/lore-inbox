Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbTK1BPY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 20:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbTK1BPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 20:15:23 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:642 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261784AbTK1BPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 20:15:19 -0500
Date: Fri, 28 Nov 2003 01:15:14 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Joseph D. Wagner" <theman@josephdwagner.info>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/locks.c fcntl_setlease did not check if a file was opened for writing before granting a read lease
Message-ID: <20031128011514.GA21015@mail.shareable.org>
References: <000301c3b504$689afbf0$0201a8c0@joe> <16326.14408.365320.326423@laputa.namesys.com> <20031127180329.GC19669@mail.shareable.org> <200311271449.51696.theman@josephdwagner.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311271449.51696.theman@josephdwagner.info>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph D. Wagner wrote:
> Well, dang it all.  Why didn't they guy who implemented leasing in the first 
> place bother to do it right the first time?
>
> I don't have the time or technical expertise in kernel development to go 
> through all that.  Somebody else is going to have to pick up his slack.

This isn't a commercial project with teams picking up "slack".  It's
mostly volunteers, using their private time as they see fit.  Progress
is made in pieces, nobody is obliged to "finish" anything, and people
contribute incomplete features so that someone else with time, energy
and inclination might complete them.

Being rude is inappropriate.  Words like "didn't bother" and "slack"
are offensive in this context, much like calling someone who works 100
hours a week "a lazy programmer" because they'd need 200 hours to do
what you think they should have done is offensive.

-- Jamie
