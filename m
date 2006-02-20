Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWBTBAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWBTBAa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 20:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWBTBAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 20:00:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59360 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751172AbWBTBA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 20:00:29 -0500
Date: Sun, 19 Feb 2006 16:58:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: linux-kernel@vger.kernel.org, dtor_core@ameritech.net
Subject: Re: [PATCH 00/11] RTC subsystem
Message-Id: <20060219165845.09eb4183.akpm@osdl.org>
In-Reply-To: <20060219232211.368740000@towertech.it>
References: <20060219232211.368740000@towertech.it>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Zummo <a.zummo@towertech.it> wrote:
>
> 
>  Hello,
> 
>   this is me again with this shining new
>  RTC subsystem :)
> 
>  quick changelog:
> 
>  - attribute groups
>  - mutexes
>  - fixed another bug in pcf8563 detection 
> 
>  Many thanks to all the people who contributed
>  with comments both privately and on this ml.
> 

This is nowhere near a sufficient explanation for such a patchset.

What does it all do, how does it do it and, importantly, _why_ does it do
it?

