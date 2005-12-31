Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbVLaXN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbVLaXN6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 18:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVLaXN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 18:13:58 -0500
Received: from hermes.domdv.de ([193.102.202.1]:40720 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S1750741AbVLaXN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 18:13:58 -0500
Message-ID: <43B710B4.9000401@domdv.de>
Date: Sun, 01 Jan 2006 00:13:56 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051004)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.15rc6: ide oops+panic
References: <43AB20DA.2020506@domdv.de> <20051223053621.6c437cee.akpm@osdl.org>
In-Reply-To: <20051223053621.6c437cee.akpm@osdl.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

Ping

<rude>
Do you want me to track this further or shall I place my hardware in the
waste paper bin (Welcome to the pleasure dome of the new development
method)?
</rude>

Some more hint: It seems the system is stable as long as networking
(tg3) is not touched. I'll switch to e1000 for a while and see what
happens. Activating only one processor (booting with maxcpus=1) or
mounting with "barrier=0" doesn't help.

PS:
I'm dearly in need of a four way system based on the followup revision
of my board and two dual core Opterons which is delayed until this
Bug/Ooops/Panic is resolved. Can't develop anymore (due to CPU power
constraints and financial limits). Bad.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
