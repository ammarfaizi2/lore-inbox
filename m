Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbUKCUMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbUKCUMn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbUKCUMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:12:43 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:36328 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S261833AbUKCUJx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:09:53 -0500
From: Gene Heskett <gheskett@wdtv.com>
Reply-To: gheskett@wdtv.com
Organization: occasionally detectable
To: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Date: Wed, 3 Nov 2004 15:09:50 -0500
User-Agent: KMail/1.7
Cc: Valdis.Kletnieks@vt.edu, DervishD <lkml@dervishd.net>,
       =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
References: <200411030751.39578.gene.heskett@verizon.net> <200411031426.23880.gheskett@wdtv.com> <200411031933.iA3JXfAL020148@turing-police.cc.vt.edu>
In-Reply-To: <200411031933.iA3JXfAL020148@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411031509.50740.gheskett@wdtv.com>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.46.51] at Wed, 3 Nov 2004 14:09:51 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 14:33, Valdis.Kletnieks@vt.edu wrote:
>On Wed, 03 Nov 2004 14:26:23 EST, Gene Heskett said:
>> Well, since the "device", a bt878 based Haupagge tv card is
>> sitting in a pci socket, thats even more drastic than a reboot.
>
>Not if you have a good hot-swap PCI cage. ;)
>
>Anyhow, that points even more at a driver issue for the bt878 -
>if you can get Sysrq-T output, where does it say the hung process is
>inside the kernel?

Thats another thing I've had compiled in since forever, but it so 
seldom actually *works*, I've tended to forget about it.

-- 
Cheers, gene
gheskett at wdtv dot com
99.28% setiathome rank, not too bad for a WV hillbilly
