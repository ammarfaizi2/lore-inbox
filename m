Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266679AbUJNLHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266679AbUJNLHs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 07:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270026AbUJNLHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 07:07:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:50638 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266679AbUJNLHr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 07:07:47 -0400
X-Authenticated: #4399952
Date: Thu, 14 Oct 2004 13:23:14 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: "K.R. Foley" <kr@cybsft.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       Daniel Walker <dwalker@mvista.com>, Bill Huey <bhuey@lnxw.com>,
       Andrew Morton <akpm@osdl.org>, jackit-devel@lists.sourceforge.net
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
Message-ID: <20041014132314.267f7ea9@mango.fruits.de>
In-Reply-To: <20041014131604.106496fe@mango.fruits.de>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	<20041011215909.GA20686@elte.hu>
	<20041012091501.GA18562@elte.hu>
	<20041012123318.GA2102@elte.hu>
	<20041012195424.GA3961@elte.hu>
	<20041013061518.GA1083@elte.hu>
	<20041014002433.GA19399@elte.hu>
	<20041014105711.654efc56@mango.fruits.de>
	<20041014091953.GA21635@elte.hu>
	<20041014120007.01c26760@mango.fruits.de>
	<15261.195.245.190.94.1097749350.squirrel@195.245.190.94>
	<20041014124845.5daecec2@mango.fruits.de>
	<416E5AF6.8080802@cybsft.com>
	<20041014131604.106496fe@mango.fruits.de>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> nah, this worked very well for all other versions of the VP patches. right
> now i'm building U0 w/o PREEMPT_REALTIME, to see if i still get the
> exception.
> 

jackd seems to work fine w/o PREEMPT_REALTIME (otherwise identical config).

flo
