Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270003AbUJNInx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270003AbUJNInx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 04:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270004AbUJNInx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 04:43:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:58777 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270003AbUJNInw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 04:43:52 -0400
X-Authenticated: #4399952
Date: Thu, 14 Oct 2004 10:57:11 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
Message-ID: <20041014105711.654efc56@mango.fruits.de>
In-Reply-To: <20041014002433.GA19399@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	<20041011215909.GA20686@elte.hu>
	<20041012091501.GA18562@elte.hu>
	<20041012123318.GA2102@elte.hu>
	<20041012195424.GA3961@elte.hu>
	<20041013061518.GA1083@elte.hu>
	<20041014002433.GA19399@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004 02:24:33 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> i'm pleased to announce a significantly improved version of the
> Real-Time Preemption (PREEMPT_REALTIME) feature that i have been working
> towards in the past couple of weeks.

Cool :)

Say, does it still apply that one should not use unthreaded IRQ handlers for
all IRQ's when using PREEMPT_REALTIME (Except maybe for the keyboard)?

flo
