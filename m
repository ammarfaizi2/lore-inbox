Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268919AbUHMBYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268919AbUHMBYq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 21:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268922AbUHMBYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 21:24:45 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:55529 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268919AbUHMBYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 21:24:44 -0400
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040812235116.GA27838@elte.hu>
References: <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
	 <20040810132654.GA28915@elte.hu>  <20040812235116.GA27838@elte.hu>
Content-Type: text/plain
Message-Id: <1092360317.1304.72.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 12 Aug 2004 21:25:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 19:51, Ingo Molnar wrote:
> i've uploaded the latest version of the voluntary-preempt patch:
>      
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc4-O6
> 

Does not compile.  For each module I get:

WARNING: /lib/modules/2.6.8-rc4-O6/kernel/drivers/ieee1394/ohci1394.ko
needs unknown symbol mcount

Lee


