Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269355AbRHCIwy>; Fri, 3 Aug 2001 04:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269356AbRHCIwp>; Fri, 3 Aug 2001 04:52:45 -0400
Received: from NS.iNES.RO ([193.230.220.1]:65505 "EHLO smtp.ines.ro")
	by vger.kernel.org with ESMTP id <S269355AbRHCIwg>;
	Fri, 3 Aug 2001 04:52:36 -0400
Date: Thu, 2 Aug 2001 11:52:54 +0300 (EEST)
From: Andrei Ivanov <andrei.ivanov@ines.ro>
To: <linux-kernel@vger.kernel.org>
Subject: swap problem
Message-ID: <Pine.LNX.4.30.0108021148020.7898-100000@webdev.ines.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
I was trying to install Oracle 9i on my computer and during install,
I started Mozilla, and after a couple of minutes I noticed that the
install died. I looked in the logs and noticed this:

Aug  3 11:42:35 hate kernel: Bad swap offset entry 130c1000
Aug  3 11:42:35 hate kernel: VM: killing process jre.

Can anybody tell me what happened ?
Could it be a bad block ?
I'm using 2.4.7-ac2 on a PIII 550Mhz, 448MB RAM.
cat /proc/swaps output:
Filename                        Type            Size    Used    Priority
/dev/hda3                       partition       522104  0       -1

If you need any other info, I will provide it.

