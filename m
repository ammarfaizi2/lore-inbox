Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269744AbUJMQPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269744AbUJMQPS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 12:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269745AbUJMQPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 12:15:17 -0400
Received: from peabody.ximian.com ([130.57.169.10]:63387 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269744AbUJMQPL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 12:15:11 -0400
Subject: Re: [Ext-rt-dev] Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Robert Love <rml@novell.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Martijn Sipkema <martijn@entmoot.nl>, Sven Dietrich <sdietrich@mvista.com>,
       "Bill Huey (hui)" <bhuey@lnxw.com>,
       Thomas Gleixner <tglx@linutronix.de>, dwalker@mvista.com,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       amakarov@ru.mvista.com, ext-rt-dev@mvista.com,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1097682969.6538.5.camel@krustophenia.net>
References: <20041012211201.GA28590@nietzsche.lynx.com>
	 <EOEGJOIIAIGENMKBPIAEGEJGDKAA.sdietrich@mvista.com>
	 <20041012225706.GC30966@nietzsche.lynx.com>
	 <027e01c4b12a$188fda40$161b14ac@boromir>
	 <1097682969.6538.5.camel@krustophenia.net>
Content-Type: text/plain
Date: Wed, 13 Oct 2004 12:13:26 -0400
Message-Id: <1097684006.12768.7.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-13 at 11:56 -0400, Lee Revell wrote:

> OK, obvious troll, but I'll bite...
> 
> How is this any different from what the Nvidia module does?

At least in theory, Nvidia uses only exported module interfaces.

The Timesys kernel touches the scheduler, among other things.

	Robert Love


