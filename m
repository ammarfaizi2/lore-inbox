Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030436AbWAGHsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436AbWAGHsG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 02:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbWAGHsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 02:48:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8629 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030436AbWAGHsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 02:48:04 -0500
Date: Fri, 6 Jan 2006 23:47:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 0/3] updated *at function patch
Message-Id: <20060106234738.2445520e.akpm@osdl.org>
In-Reply-To: <200601061904.k06J4T3r027891@devserv.devel.redhat.com>
References: <200601061904.k06J4T3r027891@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I renumbered the syscalls due to the queued-up sys_migrate_pages.

We don't have changelogs for these patches.  Apart from the usual
what-it-does and how-it-does it I'd really like to be reminded of the
"why".  Adding a bunch of stuff to the core kernel codepaths needs to have
a good reason and I've forgotten your rationale.

We'll need Signed-off_by:'s for all these patches.

In future, please avoid sending multiple patches under the same Subject:,
thanks.

