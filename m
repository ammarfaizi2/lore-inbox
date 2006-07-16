Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946069AbWGPBT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946069AbWGPBT3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 21:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946072AbWGPBT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 21:19:29 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:44168
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1946069AbWGPBT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 21:19:27 -0400
Date: Sat, 15 Jul 2006 18:19:40 -0700 (PDT)
Message-Id: <20060715.181940.104030882.davem@davemloft.net>
To: davej@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, torvalds@osdl.org,
       akpm@osdl.org
Subject: Re: sch_htb compile fix.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060715074112.GA18210@redhat.com>
References: <20060715074112.GA18210@redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: Sat, 15 Jul 2006 03:41:12 -0400

> net/sched/sch_htb.c: In function 'htb_change_class':
> net/sched/sch_htb.c:1605: error: expected ';' before 'do_gettimeofday'
> 
> Signed-off-by: Dave Jones <davej@redhat.com>

Thanks for catching this Dave.
