Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTLTVnd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 16:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbTLTVnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 16:43:32 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:62338
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261595AbTLTVn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 16:43:26 -0500
Date: Sat, 20 Dec 2003 16:41:23 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nick Piggin <piggin@cyberone.com.au>
cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, hawkes@babylon.engr.sgi.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com
Subject: Re: [RFC][PATCH] 2.6.0-test11 sched_clock() broken for "drifty ITC"
In-Reply-To: <3FE466ED.5060701@cyberone.com.au>
Message-ID: <Pine.LNX.4.58.0312201634280.2100@montezuma.fsmlabs.com>
References: <200312182044.hBIKiCLY5477429@babylon.engr.sgi.com>
 <20031220105031.GA17848@elte.hu> <3FE46345.1040102@cyberone.com.au>
 <20031220070532.05b7b268.akpm@osdl.org> <3FE466ED.5060701@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Dec 2003, Nick Piggin wrote:

> Andrew Morton wrote:
>
> >miaow ;)

Andrew what are they feeding you these days? ;)

> I'm just thinking that computers with unsynched clocks have less
> need for good interactivity, but thats probably too narrow and x86
> a view anyway.

x86 and TSCs don't do that great a job either ;)
