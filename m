Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263573AbUEGMq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbUEGMq0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 08:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbUEGMq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 08:46:26 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:15292 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S263573AbUEGMqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 08:46:25 -0400
From: Jan Killius <jkillius@arcor.de>
Reply-To: jkillius@arcor.de
To: linux-kernel@vger.kernel.org
Subject: Problem with rtc and cpufreq
Date: Fri, 7 May 2004 14:46:22 +0200
User-Agent: KMail/1.6.52
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405071446.22771.jkillius@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
There's a problem with the realtime clock and cpufreq. If cpufreq scale down 
my CPU frequency this message came from the kernel: 
rtc: lost some interrupts at 1024Hz

I'm using 2.6.6-rc3-mm2.
The cpu is a athlon64 3200+.
The CPU scales between 2000 Mhz and 800 Mhz.
-- 
        Jan
