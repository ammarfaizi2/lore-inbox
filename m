Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbTHYD1m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 23:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbTHYD1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 23:27:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:29889 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261431AbTHYD1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 23:27:39 -0400
Message-ID: <34251.4.4.25.4.1061782057.squirrel@www.osdl.org>
Date: Sun, 24 Aug 2003 20:27:37 -0700 (PDT)
Subject: Re: [PATCH] Nick's scheduler policy
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <piggin@cyberone.com.au>
In-Reply-To: <3F48B12F.4070001@cyberone.com.au>
References: <3F48B12F.4070001@cyberone.com.au>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> Patch against 2.6.0-test4. It fixes a lot of problems here vs
> previous versions. There aren't really any open issues for me, so
> testers would be welcome.
>
...
>
> On the other hand, I expect the best cases and maybe most usual cases would
> be better on Con's... and Con might have since done some work in the latency
> area.

Has anyone developed a (run-time) scheduler [policy] selector, via
sysctl or sysfs, so that different kernel builds aren't required?

I know that I have heard discussions of this previously.

~Randy



