Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWA3Fxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWA3Fxc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 00:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWA3Fxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 00:53:32 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:19089
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751249AbWA3Fxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 00:53:31 -0500
Date: Sun, 29 Jan 2006 21:52:44 -0800 (PST)
Message-Id: <20060129.215244.05901896.davem@davemloft.net>
To: paulmck@us.ibm.com
Cc: dada1@cosmosbay.com, dipankar@in.ibm.com, rlrevell@joe-job.com,
       mingo@elte.hu, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: RCU latency regression in 2.6.16-rc1
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060130051156.GK16585@us.ibm.com>
References: <20060130043604.GF16585@us.ibm.com>
	<43DD9C49.4000000@cosmosbay.com>
	<20060130051156.GK16585@us.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@us.ibm.com>
Date: Sun, 29 Jan 2006 21:11:56 -0800

> > If the size is expanded by a 2 factor (or a power of too), can your 
> > proposal works ?
> 
> Yep!!!
> 
> Add the following:

This all sounds very exciting and promising.  I'll try to find some
spare cycles tomorrow to cook something up.
