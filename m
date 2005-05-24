Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVEXP4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVEXP4K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVEXPzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:55:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:37115 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262116AbVEXPpC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:45:02 -0400
Subject: Re: RT patch acceptance
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050524081517.GA22205@elte.hu>
References: <1116890066.13086.61.camel@dhcp153.mvista.com>
	 <20050524054722.GA6160@infradead.org> <20050524064522.GA9385@elte.hu>
	 <4292DFC3.3060108@yahoo.com.au>  <20050524081517.GA22205@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 24 May 2005 08:44:58 -0700
Message-Id: <1116949498.28841.19.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-24 at 10:15 +0200, Ingo Molnar wrote:

> so it's well worth the effort, but there's no hurry and all the changes 
> are incremental anyway. I can understand Daniel's desire for more action 
> (he's got a product to worry about), but upstream isnt ready for this 
> yet.

Ouch.. Let me disclaim my email , I'm writing for me and no one else.
I'm just a sponsored kernel hacker... Are you worried about RedHat
products?

The main reason for my email is that I know Andrew and Linus don't want
interrupts in threads. Without that there is no PREEMPT_RT . If you want
to narrow the discussion to just interrupts in threads that's fine with
me, cause that's what I'm concerned about.

There has been some version of interrupts in threads running around for
almost a year now. To me that's mature enough to be "unstable".

Daniel

