Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbVHVWbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbVHVWbB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbVHVWa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:30:59 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:17289 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751423AbVHVWZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:25:06 -0400
Date: Mon, 22 Aug 2005 09:59:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [2.6.13-rc6-rt9 patch] fix DECNET_ROUTER=y compile
Message-ID: <20050822075918.GF19386@elte.hu>
References: <20050818060126.GA13152@elte.hu> <20050818225423.GH3822@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050818225423.GH3822@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Adrian Bunk <bunk@stusta.de> wrote:

> It doesn't compile with CONFIG_DECNET_ROUTER=y:

thanks, applied.

	Ingo
