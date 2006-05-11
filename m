Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWEKCXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWEKCXF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 22:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbWEKCXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 22:23:05 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:50051 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1750869AbWEKCXE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 22:23:04 -0400
Date: Wed, 10 May 2006 19:25:47 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.16.16
Message-ID: <20060511022547.GE25010@moss.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.16
kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.16.15 and 2.6.16.16, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,
-chris

--------

 Makefile   |    2 +-
 fs/locks.c |   21 ++++++++++++---------
 2 files changed, 13 insertions(+), 10 deletions(-)

Summary of changes from v2.6.16.15 to v2.6.16.16
================================================

Chris Wright:
      Linux 2.6.16.16

Trond Myklebust:
      fs/locks.c: Fix lease_init (CVE-2006-1860)

