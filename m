Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285135AbRLWHcF>; Sun, 23 Dec 2001 02:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285137AbRLWHbz>; Sun, 23 Dec 2001 02:31:55 -0500
Received: from zeus.hjc.edu.sg ([203.127.28.34]:61116 "HELO zeus.hjc.edu.sg")
	by vger.kernel.org with SMTP id <S285135AbRLWHbq>;
	Sun, 23 Dec 2001 02:31:46 -0500
To: linux-kernel@vger.kernel.org
Subject: Kernel NMI Received Error Message
Message-ID: <1009092692.3c258855003a7@home.hjc.edu.sg>
Date: Sun, 23 Dec 2001 15:31:33 +0800 (SGT)
From: Chen Shiyuan <csy@hjc.edu.sg>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Hwa Chong Junior College Mail System (CMS)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When running Linux Kernel 2.4.17rc1 as well as earlier versions of the 
Linux kernel such as 2.2.19, 2.2.18 and before on two Dell PowerEdge 
2400 servers with 512MB RAM, occasionally and very randomly, the 
following error message will pop up in the log files as well as when I 
run dmesg .

kernel: Uhhuh. NMI received. Dazed and confused, but trying to continue 
kernel: You probably have a hardware problem with your RAM chips 

After the error message is received, the system appears to operate just 
fine and could run into hundred odd days (2.2.19) without crashing or 
failing.

I ran the latest diagnostics utilities that were downloaded from the 
Dell Support website and it ran through the system tests just fine and 
did not report that there are problems with the memory.

Has anyone else encountered this problem before or have any idea what 
could trigger this error message or solve the problem?

Many thanks in advance and Merry Christmas to all!
