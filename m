Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbUCEXwi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 18:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbUCEXwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 18:52:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:26059 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261495AbUCEXwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 18:52:37 -0500
Subject: Re: problem with cache flush routine for G5?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040305151542.GL26065@smtp.west.cox.net>
References: <40479A50.9090605@nortelnetworks.com>
	 <1078444268.5698.27.camel@gaston>
	 <20040304235754.GK26065@smtp.west.cox.net>
	 <1078445065.5703.37.camel@gaston>
	 <20040305151542.GL26065@smtp.west.cox.net>
Content-Type: text/plain
Message-Id: <1078530692.5700.121.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Mar 2004 10:51:32 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I hate to disappoint Ben, but nothing is having any trouble with that
> code, even if it's not exactly right. :)

It's actually completely wrong. If things work, they do so by mere
luck.

> Regardless, I'll go and make all of the boot code code the same,
> working, cache flushing code.  Thanks for finding that, Chris.
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

