Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWCTMCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWCTMCb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 07:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWCTMCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 07:02:31 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9483 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932068AbWCTMCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 07:02:30 -0500
Date: Mon, 20 Mar 2006 13:02:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.16.x will be a long-living kernel series
Message-ID: <20060320120229.GB22317@stusta.de>
References: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As proposed some time ago [1], I'll continue the 2.6.16.x series after 
2.6.17 will be released.

A short FAQ is below.

cu
Adrian

[1] http://lkml.org/lkml/2005/12/3/55


Q:
What will be the rules for patch inclusion in the 2.6.16.x series?

A:
There will be more relaxed rules similar to the rules in kernel 2.4 
after the release of kernel 2.6.0 (e.g. driver updates will be allowed).


Q:
Why not start with the more relaxed rules before the release of 2.6.17?

A:
After 2.6.16.y following the usual stable rules, the kernel should be 
relatively stable and well-tested giving the best possible basis for a 
long-living series.


Q:
How long will this 2.6.16 series be maintained?

A:
That depends on how long people use it and contribute patches.


Q:
Stable API/ABI for external modules?

A:
No.

