Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267038AbTBCWfZ>; Mon, 3 Feb 2003 17:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267042AbTBCWfZ>; Mon, 3 Feb 2003 17:35:25 -0500
Received: from web9901.mail.yahoo.com ([216.136.129.36]:14226 "HELO
	web9901.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267038AbTBCWfX>; Mon, 3 Feb 2003 17:35:23 -0500
Message-ID: <20030203224455.84628.qmail@web9901.mail.yahoo.com>
Date: Mon, 3 Feb 2003 14:44:55 -0800 (PST)
From: Akram Abou-Emara <akram485@yahoo.com>
Subject: Kernel Threads questiona on 2.4
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have a couple of questions:

Do kernel threads get preempted? Or do they have to
give up the CPU on their own? 

Are there any rules for what scheduling policies and
priority a kernel thread can have?
reparent_to_init()sets the scheduling policy to
SCHED_OTHER. Do you see a problem with changing the
scheduling policy to  SCHED_FIFO?

Thanks,
Akram

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
