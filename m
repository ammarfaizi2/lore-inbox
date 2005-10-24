Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbVJXGt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbVJXGt3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 02:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbVJXGt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 02:49:29 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:36781 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750996AbVJXGt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 02:49:28 -0400
Date: Sun, 23 Oct 2005 23:49:18 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: taka@valinux.co.jp, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       clameter@sgi.com, torvalds@osdl.org, linux-mm@kvack.org
Subject: Re: [PATCH] cpuset confine pdflush to its cpuset
Message-Id: <20051023234918.386364c0.pj@sgi.com>
In-Reply-To: <20051023234032.5e926336.akpm@osdl.org>
References: <20051024001913.7030.71597.sendpatchset@jackhammer.engr.sgi.com>
	<20051024.145258.98349934.taka@valinux.co.jp>
	<20051023233237.0982b54b.pj@sgi.com>
	<20051023234032.5e926336.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> Let's see a (serious) worload/testcase first, hey?

A reasonable request.


> >   ( Anyone know what the "pd" stands for in pdflush ?? )
> 
> "page dirty"?  It's what bdflush became ...

Ah - thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
