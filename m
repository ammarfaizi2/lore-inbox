Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVCJCs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVCJCs1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 21:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVCJCrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 21:47:49 -0500
Received: from gate.crashing.org ([63.228.1.57]:8135 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261713AbVCJCqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 21:46:51 -0500
Subject: bk commits and dates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 13:41:59 +1100
Message-Id: <1110422519.32556.159.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While we are at such requests ...

When you pull from one of the trees, like netdev, the commit messages
are sent to the bk commit list with the original date stamp of the patch
in the netdev tree.

For example, if Jeff commited a patch from somebody in his netdev tree 3
weeks ago, and you pull Jeff's tree today, we'll get all the commit
messages today, but dated from 3 weeks ago.

That means that in my mailing list archive, where my mailer sorts them
by date, I can't say, for example, everything that is before the 2.6.11
tag release was in 2.6.11. It's also difficult to spot "new" stuffs as
they can arrive with dates weeks ago, and thus show up in places I will
not look for.

I don't know if I'm the only one to have a problem with that, but it
would be nice if it was possible, when you pull a bk tree, to have the
commit messages for the csets in that tree be dated from the day you
pulled, and not the day when they went in the source tree.

Ben.


