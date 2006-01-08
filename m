Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161237AbWAHXWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161237AbWAHXWV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 18:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161243AbWAHXWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 18:22:21 -0500
Received: from mail.suse.de ([195.135.220.2]:8872 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161241AbWAHXWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 18:22:20 -0500
Message-Id: <200601090023.16956.agruen@suse.de>
User-Agent: quilt/0.42-12
Date: Mon, 9 Jan 2006 00:23:16 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: [patch 0/2] Tmpfs acls
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an update of the tmpfs acl patches against 2.6.15-git4. (The
first version of these patches was posted on 2 February 2005.) We'll
have our /dev tree on tmpfs in the future, and we need acls there to
manage device inode permissions of logged-in users. Other distributions
will be in exactly the same situation, and need this patchset as well.

Andrew, if this stuff looks good enough to you, could you please let it
live in -mm for some time?

Thanks,
Andreas

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX Products GmbH / Novell Inc.

