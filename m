Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290118AbSA3QvG>; Wed, 30 Jan 2002 11:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289918AbSA3Qtn>; Wed, 30 Jan 2002 11:49:43 -0500
Received: from fw.tnt.de ([194.55.63.2]:16695 "EHLO dbtest.intra.tnt.de")
	by vger.kernel.org with ESMTP id <S290103AbSA3QtA>;
	Wed, 30 Jan 2002 11:49:00 -0500
Message-Id: <200201301648.g0UGmtj32611@pcchk.intra.tnt.de>
Content-Type: text/plain; charset=US-ASCII
From: Michael May <michael.may@tnt.de>
Reply-To: michael.may@tnt.de
Organization: tnt
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Memory
Date: Wed, 30 Jan 2002 17:48:54 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,


I think there is a little Problem with Kernel 2.4.17-pre4 - pre7

When the machine in up for longer than 2 days and is under higher load, the processes will killed, with some syslog-messages: 

kernel: Out of memory: Killed process <pid>

I don't know what the Problem is, and all machines where it is, are SMP-Machines on i386.

Two times, I traced the problem and the system reported full memory.
But, the processes and the Utilities are the same like before updating the kernel,
except the gcc (is now 3.0.3)


Can you solve this?

-----------------------------------
Michael May - UNIX-Administration
+49/2241/497-2742
-----------------------------------
