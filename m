Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbTLSLjy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 06:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbTLSLjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 06:39:53 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:4480
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262707AbTLSLjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 06:39:18 -0500
Date: Fri, 19 Dec 2003 06:38:30 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: =?iso-8859-1?q?ewan=20paton?= <ewan_paton@yahoo.co.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: Re: PROBLEM with intel gigabit ethernet driver bug
In-Reply-To: <20031219071539.18693.qmail@web25110.mail.ukl.yahoo.com>
Message-ID: <Pine.LNX.4.58.0312190634228.2147@montezuma.fsmlabs.com>
References: <20031219071539.18693.qmail@web25110.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Dec 2003, [iso-8859-1] ewan paton wrote:

> i hate to bother you but i feel certain there is a
> problem with the intel gigabit ehernet driver in the
> 2.6 kernel, i have an Intel Corp. 82544GC Gigabit
> Ethernet Controller and run gentoo this driver works
> fine with in 2.4 sources but i have tried multiple 2.6
> sources and it just fails to bring the ethernet up. it
> did used to work in older development releases but
> when they went into the 2.6test phase.
> i am sure it is present in kernels 2.6test6 to 2.6 but
> cant remember the last one it worked with sorry
>  if i can provide any config files etc i will gladly
> send them and if this is a problem on my end i am very
> sorry for wasting your time but i have spent over a
> month trying to find a fix

Try sending in your .config and a bit more information like perhaps dmesg.
I just tested 2.6.0 with 82543GC, there might be slightly different code
paths in a few places but lets see what else you can dig up.

Thanks
