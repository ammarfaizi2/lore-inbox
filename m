Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbTJ3WEu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 17:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbTJ3WEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 17:04:50 -0500
Received: from web12908.mail.yahoo.com ([216.136.174.75]:3513 "HELO
	web12908.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262836AbTJ3WEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 17:04:49 -0500
Message-ID: <20031030220448.119.qmail@web12908.mail.yahoo.com>
Date: Thu, 30 Oct 2003 14:04:48 -0800 (PST)
From: First Name <linuxquestasu@yahoo.com>
Subject: Cyclic Scheduler for linux
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just like Linux has round robin, FIFO and other
scheduling policies inside the kernel, I would like to
provide a cyclic/clock driven scheduling policy to
linux. Meaning all set of tasks should be able to use
this policy. This should include any Java threads
also. JVM by itslef provides a priority driven policy
to its threads. JVM sits on the kernel. Modification
to JVM is also required to schedule threads
cyclically. But first I am trying to get this working
with the kernel and then later with JVM.

If you need any more information, I will be glad to
provide them.

I would like to direct you to a website of a course
offered at Cornell university where this assignment is
posted. I want to achieve something similar to this.

Here is the link to that website.
http://www.cs.cornell.edu/Courses/cs415/2000fa/scheduler.html

Please Help me.

Thanks,
Linux Quest


__________________________________
Do you Yahoo!?
Exclusive Video Premiere - Britney Spears
http://launch.yahoo.com/promos/britneyspears/
