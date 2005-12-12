Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbVLLKzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbVLLKzu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 05:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVLLKzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 05:55:50 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:29595
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751217AbVLLKzt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 05:55:49 -0500
Subject: [ANNOUNCE] 2.6.15-rc5-hrt2 - hrtimers based high resolution patches
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: LKML <linux-kernel@vger.kernel.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>
Content-Type: text/plain
Organization: linutronix
Date: Mon, 12 Dec 2005 12:02:23 +0100
Message-Id: <1134385343.4205.72.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The rebased version of the high resolution patches on top of the
hrtimers base patch is available from the new project home:

http://www.tglx.de/projetcs/hrtimers

The current patch is available here:

http://www.tglx.de/projects/hrtimers/2.6.15-rc5/patch-2.6.15-rc5-hrt2.patch

along with the broken out series

http://www.tglx.de/projects/hrtimers/2.6.15-rc5/patch-2.6.15-rc5-hrt2.patches.tar.bz2


Changes since the last 2.6.15-rc2-kthrt8 patch:

- rebased to hrtimers
- newest Generic Timeofday patch from John Stultz
- cleanups, bugfixes and improvements all over the place

Thanks to 
- Roman Zippel for his help with ktime_t (see ktime.h), discussion and
suggestions.
- John Stultz for his timeofday work
- all others who provided testing, help and suggestions 

	tglx


