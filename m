Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbVBKDlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVBKDlr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 22:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVBKDlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 22:41:47 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:31126 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S262133AbVBKDlp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 22:41:45 -0500
Message-Id: <200502110341.j1B3fS8o017685@localhost.localdomain>
To: Peter Williams <pwil3058@bigpond.net.au>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Matt Mackall <mpm@selenic.com>,
       Chris Wright <chrisw@osdl.org>, "Jack O'Quin" <jack.oquin@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>,
       rlrevell@joe-job.com, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.11-rc3-mm2 
In-reply-to: Your message of "Fri, 11 Feb 2005 14:26:14 +1100."
             <420C25D6.6090807@bigpond.net.au> 
Date: Thu, 10 Feb 2005 22:41:28 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.197.126.48] at Thu, 10 Feb 2005 21:41:44 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  [ the best solution is .... ]

  [ my preferred solution is ... ]

  [ it would be better if ... ]

  [ this is a kludge and it should be done instead like ... ]

did nobody read what andrew wrote and what JOQ pointed out?

after weeks of debating this, no other conceptual solution emerged
that did not have at least as many problems as the RT LSM module, and
all other proposed solutions were also more invasive of other aspects
of kernel design and operations than RT LSM is.

--p

