Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVGTLOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVGTLOk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 07:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVGTLOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 07:14:40 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:6537 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261154AbVGTLOj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 07:14:39 -0400
Subject: inotify - i dont get a inotify device
From: Kasper Sandberg <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 20 Jul 2005 13:14:38 +0200
Message-Id: <1121858078.17798.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello.. i have a small problem with inotify in kernel 2.6.13-rc3-git4 -
i do not get the inotify device, i know i build it in,
gzcat /proc/config.gz | grep -i inotify confirms it, and i have a very
new udev, where inotify is in the rules file, i tried udevstart but it
did not create me the inotify device..

anyone that can help? perhaps a fix is known?

-- 
Kasper Sandberg <lkml@metanurb.dk>

