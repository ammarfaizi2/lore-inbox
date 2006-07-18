Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWGRPYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWGRPYG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 11:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWGRPYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 11:24:06 -0400
Received: from relay3.uol.com.br ([200.221.4.110]:1003 "EHLO relay3.uol.com.br")
	by vger.kernel.org with ESMTP id S932277AbWGRPXx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 11:23:53 -0400
Date: Tue, 18 Jul 2006 12:23:51 -0300
Message-Id: <J2LURR$5AAF184870D28A0309D5140BC87E495D@uol.com.br>
Subject: ACPI on ASUS A7S333 - Kernel 2.6.13 and higher
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
From: "icoslau" <icoslau@uol.com.br>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
X-XaM3-API-Version: 4.3(R1) (B5)
X-SenderIP: 200.250.215.233
X-SIG5: 58ac99a81e6bbceefaa413af3d994789
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, my name is Adalberto and i live in Brazil.

I have a problem which must be simpler so that yours they can help me.

Until version 2.6.12 of kernel, in any distribution my MOBO ASUS A7S333 works very well, mainly for the fact to use ACPI and disconnect total (power off) when commanded.    

However of version 2.6.13 in ahead I do not obtain the same result.

Already I tried to modify DSDT, to qualify and to incapacitate ACPI or APM in kernel, to pass options to boot as pci=noacpi amongst as much others, but in these finish versions of kernel, the APM only obtains disconnect (power off) schemes it.
The problem is that with qualified APM this schemes tends to stop in all the times in others words, the system hangs.

My question, if somebody will be able to help me, is if it is possible, already I tried but without success, to place in kernel 2.6.13 or higher the instructions of ACPI of kernel 2.6.12. I try copy the acpi from source of 2.6.12 and paste in 2.6.13 but in kernel compilation are many errors in .c files of acpi.

I thank any very I assist that they will be able to give to me in this direction. 

Sorry for my english, its not good.

