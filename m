Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274168AbRIXVCg>; Mon, 24 Sep 2001 17:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274169AbRIXVCY>; Mon, 24 Sep 2001 17:02:24 -0400
Received: from dfw-smtpout4.email.verio.net ([129.250.36.44]:1476 "EHLO
	dfw-smtpout4.email.verio.net") by vger.kernel.org with ESMTP
	id <S274168AbRIXVCI>; Mon, 24 Sep 2001 17:02:08 -0400
Message-ID: <3BAF9F68.4EFBC73B@bigfoot.com>
Date: Mon, 24 Sep 2001 14:02:32 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20p10i i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jlmales@softhome.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.2.20-pre10 Initial Impressions
In-Reply-To: <3BA7D82D.21744.63CF95@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"John L. Males" wrote:
> ...
> Ok, I finially had a chance to compile the 2.2.20-pre10 Kernel and
> run it though some basic paces.  I need to do more specific A vs b
> (against the 2.2.19 Kernel), but it seems there are some performance
> issues.  It is seems especially obvious with Netscape 4.78.  I also
> had a odd Xfree error, that may have had some relationship to the
> performance issue.
> ...

FWIW, I've been using ns 4.78 since August 20 on the listed kernels with
no noticable change.  All kernels have Andre's IDE patch.

If you have a specific test script I can give it a run.

2.2.19pre17, 2.2.20pre{6,9,10}
XFree86-3.3.6-29 (SVGA driver)
ide.2.2.19.05042001.patch
communicator-v478-us.x86-unknown-linux2.2.tgz

System is Athlon 850 (CONFIG_M686=y) on an Abit KA7.

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0391 (rev
02)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8391
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev
22)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30)

rgds,
tim.
--
