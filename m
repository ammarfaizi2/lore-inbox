Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263429AbREXI6o>; Thu, 24 May 2001 04:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263430AbREXI6e>; Thu, 24 May 2001 04:58:34 -0400
Received: from zeus.kernel.org ([209.10.41.242]:45209 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S263422AbREXI6S>;
	Thu, 24 May 2001 04:58:18 -0400
Date: Wed, 23 May 2001 15:26:59 -0700
From: Prasanna P Subash <psubash@turbolinux.com>
To: linux-kernel@vger.kernel.org
Subject: Dual Athlon on 2.2.19
Message-ID: <20010523152659.A3020@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a patch to make 2.2.19 kernel work on a dual athlon ? I tried both
2.2.20-pre2aa( with k7 smp ) and 2.2.20-pre2 and at boot after it detects the ide devices
it hangs.

I tried compiling in kdb to get a stack trace but the machine went into a hang.


-- 
Prasanna Subash   ---   psubash@turbolinux.com   ---     TurboLinux, INC
------------------------------------------------------------------------
Linux, the choice          | Stockmayer's Theorem:  If it looks easy,
of a GNU generation   -o)  | it's tough.  If it looks tough, it's damn
Kernel 2.4.1          /\\  | well impossible. 
on a i686            _\\_v | 
                           | 
------------------------------------------------------------------------
