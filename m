Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbULMQZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbULMQZx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 11:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbULMQWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 11:22:41 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:25728 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261267AbULMQTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 11:19:24 -0500
Date: Mon, 13 Dec 2004 17:19:13 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Stefan Seyfried <seife@suse.de>
cc: Con Kolivas <kernel@kolivas.org>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: Re: dynamic-hz
In-Reply-To: <41BD483B.1000704@suse.de>
Message-ID: <Pine.LNX.4.61.0412131718300.28742@yvahk01.tjqt.qr>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz>
 <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org>
 <41BD483B.1000704@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Just being devils advocate here...
>> 
>> I had variable Hz in my tree for a while and found there was one 
>> solitary purpose to setting Hz to 100; to silence cheap capacitors.
>
>power savings? Having the cpu wake up 1000 times per second if the
>machine is idle cannot be better than only waking it up 100 times.

That's like saying waking up the CPU just to perform a HLT operation would be 
useless.


Jan Engelhardt
-- 
ENOSPC
