Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWI3RYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWI3RYc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 13:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWI3RYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 13:24:31 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:33173 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751269AbWI3RYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 13:24:31 -0400
Date: Sat, 30 Sep 2006 19:15:18 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Jim Gettys <jg@laptop.org>,
       John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 02/23] GTOD: persistent clock support, core
In-Reply-To: <20060930013558.679bf961.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0609301913580.4615@yvahk01.tjqt.qr>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
 <20060929234439.041924000@cruncher.tec.linutronix.de> <20060930013558.679bf961.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> persistent clock support: do proper timekeeping across suspend/resume.
>
>How?

Rereading the RTC seems the only way to me. Someone prove me wrong, and 
do it fast! :)


Jan Engelhardt
-- 
