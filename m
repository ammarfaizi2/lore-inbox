Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130090AbRCERpT>; Mon, 5 Mar 2001 12:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130079AbRCERpJ>; Mon, 5 Mar 2001 12:45:09 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2052 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130090AbRCERo7>; Mon, 5 Mar 2001 12:44:59 -0500
Subject: Re: Annoying CD-rom driver error messages
To: law@sgi.com (LA Walsh)
Date: Mon, 5 Mar 2001 17:47:45 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AA3CEE8.1ABDB27D@sgi.com> from "LA Walsh" at Mar 05, 2001 09:37:44 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Zz5I-0007Pa-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Slightly less annoying -- when no CD is in the drive, I'm getting:
> 
> Mar  5 09:30:42 xena kernel: VFS: Disk change detected on device ide1(22,0)
> Mar  5 09:31:17 xena last message repeated 7 times
> Mar  5 09:32:18 xena last message repeated 12 times
> Mar  5 09:33:23 xena last message repeated 13 times
> Mar  5 09:34:24 xena last message repeated 12 times

rpm -e magicdev (or equivalentpackagemanager delete magicdev)

this isnt a kernel problem, its a _very_ stupid app

