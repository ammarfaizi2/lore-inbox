Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWFSUFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWFSUFD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWFSUFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:05:03 -0400
Received: from mail.timesys.com ([65.117.135.102]:8589 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP id S964873AbWFSUFB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:05:01 -0400
Subject: [PATCHSET] Announce: High-res timers, tickless/dyntick and dynamic
	HZ -V4
From: Thomas Gleixner <tglx@timesys.com>
Reply-To: tglx@timesys.com
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Content-Type: text/plain
Date: Mon, 19 Jun 2006 22:06:20 +0200
Message-Id: <1150747581.29299.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An updated patchset is available from:

http://www.tglx.de/projects/hrtimers/2.6.17/patch-2.6.17-hrt-dyntick4.patch

http://www.tglx.de/projects/hrtimers/2.6.17/patch-2.6.17-hrt-dyntick4.patches.tar.bz2

Changes since -V1:

- Cleanups in clockevents along the review suggestions from Con
- Export fixes for the jiffies functions from Michal
- minor fixups e.g. APM breakage
- patch descriptions added

Thanks to all reviewers, bug reporters and patch authors.

	Thomas, Ingo



