Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965269AbWJCGhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965269AbWJCGhK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 02:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965287AbWJCGhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 02:37:09 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:64189 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S965263AbWJCGhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 02:37:01 -0400
Date: Tue, 3 Oct 2006 14:25:54 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] sh64 updates
Message-ID: <20061003052554.GB7933@localhost.hsdv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh64-2.6.git

Which contains:

Paul Mundt:
      sh64: Update cayman defconfig.

Richard Curnow:
      sh64: Remove me from sh64 maintainers.

 MAINTAINERS                        |    4 
 arch/sh64/configs/cayman_defconfig |  456 +++++++++++++++++++++++++------------
 2 files changed, 316 insertions(+), 144 deletions(-)
