Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVD0Owu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVD0Owu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 10:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVD0Owu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 10:52:50 -0400
Received: from main.gmane.org ([80.91.229.2]:56194 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261651AbVD0Owk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 10:52:40 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Happe <news_0403@flatline.ath.cx>
Subject: system reboot after reading /proc/acpi/battery/../state
Date: Wed, 27 Apr 2005 16:48:59 +0200
Message-ID: <slrnd6v9ir.b61.news_0403@localhost.localdomain>
Reply-To: Andreas Happe <news_0403@flatline.ath.cx>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: b144.demo.tuwien.ac.at
User-Agent: slrn/0.9.8.1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have a regression to report: my notebook (HP Compaq nx7000) reboots
after reading /proc/acpi/battery/C11F/state. It's pseudo -
reproduceable, occurs around every second access.

please contact me for further information (and what information would be
needed to fix this bug), I will try to compile older kernel versions to
find the corresponding acpi update  this annoying bug (but it happens
for at least one month by now).

//Andreas

