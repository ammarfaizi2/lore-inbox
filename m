Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWAQULq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWAQULq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWAQULq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:11:46 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:33740
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S964795AbWAQULp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:11:45 -0500
Subject: Re: Linux 2.6.16-rc1 - hrtimer hotfix
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Lee Revell <rlrevell@joe-job.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1137528482.19678.19.camel@mindpipe>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
	 <1137527648.17180.10.camel@localhost.localdomain>
	 <1137528482.19678.19.camel@mindpipe>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 21:12:11 +0100
Message-Id: <1137528731.17180.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 15:08 -0500, Lee Revell wrote:
> On Tue, 2006-01-17 at 20:54 +0100, Thomas Gleixner wrote:
> > On Tue, 2006-01-17 at 00:19 -0800, Linus Torvalds wrote:
> > > Ok, it's two weeks since 2.6.15, and the merge window is closed.
> > 
> > Please pull from
> > 
> > master.kernel.org:/pub/scm/linux/kernel/git/tglx/hrtimer-2.6.git
> 
> Does this mean 2.6.16 will have high res timers?

No, only the hrtimer base patch is in there

	tglx


