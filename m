Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWABVpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWABVpY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 16:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWABVpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 16:45:24 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:10688 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751073AbWABVpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 16:45:23 -0500
Date: Mon, 2 Jan 2006 22:45:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nedko Arnaudov <nedko@arnaudov.name>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch-2.6.15-rc7-rt2 (realtime-preempt) report
Message-ID: <20060102214516.GA12850@elte.hu>
References: <87ek3ug314.fsf@arnaudov.name> <87mzie2tzu.fsf@arnaudov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mzie2tzu.fsf@arnaudov.name>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nedko Arnaudov <nedko@arnaudov.name> wrote:

> Hi, just got rc7-rt2 tested. cdrecord test still freezes my machine 
> but this time I got screenshot(attached). Again I'm hiting this BUG 
> only when doing actual burn, not when I erase.
>
> With rt2 my machine does not freeze with pmidi 1.6 anymore. But I get 
> this, when running pmidi 1.6 or tse3play (both using rtc I think):

could you try -rt3?

	Ingo
