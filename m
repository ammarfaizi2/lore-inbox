Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268026AbUIJXR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268026AbUIJXR6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 19:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268014AbUIJXR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 19:17:58 -0400
Received: from web40004.mail.yahoo.com ([66.218.78.22]:57963 "HELO
	web40004.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268026AbUIJXR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 19:17:29 -0400
Message-ID: <20040910231728.62214.qmail@web40004.mail.yahoo.com>
Date: Fri, 10 Sep 2004 16:17:28 -0700 (PDT)
From: Song Wang <wsonguci@yahoo.com>
Subject: Routing Performance Comparison between 2.4 and 2.6 kernel
To: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm looking for the network packet routing
performance comparison between the latest 2.4
and 2.6 kernel.

I did some initial testing on my mips-based router.
2.6 kernel performed way below 2.4 kernel. It sucks.
Turning on preemption on 2.6 kernel even makes
routing performance worse.

Anybody did a comprehensive study on the routing
performance for 2.6 and 2.4 kernel?

Thanks.



		
_______________________________
Do you Yahoo!?
Shop for Back-to-School deals on Yahoo! Shopping.
http://shopping.yahoo.com/backtoschool
