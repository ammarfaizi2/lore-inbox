Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268089AbUJLXnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268089AbUJLXnE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 19:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268092AbUJLXnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 19:43:04 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:15783 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268089AbUJLXnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 19:43:01 -0400
Subject: Re: [Ext-rt-dev] Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Lee Revell <rlrevell@joe-job.com>
To: Adam Heath <doogie@debian.org>
Cc: Bill Huey <bhuey@lnxw.com>, Sven Dietrich <sdietrich@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, dwalker@mvista.com,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       amakarov@ru.mvista.com, ext-rt-dev@mvista.com,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0410121815420.1211@gradall.private.brainfood.com>
References: <20041012211201.GA28590@nietzsche.lynx.com>
	 <EOEGJOIIAIGENMKBPIAEGEJGDKAA.sdietrich@mvista.com>
	 <20041012225706.GC30966@nietzsche.lynx.com>
	 <Pine.LNX.4.58.0410121815420.1211@gradall.private.brainfood.com>
Content-Type: text/plain
Message-Id: <1097624193.1553.112.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 12 Oct 2004 19:36:34 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-12 at 19:17, Adam Heath wrote:
> This is because companies and inviduals still think that developing things
> privately is the correct way to go.  Doing things this way will leave
> open the possibility that someone else will do the same bit of work, and
> the final output will clash.
> 
> Remember, release early, release often.

Except that none of the parties involved claim to have solved all the
priority inheritance issues etc.  "Releasing early" if it doesn't work
yet just makes you look bad.  There are perfectly valid reasons to do
kernel development privately.  MontaVista was doing just that and they
saw that some of their work may be duplicated so they released it.  I
don't see how this conflicts with the open source development process at
all.

Lee

