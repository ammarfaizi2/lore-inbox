Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935059AbWKXUse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935059AbWKXUse (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 15:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935061AbWKXUsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 15:48:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43706 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S935058AbWKXUsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 15:48:31 -0500
Date: Fri, 24 Nov 2006 12:43:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Mel Gorman <mel@skynet.ie>, Andre Noll <maan@systemlinux.org>,
       discuss@x86-64.org, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Rientjes <rientjes@cs.washington.edu>
Subject: Re: [discuss] 2.6.19-rc6: known regressions (v4)
Message-Id: <20061124124339.9f04183c.akpm@osdl.org>
In-Reply-To: <200611241058.55824.ak@suse.de>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org>
	<20061123110930.abc4fd9a.akpm@osdl.org>
	<20061123215545.GA9551@skynet.ie>
	<200611241058.55824.ak@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2006 10:58:55 +0100
Andi Kleen <ak@suse.de> wrote:

> 
> > A slightly smarter, but not quite as obviously correct, 
> 
> I think it's better to go for the "obviously correct" approach right now
> And sorting multiple times should be fine
> 

yup, that's what I'd decided.
