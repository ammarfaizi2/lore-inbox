Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265812AbUA1CwU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 21:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265814AbUA1CwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 21:52:20 -0500
Received: from dp.samba.org ([66.70.73.150]:14047 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265812AbUA1CwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 21:52:19 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: thockin@sun.com
To: torvalds@osdl.org,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: NGROUPS 2.6.2rc2 
In-reply-to: Your message of "Tue, 27 Jan 2004 14:53:11 -0800."
             <20040127225311.GA9155@sun.com> 
Date: Wed, 28 Jan 2004 12:12:43 +1100
Message-Id: <20040128025232.D2AD12C015@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040127225311.GA9155@sun.com> you write:
> (sorry if this dups, screwup in my aliases file)
> 
> Linus,

You should probably send to Andrew Morton, too (or instead).

For the record; it's overkill for what I need (hundreds, not thousands
of groups, and I don't really mind if accessing them is slow), but at
this point I'd just like *some* solution.

Thanks Tim!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
