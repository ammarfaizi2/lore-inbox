Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268156AbUJNWz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268156AbUJNWz4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268159AbUJNWzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:55:53 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:14901 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268129AbUJNWwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 18:52:14 -0400
Message-ID: <f44c5fdf0410141552f7c927@mail.gmail.com>
Date: Fri, 15 Oct 2004 00:52:11 +0200
From: Radoslaw Szkodzinski <astralstorm@gmail.com>
Reply-To: Radoslaw Szkodzinski <astralstorm@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U1
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Dipankar Sarma <dipankar@in.ibm.com>
In-Reply-To: <20041014143131.GA20258@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	 <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
	 <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
	 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	 <20041014143131.GA20258@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004 16:31:31 +0200, Ingo Molnar <mingo@elte.hu> wrote:
> 
> i have released the -U1 PREEMPT_REALTIME patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U1
> 

"scheduling while atomic" messages in Reiser4 mentioned at -U0 thread
also appear in this version, but less often.
