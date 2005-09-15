Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161144AbVIPJkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161144AbVIPJkb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 05:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161145AbVIPJkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 05:40:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41890 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1161144AbVIPJkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 05:40:31 -0400
Date: Thu, 15 Sep 2005 21:53:18 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc1 load average calculation broken?
Message-ID: <20050915195317.GE468@openzaurus.ucw.cz>
References: <43295E30.7030508@ppp0.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43295E30.7030508@ppp0.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Get a steady 2.00 there. I stopped unnecessary processes etc.
> load average seems to be invariant

So you probably have 2 processes in "D" state. Find a kernel bug which leaves
them there...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

