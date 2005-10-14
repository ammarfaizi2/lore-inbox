Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbVJNWAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbVJNWAb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 18:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbVJNWAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 18:00:31 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:43754
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750931AbVJNWAa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 18:00:30 -0400
Subject: 2.6.14-rc4-kt1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: LKML <linux-kernel@vger.kernel.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Organization: linutronix
Date: Sat, 15 Oct 2005 00:02:34 +0200
Message-Id: <1129327354.1728.820.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have released the 2.6.14-rc4-kt1 version of the ktimer subsystem
patch, which can be downloaded from:

http://www.tglx.de/projects/ktimers/patch-2.6.14-rc4-kt1.patch

Changes since 2.6.14-rc3-kt1:

- CPU_HOTPLUG fix (Ingo Molnar)
- coding style and comment cleanups (Ingo Molnar)

	
	tglx


