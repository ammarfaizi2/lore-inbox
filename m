Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286447AbSBODXn>; Thu, 14 Feb 2002 22:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286462AbSBODXd>; Thu, 14 Feb 2002 22:23:33 -0500
Received: from 75-223.davnet.com.hk ([202.69.75.223]:30100 "EHLO
	nicksbox.tyict.vtc.edu.hk") by vger.kernel.org with ESMTP
	id <S286447AbSBODXZ>; Thu, 14 Feb 2002 22:23:25 -0500
Message-ID: <3C6C7F29.DE677AB4@vtc.edu.hk>
Date: Fri, 15 Feb 2002 11:23:22 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-pre7-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: cmd649 not working with 2 CPU box; what IDE card should I use?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear folks,

I have tried cmd649 ATA pci cards; they work great with single CPU
kernels, not at all with SMP kernels.  The SMP kernel just does not make
an entry in /proc/ide.  Some details are in my post on 13 Feb, with
subject: cmd649 ok 1 cpu, 2 cpus, not working.  I would appreciate any
pointers that may lead to getting them working.

So if this is not a common problem, does _anyone_ use ATA cards with SMP
boxes?  If so, which ones work?  HPT?

--
Nick Urbanik   RHCE                                  nicku@vtc.edu.hk
Dept. of Information & Communications Technology
Hong Kong Institute of Vocational Education (Tsing Yi)
Tel:   (852) 2436 8576, (852) 2436 8579          Fax: (852) 2436 8526
PGP: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B     ID: 7529555D
GPG: 7FFA CDC7 5A77 0558 DC7A 790A 16DF EC5B BB9D 2C24   ID: BB9D2C24



