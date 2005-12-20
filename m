Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVLTO4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVLTO4E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 09:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbVLTO4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 09:56:04 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:4272 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750711AbVLTO4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 09:56:03 -0500
Message-ID: <43A82D37.DED29CB3@tv-sign.ru>
Date: Tue, 20 Dec 2005 19:11:35 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
       Daniel Walker <dwalker@mvista.com>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [PATCH rc5-rt2 0/3] plist: alternative implementation
References: <43A5A7B5.21A4CAAE@tv-sign.ru> <20051220143848.GA2053@elte.hu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> 
> thanks Oleg, your patches look good to me, and it's a worthwile cleanup
> to make plist.h ops behave more like normal list.h ops. The new ops
> should be documented, but otherwise it looks OK.
> 
> please try the -rt3 kernel, does it work any better?

I'll try to do some testing on my side and send comments update on Friday.

Oleg.
