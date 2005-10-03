Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbVJCGzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVJCGzJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 02:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbVJCGzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 02:55:09 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:53224
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932155AbVJCGzH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 02:55:07 -0400
Subject: 2.6.14-rc3-kt1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: LKML <linux-kernel@vger.kernel.org>
Cc: john stultz <johnstul@us.ibm.com>, Roman Zippel <zippel@linux-m68k.org>,
       Ingo Molnar <mingo@elte.hu>, George Anzinger <george@mvista.com>
Content-Type: text/plain
Organization: linutronix
Date: Mon, 03 Oct 2005 08:56:17 +0200
Message-Id: <1128322577.15115.841.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have released the 2.6.14-rc3-kt1 version of the ktimer subsystem
patch, which can be downloaded from:

http://www.tglx.de/projects/ktimers/


Changes since 2.6.14-rc2-kt5:

	- Fixup of KTIMER_REARM case
	- wrong variable assignement (George Anzinger)
	- whitespace and line length cleanup
	- removal of redundant BUG_ON() checks

tglx


