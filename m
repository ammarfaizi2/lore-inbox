Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbVIZUtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVIZUtR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 16:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbVIZUtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 16:49:17 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:5290 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id S1750712AbVIZUtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 16:49:17 -0400
From: dth@cistron.nl (Danny ter Haar)
Subject: just a report: 2.6.14-rc2-git[35] (UP) not stable on usenet server  where 2.6.12 stays up for weeks
Date: Mon, 26 Sep 2005 20:49:15 +0000 (UTC)
Organization: Cistron
Message-ID: <dh9msb$ko0$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1127767755 21248 62.216.30.70 (26 Sep 2005 20:49:15 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just feedback for the true kernel gods:

I've announced it probably all to often.
But 2.6.1[34]* kernels aren't stable for me.
Where 2.6.12-mm1 stays up for >> 3 weeks the latest kernels barfs:


reboot   system boot  2.6.14-rc2-git5  Mon Sep 26 16:58          (05:44)
[crash]

reboot   system boot  2.6.14-rc2-git3  Sat Sep 24 05:14       (2+11:42)
[crash]

Danny
machine has serial port but no buffering so no error report :-(

