Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129778AbRBTXLy>; Tue, 20 Feb 2001 18:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130669AbRBTXLo>; Tue, 20 Feb 2001 18:11:44 -0500
Received: from smtp-2u-1.atlantic.net ([209.208.25.2]:62470 "EHLO
	smtp-2u-1.atlantic.net") by vger.kernel.org with ESMTP
	id <S129778AbRBTXLc>; Tue, 20 Feb 2001 18:11:32 -0500
Date: Tue, 20 Feb 2001 19:15:06 -0500 (EST)
From: Burton Windle <burton@fint.org>
To: linux-kernel@vger.kernel.org
Subject: Detecting SMP
Message-ID: <Pine.LNX.4.21.0102201912150.16545-100000@fint.staticky.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. Is there a way, when running a non-SMP kernel, to detect or
otherwise tell (software only; the machine is 2400 miles away) if the
system has SMP capibilties? Would /proc/cpuinfo show two CPUs if the
kernel is non-SMP?  Thanks!

(btw, the kernel in question is a stock RH6.2 kernel 2.2.14-5, and yes, I 
know I should update it anyways and that a SMP kernel will run on a UP
system)

-- 
Burton Windle				burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.0/init/main.c:655

