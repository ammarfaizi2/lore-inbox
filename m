Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293028AbSCOSPs>; Fri, 15 Mar 2002 13:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293035AbSCOSPi>; Fri, 15 Mar 2002 13:15:38 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:3198 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S293028AbSCOSPZ>; Fri, 15 Mar 2002 13:15:25 -0500
Date: Fri, 15 Mar 2002 13:15:23 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
Subject: 2.4.19-pre3 s390 memorandum
Message-ID: <20020315131523.A24597@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

thanks for taking action and sending updates for 2.4.19-pre3.
I am happy to report that it generally works, and with the
partition code it recognises ECKD volumes.

I would very much prefer if you sent future updates in plain
diff -u to linux-kernel too. I appreciate tarballs that you
sent to me, but this is not quite what would prevent broken
kernels in the future [it helps Red Hat to ship working kernels,
but it does not help Marcelo]. As it was with 2.4.18, Marcelo
has no choice but to accept all code that belongs to your
authority and to fail every else, producing inconsistency.
Posting to linux-kernel beforehand is supposed to start a
discussion that may guide Marcelo to accept changes to generic code.
I will send the example with the partition code immediately.

Greetings,
-- Pete
