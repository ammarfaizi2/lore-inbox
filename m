Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbWEEAch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbWEEAch (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 20:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbWEEAch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 20:32:37 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:32640 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1030292AbWEEAcg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 20:32:36 -0400
Date: Thu, 4 May 2006 17:35:26 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.16.14
Message-ID: <20060505003526.GW24291@moss.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.14
kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.16.13 and 2.6.16.14, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,
-chris

--------

 Makefile       |    2 +-
 fs/smbfs/dir.c |    5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

Summary of changes from v2.6.16.13 to v2.6.16.14
================================================

Chris Wright:
      Linux 2.6.16.14

Olaf Kirch:
      smbfs chroot issue (CVE-2006-1864)

