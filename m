Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbWD1MRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbWD1MRX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 08:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbWD1MRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 08:17:23 -0400
Received: from userg502.nifty.com ([202.248.238.82]:40374 "EHLO
	userg502.nifty.com") by vger.kernel.org with ESMTP id S1030372AbWD1MRW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 08:17:22 -0400
Message-ID: <44520581.3090404@jp.fujitsu.com>
Date: Fri, 28 Apr 2006 21:07:29 +0900
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] Re: [PATCH 0/9] CPU controller
References: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp> <20060428165639.0e4f9a03.maeda.naoaki@jp.fujitsu.com> <1146216552.8067.11.camel@homer> <200604282011.36917.kernel@kolivas.org>
In-Reply-To: <200604282011.36917.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> I agree with Mike here. It's either global resource management or it isn't. If 
> one user is using all interactive tasks and the other user none it's unfair 
> resource management.

My intention was not to hurt interactive task's response, but it seems
that just ignoring interactive tasks is not good. I'll consider
regulating interactive tasks also.

Thanks,
MAEDA Naoaki




