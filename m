Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbTIJBor (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 21:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264504AbTIJBor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 21:44:47 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:20875 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264488AbTIJBoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 21:44:46 -0400
Message-ID: <3F5E8168.9010309@lycoris.com>
Date: Tue, 09 Sep 2003 18:42:00 -0700
From: Joseph Cheek <joseph@lycoris.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1: Desktop/LX Amethyst) Gecko/20030509
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, acpi-support@lists.sf.net
Subject: 2.4.22: UP+ACPI breaks 8139too [SMP or APM work fine]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

until recently i have been running a 2.4 SMP kernel on my UP boxes and 
getting along very well.  but i decided to test a UP kernel, and found 
that i couldn't access the network unless i replaced acpi support with 
apm.  my rtl8139 nic, using the 8139too driver, would give me NETDEV 
WATCHDOG: eth0 timed out over and over in the syslog.

can anyone help me?  i would love to get acpi working again, but i can't 
afford to lose the NIC.

thanks!

joe

-- 
Joseph Cheek, President and CTO, Lycoris
Lycoris Desktop/LX: Familiar.  Powerful.  Open.
joseph@lycoris.com, http://www.lycoris.com/
+1 425 413-9521 voice, +1 425 671-0504 fax


