Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263802AbUGYWci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbUGYWci (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 18:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUGYWci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 18:32:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:8086 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263802AbUGYWch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 18:32:37 -0400
Date: Sun, 25 Jul 2004 15:31:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
Cc: willgs00@cox.net, linux-kernel@vger.kernel.org
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
Message-Id: <20040725153103.4bb2ad64.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0407260032240.4782-100000@silmu.st.jyu.fi>
References: <4104257C.3080102@cox.net>
	<Pine.LNX.4.44.0407260032240.4782-100000@silmu.st.jyu.fi>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pasi Sjoholm <ptsjohol@cc.jyu.fi> wrote:
>
> I just found this thread (url below) and some others are having problems 
>  also.
> 
>  http://seclists.org/lists/linux-kernel/2004/Mar/2295.html
> 
>  Andrew:
> 
>  Did you find any solution to this one?

Nope.  We still await the intersection of someone who can reproduce it with
someone who has the time/ability/inclination to diagnose it.

