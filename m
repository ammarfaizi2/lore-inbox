Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265800AbUJOCso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUJOCso (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 22:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265910AbUJOCso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 22:48:44 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:1540 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S265800AbUJOCsE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 22:48:04 -0400
Date: Thu, 14 Oct 2004 19:47:43 -0700
To: "K.R. Foley" <kr@cybsft.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Daniel Walker <dwalker@mvista.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U2
Message-ID: <20041015024743.GA22893@nietzsche.lynx.com>
References: <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015022341.GA22831@nietzsche.lynx.com> <416F388A.3060204@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416F388A.3060204@cybsft.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 09:40:10PM -0500, K.R. Foley wrote:
> >mm/shmem.c:1362: warning: assignment makes pointer from integer without a 
> >cast
> >mm/shmem.c: In function `shmem_symlink':
> >mm/shmem.c:1719: error: `KM_USER0' undeclared (first use in this function)
> >mm/shmem.c:1719: warning: assignment makes pointer from integer without a 
> >cast
> >make[1]: *** [mm/shmem.o] Error 1
> >make: *** [mm] Error 2
> >root@nietzsche> /home/bhuey/linux-2.6.8% 17# make tags
> 
> What platform are you getting this on?

x86

I ran into other build problems BTW too.

bill

