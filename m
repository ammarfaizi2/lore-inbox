Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264207AbTCXN6u>; Mon, 24 Mar 2003 08:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264208AbTCXN6u>; Mon, 24 Mar 2003 08:58:50 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:22677 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S264207AbTCXN6s>; Mon, 24 Mar 2003 08:58:48 -0500
Subject: [Fwd: RE: kernel compile on phoebe 3]
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1048514986.645.30.camel@teapot>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-1) 
Date: 24 Mar 2003 15:09:46 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Forwarded Message-----

From: Pavel Rozenboim <pavelr@coresma.com>
To: phoebe-list@redhat.com
Subject: RE: kernel compile on phoebe 3
Date: 24 Mar 2003 15:22:44 +0200

For some reason I don't get /proc/ksyms file with 2.5 kernels I compile, and
that causes rc.sysinit to set /proc/sys/kernel/modprobe to /bin/true. What
option enables /proc/ksyms creation?

-- 
Phoebe-list mailing list
Phoebe-list@redhat.com
https://listman.redhat.com/mailman/listinfo/phoebe-list

________________________________________________________________________
        Felipe Alfaro Solana
   Linux Registered User #287198
http://counter.li.org

