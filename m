Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275469AbTHJFnf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 01:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275471AbTHJFnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 01:43:35 -0400
Received: from dyn-ctb-210-9-243-231.webone.com.au ([210.9.243.231]:18182 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S275469AbTHJFnY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 01:43:24 -0400
Message-ID: <3F35DB73.8090201@cyberone.com.au>
Date: Sun, 10 Aug 2003 15:43:15 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy  ...
References: <Pine.LNX.4.55.0307131442470.15022@bigblue.dev.mcafeelabs.com> <5.2.1.1.2.20030809183021.0197ae00@pop.gmx.net> <200308100405.52858.roger.larsson@skelleftea.mail.telia.com>
In-Reply-To: <200308100405.52858.roger.larsson@skelleftea.mail.telia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Roger Larsson wrote:

>*	SCHED_FIFO requests from non root should also be treated as SCHED_SOFTRR
>
>

I hope computers don't one day become so fast that SCHED_SOFTRR is
required for skipless mp3 decoding, but if they do, then I think
SCHED_SOFTRR should drop its weird polymorphing semantics ;)


