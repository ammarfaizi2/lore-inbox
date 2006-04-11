Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWDKQaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWDKQaj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 12:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWDKQaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 12:30:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:6813 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751206AbWDKQai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 12:30:38 -0400
Date: Tue, 11 Apr 2006 09:26:20 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.16.3
Message-ID: <20060411162620.GA10332@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.3 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.16.2 and 2.6.16.3, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                |    2 +-
 security/keys/key.c     |    4 ++++
 security/keys/keyring.c |    1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

Summary of changes from v2.6.16.2 to v2.6.16.3
==============================================

David Howells:
      Keys: Fix oops when adding key to non-keyring [CVE-2006-1522]

Greg Kroah-Hartman:
      Linux 2.6.16.3

