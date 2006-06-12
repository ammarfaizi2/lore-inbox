Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWFLUAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWFLUAu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 16:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWFLUAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 16:00:49 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:47317
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932169AbWFLUAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 16:00:49 -0400
Date: Mon, 12 Jun 2006 13:00:58 -0700 (PDT)
Message-Id: <20060612.130058.78495098.davem@davemloft.net>
To: jeff@garzik.org
Cc: matti.aarnio@zmailer.org, rlrevell@joe-job.com, folkert@vanheusden.com,
       linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation (FAQ matter)
From: David Miller <davem@davemloft.net>
In-Reply-To: <448D7FB0.9070604@garzik.org>
References: <1150048497.14253.140.camel@mindpipe>
	<20060611.115430.112290058.davem@davemloft.net>
	<448D7FB0.9070604@garzik.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jeff@garzik.org>
Date: Mon, 12 Jun 2006 10:52:32 -0400

> Create two simple web pages, one that shows the last 24 hours' worth of 
> LKML posts, and another one that shows the last 24 hours' worth of spam. 
>   Allow any user on the Internet to report an LKML post as spam, or 
> alternately, highlight a false positive as not-spam.  (perhaps generate 
> one of those wavy-text verify-you-are-a-human graphics)
> 
> Then you, as admin, only have to click a button that accepts or rejects 
> the submission(s).  If you want to scan it yourself for false positives, 
> you just hit the same webpage as everybody else.
> 
> That feedback is then fed into the bayesian system, to train it using 
> well-known methods.

I like this idea a lot.
