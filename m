Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270962AbUJVJaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270962AbUJVJaR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 05:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270915AbUJVJ0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 05:26:32 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:60946 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S270918AbUJVJYb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 05:24:31 -0400
Date: Fri, 22 Oct 2004 02:24:04 -0700
To: Jens Axboe <axboe@suse.de>
Cc: Bill Huey <bhuey@lnxw.com>, Thomas Gleixner <tglx@linutronix.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041022092404.GA24605@nietzsche.lynx.com>
References: <20041021201443.GF32465@suse.de> <20041021202422.GA24555@nietzsche.lynx.com> <20041021203350.GK32465@suse.de> <20041021203821.GA24628@nietzsche.lynx.com> <20041022061901.GM32465@suse.de> <20041022085007.GA24444@nietzsche.lynx.com> <20041022085928.GK1820@suse.de> <20041022090637.GA24523@nietzsche.lynx.com> <20041022090938.GB24523@nietzsche.lynx.com> <20041022092058.GO1820@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022092058.GO1820@suse.de>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 11:20:59AM +0200, Jens Axboe wrote:
> I've been as clear as I know how on the matter of semaphore use in
> Linux. I've made no comments at all on improving your deadlock
> detection scheme.

True, but "...deadlock detection breaks" is a negative comment about
the deadlock detector without a positive suggestion to change it, is
it not ? if so, then suggest a change to be made and it'll get
implementated somehow.

bill

