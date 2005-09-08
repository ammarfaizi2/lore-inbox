Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbVIHT0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbVIHT0F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 15:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbVIHT0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 15:26:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62344 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964946AbVIHT0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 15:26:04 -0400
Date: Thu, 8 Sep 2005 12:25:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Reminder: 2.6.14 merge window closing
Message-ID: <Pine.LNX.4.58.0509081218570.3039@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As per the new merge policies that were discussed during LKS in Ottawa 
earlier during the summer, I'm going to accept new stuff for 2.6.14 only 
during the first two weeks after 2.6.13 was released.

That release was ten days ago, so you've got four more days before I don't 
want any big merges.

After that, I'll do a -rc1, and then we're supposed to just do fixes and
thus only work on any regressions and other immediate issues.

I've been merging a lot lately (happily, I got some work done during the
trip last week), so we certainly already have enough for 2.6.14. But I
just wanted to remind people that if they expected me to merge your work,
you're getting closer to the cut-off point..

(Of course, if you already sent me a pointer, and I haven't merged it yet, 
it might be because I missed something during travels, so please do 
re-send in that case)

			Linus
