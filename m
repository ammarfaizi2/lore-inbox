Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751683AbWAIF0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbWAIF0g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 00:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752765AbWAIF0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 00:26:36 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:38605 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751683AbWAIF0g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 00:26:36 -0500
Date: Sun, 8 Jan 2006 21:27:03 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/5] rcu: uninline __rcu_pending()
Message-ID: <20060109052703.GA12917@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43C165B4.2FF3B78@tv-sign.ru> <Pine.LNX.4.64.0601082017220.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601082017220.3169@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 08:17:51PM -0800, Linus Torvalds wrote:
> 
> Paul, 
>  RCU patches always make me worry, so can you please Ack or Nack this 
> series?

Me too, especially mine!

I will look this over carefully and either Ack or Nack with diagnostics.

						Thanx, Paul
