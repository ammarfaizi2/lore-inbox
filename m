Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWAIESM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWAIESM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 23:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWAIESM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 23:18:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51591 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751228AbWAIESM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 23:18:12 -0500
Date: Sun, 8 Jan 2006 20:17:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/5] rcu: uninline __rcu_pending()
In-Reply-To: <43C165B4.2FF3B78@tv-sign.ru>
Message-ID: <Pine.LNX.4.64.0601082017220.3169@g5.osdl.org>
References: <43C165B4.2FF3B78@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul, 
 RCU patches always make me worry, so can you please Ack or Nack this 
series?

		Linus

