Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136498AbRD3RIc>; Mon, 30 Apr 2001 13:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136501AbRD3RIT>; Mon, 30 Apr 2001 13:08:19 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6665 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136499AbRD3RIG>; Mon, 30 Apr 2001 13:08:06 -0400
Subject: Re: reiserfs autofix?
To: spam@perlpimp.com
Date: Mon, 30 Apr 2001 18:09:24 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010430000704.A2313@vancouver.yi.org> from "putter" at Apr 30, 2001 12:07:04 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uHAu-0008II-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   2376  Apr 29 15:23:28 candle fancylogin: from /dev/tty1: ACCESS GRANTED: pavel logged in 
>   2377  Apr 29 15:23:33 candle kernel: NVRM: loading NVIDIA kernel module version 1.0-769 
>   2378  Apr 29 16:24:29 candle kernel: mtrr: no MTRR for e4000000,2000000 found 
>   2379  Apr 29 16:24:45 candle kernel: mtrr: no MTRR for e4000000,2000000 found 
>   2380  Apr 29 16:24:50 candle fancylogin: from /dev/tty1: ACCESS GRANTED: pavel logged in 

You are using the NVIDIA closed driver. Please duplicate the problem without
that driver or take it up with NVIDIA not the kernel list

