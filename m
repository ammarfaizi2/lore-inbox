Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbTEEEf3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 00:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbTEEEe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 00:34:27 -0400
Received: from dp.samba.org ([66.70.73.150]:39121 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261917AbTEEEeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 00:34:23 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dave Maietta <dave@qix.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL][PATCH 2.4] Help dummies configure QoS 
In-reply-to: Your message of "04 May 2003 19:53:18 -0400."
             <1052092397.5844.33.camel@hell> 
Date: Mon, 05 May 2003 14:45:14 +1000
Message-Id: <20030505044653.DC9952C267@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1052092397.5844.33.camel@hell> you write:
> In the packet schedulers section of the config scripts, neither the
> Ingress Qdisc nor any comment about its existence are displayed in
> Menuconfig if some dependencies are not met in other places.  To help
> dummies like me know that it's there, please consider the following
> patch:

Better is to put comments in CONFIG_NETFILTER, I think.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
