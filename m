Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266296AbTBTRYO>; Thu, 20 Feb 2003 12:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266298AbTBTRYO>; Thu, 20 Feb 2003 12:24:14 -0500
Received: from [196.12.44.6] ([196.12.44.6]:34208 "EHLO students.iiit.net")
	by vger.kernel.org with ESMTP id <S266296AbTBTRYN>;
	Thu, 20 Feb 2003 12:24:13 -0500
Date: Thu, 20 Feb 2003 23:04:37 +0530 (IST)
From: Prasad <prasad_s@students.iiit.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Syscall from Kernel Space
Message-ID: <Pine.LNX.4.44.0302202301350.12696-100000@students.iiit.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
	Is there a way using which i could invoke a syscall in the kernel 
space?  The syscall is to be run disguised as another process.  The actual 
situation is that I have a kernel thread running (a proxy for another 
existing but sleeping process) This thread should run syscalls on behalf 
of that process.
	Please so help me out!  Also send me some URLs where i could find 
related stuff.

Prasad.

-- 
Failure is not an option

