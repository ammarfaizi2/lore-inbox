Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269134AbUIXUkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269134AbUIXUkQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 16:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269121AbUIXUkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 16:40:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22485 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S269134AbUIXUj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 16:39:58 -0400
Date: Fri, 24 Sep 2004 16:37:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kevin Fenzi <kevin-linux-kernel@scrye.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
Message-ID: <20040924143714.GA826@openzaurus.ucw.cz>
References: <20040924021956.98FB5A315A@voldemort.scrye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924021956.98FB5A315A@voldemort.scrye.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Was trying to swsusp my 2.6.9-rc2-mm1 laptop tonight. It churned for a
> while, but didn't hibernate. Here are the messages. 
> 
> ....................................................................................................
> .........................swsusp: Need to copy 34850 pages
> Sep 23 16:53:37 voldemort kernel: hibernate: page allocation failure. order:8, mode:0x120
> Sep 23 16:53:37 voldemort kernel:  
Out of memory... Try again with less loaded system.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

