Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTHYBTh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 21:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbTHYBTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 21:19:37 -0400
Received: from dp.samba.org ([66.70.73.150]:59030 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261292AbTHYBTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 21:19:35 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: peter@chubb.wattle.id.au, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] Fix loose->lose typos in 2.6.0-test2 
In-reply-to: Your message of "Fri, 15 Aug 2003 12:12:40 MST."
             <20030815121240.7ff9fed0.rddunlap@osdl.org> 
Date: Sat, 23 Aug 2003 04:29:04 +1000
Message-Id: <20030825011935.836452C221@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030815121240.7ff9fed0.rddunlap@osdl.org> you write:
> On Sat, 16 Aug 2003 03:12:52 +1000 Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> | After a brief conversation with Andrew, Trivial Patch Monkey is only
> | taking patches for documentation and where grep might be effected.
> | Feel free to push this directly though.
> 
> then it qualifies.
> Who would grep for 'loose' when it should be 'lose' and v.v.?

I was thinking of something like a variable name, (eg. foo_close was
misspellt as foo_klose) then someone might be greping for "close"
functions and miss it.

Or if the documentation for the foo card talked about the "Dunlap
Enable" feature, and it was misspellt "Donlap" in the code or
comments, it'd be nice to be fixed.

But the lose/loose one is a stretch, I think.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
