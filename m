Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269165AbUIYBQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269165AbUIYBQL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 21:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269166AbUIYBQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 21:16:11 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:4282 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269165AbUIYBQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 21:16:10 -0400
Subject: Re: Kernel hang with 2.6.9-mm3-S6
From: Lee Revell <rlrevell@joe-job.com>
To: "Gilbert, John" <JGG@dolby.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <2692A548B75777458914AC89297DD7DA05EC7134@bronze.dolby.net>
References: <2692A548B75777458914AC89297DD7DA05EC7134@bronze.dolby.net>
Content-Type: text/plain
Message-Id: <1096074969.12083.19.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 21:16:09 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-24 at 21:07, Gilbert, John wrote:
> Hello,
> This probably needs to be reported to IM or AM.
> I'm building a KGDB instrumented low latency Linux kernel,  the target
> machine is a Dell Inspiron 8100. If it boots to login, and the lid is
> closed, it's hung hard. (Ctrl C from KGDB client does nothing, no curser
> flashing, no keyboard input (not even beeping after holding keys down).
> It doesn't hang at initial kdgbwait, or under 2.6.8.1.
> Let me know if there's anything I can do to help fix this (I'm not a
> kernel programmer).

You should cc: Ingo Molnar on anything related to the voluntary
preemption patches.

Lee

