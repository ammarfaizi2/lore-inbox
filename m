Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264256AbUHDLWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUHDLWI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 07:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUHDLWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 07:22:08 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.20.8]:51902 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264256AbUHDLWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 07:22:06 -0400
Date: Wed, 4 Aug 2004 13:22:01 +0200
From: Rudo Thomas <rudo@matfyz.cz>
To: Ingo Molnar <mingo@redhat.com>
Cc: Shane Shrybman <shrybman@aei.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O2
Message-ID: <20040804112201.GA7842@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Ingo Molnar <mingo@redhat.com>,
	Shane Shrybman <shrybman@aei.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1091459297.2573.10.camel@mars> <Pine.LNX.4.58.0408031019090.20420@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408031019090.20420@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> thx - i fixed this in -O3.

Hi, Ingo.

I just wanted to report that O3 (+preempt-timing-O2) locks up hard at random
occasions, even with voluntary-preempt=2 preempt=1 set at boot time.
I never changed any of /proc/irq/*/threaded.

I will provide any information needed to hunt this down.

Rudo.
