Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311249AbSCLUFZ>; Tue, 12 Mar 2002 15:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311258AbSCLUFP>; Tue, 12 Mar 2002 15:05:15 -0500
Received: from ccs.covici.com ([209.249.181.196]:40606 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S311249AbSCLUE5>;
	Tue, 12 Mar 2002 15:04:57 -0500
To: linux-kernel@vger.kernel.org
Subject: vmware and 2.5 kernels ?
From: John Covici <covici@ccs.covici.com>
Date: Tue, 12 Mar 2002 15:04:54 -0500
Message-ID: <m3n0xdh7rt.fsf@ccs.covici.com>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.1.90
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I am trying to get the vmware modules to compile with the 2.5
kernel (2.5.6-pre2). I replaced the malloc.h references with slab.h as
there is no longer a malloc.h, but I am still getting errors with
current->fd structures.

Anyone got this correct?

Any assistance would be appreciated.

-- 
         John Covici
         covici@ccs.covici.com
