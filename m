Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVA2WAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVA2WAt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 17:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVA2WAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 17:00:49 -0500
Received: from fsmlabs.com ([168.103.115.128]:16326 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261571AbVA2WAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 17:00:46 -0500
Date: Sat, 29 Jan 2005 15:01:07 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: John Levon <levon@movementarian.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] OProfile: Fix oops on undetected CPU type
In-Reply-To: <20050129213642.GB71581@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.61.0501291459410.3010@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0501281146150.22906@montezuma.fsmlabs.com>
 <20050129140423.GA71581@compsoc.man.ac.uk> <Pine.LNX.4.61.0501290941180.10009@montezuma.fsmlabs.com>
 <20050129213642.GB71581@compsoc.man.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2005, John Levon wrote:

> Looks like you're still on the broken bkcvs, which is missing this
> patch:
> 
> http://linus.bkbits.net:8080/linux-2.5/cset@1.1966.1.72?nav=index.html|ChangeSet@-2w
> 
> which AFAICS is the correct solution to the problem.

Hmm i was actually using BK and not BKCVS and had pulled after the 25th. 
Anyway thanks, that should do it then.

