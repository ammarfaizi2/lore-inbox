Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262586AbVCCWGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbVCCWGZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 17:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVCCWDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 17:03:35 -0500
Received: from fire.osdl.org ([65.172.181.4]:50609 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262586AbVCCV7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:59:38 -0500
Date: Thu, 3 Mar 2005 13:55:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: andrea@cpushare.com, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] seccomp: don't say it was more or less mandatory
Message-Id: <20050303135556.5fae2317.akpm@osdl.org>
In-Reply-To: <20050303145147.GX4608@stusta.de>
References: <20050223014233.6710fd73.akpm@osdl.org>
	<20050224215136.GK8651@stusta.de>
	<20050224224134.GE20715@opteron.random>
	<20050225211453.GC3311@stusta.de>
	<20050226013137.GO20715@opteron.random>
	<20050301003247.GY4021@stusta.de>
	<20050301004449.GV8880@opteron.random>
	<20050303145147.GX4608@stusta.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> My point is simply:
> 
>  The help text for an option you need only under very specific 
>  circumstances shouldn't sound as if this option was nearly was 
>  mandatory.

I think the sort of sell-your-cycles service which this patch enables is a
neat idea, and one which is worth supporting, especially as the kernel
patch is so tiny.  So we want as many machines as possible to support it. 
So people don't need a special kernel just to join in.

Others may disagree, although nobody has.

And the patch is tiny.
