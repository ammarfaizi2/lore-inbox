Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVDZRbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVDZRbD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 13:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVDZRa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 13:30:59 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:30159 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261695AbVDZR2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 13:28:37 -0400
Subject: Re: [PATCH][RFC] Linux VM hooks for advanced RDMA NICs
From: Lee Revell <rlrevell@joe-job.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: David Addison <addy@quadrics.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       David Addison <david.addison@quadrics.com>
In-Reply-To: <Pine.LNX.4.62.0504261918210.2071@dragon.hyggekrogen.localhost>
References: <426E62ED.5090803@quadrics.com>
	 <Pine.LNX.4.62.0504261829110.2071@dragon.hyggekrogen.localhost>
	 <1114535584.5410.2.camel@mindpipe>
	 <Pine.LNX.4.62.0504261918210.2071@dragon.hyggekrogen.localhost>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 13:28:31 -0400
Message-Id: <1114536511.5410.14.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-26 at 19:20 +0200, Jesper Juhl wrote:
> I don't know what you do, but when I'm grep'ing the tree for some function 
> I'm often looking for its return type, having that on the same line as the 
> function name lets me grep for the function name and the grep output will 
> contain the return type and function name nicely on the same line.
> 

I do a lot of looking at large hunks of code I'm not familiar with and
trying to figure out how it works.  It's quite handy to grep for
foo_func to see all usages, then ^foo_func to see the function.  I guess
my preferred style favors people trying to grok code for the first time,
while the kernel style favors those who know it inside out.

Anyway, the coding style guidelines also state clearly that these points
are not up for debate on LKML so I'll stop now...

Lee

