Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284933AbSAISuG>; Wed, 9 Jan 2002 13:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288960AbSAIStr>; Wed, 9 Jan 2002 13:49:47 -0500
Received: from zeus.city.tvnet.hu ([195.38.100.182]:8322 "EHLO
	zeus.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S284933AbSAISto>; Wed, 9 Jan 2002 13:49:44 -0500
Subject: system time issue
From: Sipos Ferenc <sferi@dumballah.tvnet.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 09 Jan 2002 19:53:27 +0100
Message-Id: <1010602407.6235.0.camel@zeus.city.tvnet.hu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a redhat 7.2 box, and compiled the latest 2.4.18pre2 kernel with
the 2.4.18pre2aa1 patches in order to use gcc pre 3.1. When I shutdown
my system with the new kernel, it writes out normally: syncing system
time with hardware time, and with gcc 2.96 compiled kernels, everything
is ok, but with this kernel, after reboot the bios beeps and the
hardware time and date stands at the beginning, so I have to setup
manually to continue the post process. I think, gcc pre3.1 miscompiles
something in the kernel.

Paco


