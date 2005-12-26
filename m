Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbVLZBnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbVLZBnJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 20:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbVLZBnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 20:43:09 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:8870 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750755AbVLZBnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 20:43:08 -0500
Subject: CONFIG_USB_BANDWIDTH broken
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-usb-devel@lists.sourceforge.net
Content-Type: text/plain
Date: Sun, 25 Dec 2005 20:48:00 -0500
Message-Id: <1135561680.8293.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_USB_BANDWIDTH breaks USB audio.  This has been a problem for at
least 6 months.

Typical bug report:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1642

(search bug tracker for CONFIG_USB_BANDWIDTH to see many more)

Is anyone working on fixing this?

Lee

