Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262412AbVC3TqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbVC3TqW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 14:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbVC3TqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 14:46:21 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:39656 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S262412AbVC3Toz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 14:44:55 -0500
Date: Wed, 30 Mar 2005 20:44:42 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
In-Reply-To: <1112201194.3691.128.camel@localhost.localdomain>
Message-Id: <Pine.OSF.4.05.10503302042450.2022-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005, Steven Rostedt wrote:

> [...] 
> 
> Heck, I'll make it bloat city till I get it working, and then tone it
> down a little :-)  And maybe later we can have a better solution for the
> BKL.
> 
What about removing it alltogether?
Seriously, how much work would it be to simply remove it and go in and
make specific locks in all those places the code can't compile?

Esben

> -- Steve
> 
> 

