Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261955AbSIZBpN>; Wed, 25 Sep 2002 21:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261994AbSIZBpN>; Wed, 25 Sep 2002 21:45:13 -0400
Received: from [157.182.194.151] ([157.182.194.151]:46010 "EHLO
	mail.csee.wvu.edu") by vger.kernel.org with ESMTP
	id <S261955AbSIZBpM>; Wed, 25 Sep 2002 21:45:12 -0400
Subject: Reg Sparc memory addresses
From: Shanti Katta <katta@csee.wvu.edu>
To: sparc-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 Sep 2002 22:01:15 -0400
Message-Id: <1033005676.2723.5.camel@indus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I compiled user-mode-linux kernel on Ultrasparc with load address set to
00000000e0000000. But, when I try to debug the kernel, it just says
cannot access memory at address 0xa00020b0.
This error message remains the same no matter what I change the load
address to. Can anyone guide me on valid memory addresses for userspace
on Sparc? and how much different is that from x86 architecture?

-Shanti



