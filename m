Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283855AbRLAAL3>; Fri, 30 Nov 2001 19:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283853AbRLAALT>; Fri, 30 Nov 2001 19:11:19 -0500
Received: from host133.bigidea.com ([38.196.61.133]:24233 "EHLO
	wolverine.bigidea.com") by vger.kernel.org with ESMTP
	id <S283852AbRLAALK>; Fri, 30 Nov 2001 19:11:10 -0500
Date: Fri, 30 Nov 2001 18:08:27 -0600
From: Joe Rice <jrice@bigidea.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Still having problems with eepro100
Message-ID: <20011130180827.E2265@bigidea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
X-Arbitrary-Number-Of-The-Day: 42
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, 
  I'm having the same type of problems that was talked
about in this thread.  I have seen the same error
on kernels 2.4.7 - 2.4.10, which is:

eth0: card reports no resources.
__alloc_pages: 0_order allocation failed (gfp=0x20/0) from c012da00

at which point i see NFS timeouts or the machine hangs
and requires a cold reboot.

also, I haven't had any luck with the Intel e100 driver.


I'm now testing on 10 of the nodes the 2.4.16 kernel.  They
have been under a moderate load and i haven't seen any
problems yet.  I still plan on doing a large load test
on this newer kernel.

joe


www.bigidea.com
