Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbTJ3XOh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 18:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbTJ3XOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 18:14:36 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:9944 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262991AbTJ3XOe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 18:14:34 -0500
Message-ID: <3FA19B32.7080207@cyberone.com.au>
Date: Fri, 31 Oct 2003 10:13:54 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: First Name <linuxquestasu@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Cyclic Scheduler for linux
References: <20031030220448.119.qmail@web12908.mail.yahoo.com>
In-Reply-To: <20031030220448.119.qmail@web12908.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First Name wrote:

>Hi,
>
>Just like Linux has round robin, FIFO and other
>scheduling policies inside the kernel, I would like to
>provide a cyclic/clock driven scheduling policy to
>linux. Meaning all set of tasks should be able to use
>this policy. This should include any Java threads
>also. JVM by itslef provides a priority driven policy
>to its threads. JVM sits on the kernel. Modification
>to JVM is also required to schedule threads
>cyclically. But first I am trying to get this working
>with the kernel and then later with JVM.
>
>If you need any more information, I will be glad to
>provide them.
>
>I would like to direct you to a website of a course
>offered at Cornell university where this assignment is
>posted. I want to achieve something similar to this.
>
>Here is the link to that website.
>http://www.cs.cornell.edu/Courses/cs415/2000fa/scheduler.html
>
>Please Help me.
>
>

Hi,
Please stop sending this email, it sometimes takes people a day or
two to reply. That said, you would be better off asking your lecturer
or a tutor for help. However, I suggest you study and understand
kernel/sched.c to start with.

Nick


