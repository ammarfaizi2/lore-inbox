Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263509AbSIQCq2>; Mon, 16 Sep 2002 22:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263511AbSIQCq2>; Mon, 16 Sep 2002 22:46:28 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:1276 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S263509AbSIQCq2>;
	Mon, 16 Sep 2002 22:46:28 -0400
Date: Mon, 16 Sep 2002 22:51:09 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Peter Waechtler <pwaechtler@mac.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: Oops in sched.c on PPro SMP
Message-ID: <20020917025108.GA4572@www.kroptech.com>
References: <20020916154446.GI11605@dualathlon.random> <8BA3FD1E-C9B9-11D6-8873-00039387C942@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8BA3FD1E-C9B9-11D6-8873-00039387C942@mac.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just built and booted 2.4.20-pre7 on my SMP ppro. If there's some specific
workload I can run to try to reproduce this, I'd be happy to try. Otherwise I'll
just run my normal tasks and see if anything goes haywire. It's been stable for
four hours so far.

(Built with gcc 2.96, BTW.)

--Adam

