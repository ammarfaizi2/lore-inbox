Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161530AbWI2IkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161530AbWI2IkM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 04:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161520AbWI2IkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 04:40:11 -0400
Received: from rtr.ca ([64.26.128.89]:30476 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1161530AbWI2IkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 04:40:10 -0400
Message-ID: <451CDBE3.2080707@rtr.ca>
Date: Fri, 29 Sep 2006 04:40:03 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Arrr! Linux 2.6.18
References: <Pine.LNX.4.64.0609192126070.4388@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609192126070.4388@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> ..
> Cap'n Andrew Morton:
>       Blimey! hvc_console suspend fix

Mmm.. I wonder if this could be what killed resume-from-RAM
on my notebook, between -rc6 and -final ?

Andrew, can you send me just that one patch, and I'll try reverting it.

Thanks.

Mark
