Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265410AbUIEEwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265410AbUIEEwS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 00:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUIEEwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 00:52:18 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:60879 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265410AbUIEEwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 00:52:09 -0400
Date: Sat, 4 Sep 2004 21:52:05 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: torvalds@osdl.org, ak@muc.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
Message-Id: <20040904215205.0a067ab8.pj@sgi.com>
In-Reply-To: <20040904211749.3f713a8a.pj@sgi.com>
References: <m3zn4bidlx.fsf@averell.firstfloor.org>
	<20040831183655.58d784a3.pj@sgi.com>
	<20040904133701.GE33964@muc.de>
	<20040904171417.67649169.pj@sgi.com>
	<Pine.LNX.4.58.0409041717230.4735@ppc970.osdl.org>
	<20040904180548.2dcdd488.pj@sgi.com>
	<Pine.LNX.4.58.0409041827280.2331@ppc970.osdl.org>
	<20040904204850.48b7cfbd.pj@sgi.com>
	<Pine.LNX.4.58.0409042055460.2331@ppc970.osdl.org>
	<20040904211749.3f713a8a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> starting with backing out the changes made to it this week.

Andi,

Given that Linus has gutted most of your patch to sched_setaffinity,
do you have a preference between where the code started the week,
and where it ended?

If I'm reading Linus' mind right (well ... there's a first time
for everything) then your preference, either way, would likely
carry the day.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
