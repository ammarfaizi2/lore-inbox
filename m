Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291449AbSBUKWK>; Thu, 21 Feb 2002 05:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292320AbSBUKWB>; Thu, 21 Feb 2002 05:22:01 -0500
Received: from ns.suk.net ([195.126.239.3]:28838 "HELO vger.kernel.org")
	by vger.kernel.org with SMTP id <S291449AbSBUKVv>;
	Thu, 21 Feb 2002 05:21:51 -0500
From: <mw@suk.net>
Subject: more detailed information about the AMD 1.6+ GHz MP smp-problem with latest kernel
Message-Id: <20020221102156Z291449-889+4453@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Date: Thu, 21 Feb 2002 05:21:51 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear list members,

As I've posted a message before not including detailed information about the system, I'm now
posting with very detailed information looking for help to get everythign fixed ;-)

Motherboard: ASUS A7M266-D, AMD-760MPX
CPU: AMD Athlon 1600+ 266 FSB
RAM: DDRAM, 512 MB, PC266 ECC registered


The system is a RedHat 7.2 linux installation ... I've first attempted with the included SMP-kernel
which didn't work. Then updated the system with the latest RedHat-build kernel ... rebooted,
SMP-kernel still didn't work. So I saw the last chance in building my own kernel, included some
multi-cpu stuff. The system hang after detecting the 2nd CPU ...

Anybody can provide help to make the 2 CPU's work? ;-)


Cu,
mw
