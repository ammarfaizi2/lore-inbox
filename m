Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbVHLMx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbVHLMx5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 08:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVHLMx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 08:53:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61846 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751161AbVHLMx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 08:53:56 -0400
Date: Fri, 12 Aug 2005 08:53:49 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Guillaume Foliard <guifo@wanadoo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.53-01, High
 Resolution Timers & RCU-tasklist features
In-Reply-To: <200508112039.07660.guifo@wanadoo.fr>
Message-ID: <Pine.LNX.4.58.0508120426070.3233@devserv.devel.redhat.com>
References: <200508112039.07660.guifo@wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 11 Aug 2005, Guillaume Foliard wrote:

> Hi,
> 
> Here is the compilation error I had with 0.7.53-02 :

thanks - i've uploaded the -53-05 patch which should fix this - does it
build/work for you now?

	Ingo
