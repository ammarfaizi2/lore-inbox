Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTLaJNg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 04:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbTLaJNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 04:13:35 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:58052 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S263587AbTLaJNd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 04:13:33 -0500
Date: Wed, 31 Dec 2003 22:09:21 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: SMP testers wanted for Software Suspend 2
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1072861760.21814.37.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

If you have SMP and are interested in testing out Software Suspend 2's
new support for SMP, I'd appreciate hearing from you. At the moment, it
is only implemented under 2.4 kernels, but the 2.6 version shouldn't be
far away. I'm particularly interested in hearing reports about boxes
with more than 2 cpus.

While I'm at it, I'll say thanks publicly to the guys at OSDL, who set
up a box for me to get this going on.

The patches can be obtained from swsusp.sf.net. You're after

software-suspend-2.0-linux-2.4.23-rev2-whole.bz2

and

software-suspend-2.0-core-rc3C-whole.bz2

Apply them in that order. (It doesn't actually matter for 2.4, but does
for 2.6 so it's good to get in the habit). FAQs and all other manner of
documentation may be found on swsusp.sf.net.

Regards,

Nigel
-- 
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

