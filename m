Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315119AbSHGOnY>; Wed, 7 Aug 2002 10:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315375AbSHGOnY>; Wed, 7 Aug 2002 10:43:24 -0400
Received: from [212.3.242.3] ([212.3.242.3]:29936 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S315119AbSHGOnX>;
	Wed, 7 Aug 2002 10:43:23 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org
Subject: Correct path to compilation...
Date: Wed, 7 Aug 2002 16:44:44 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208071644.44361.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Little question: what is the correct path to compiling a kernel?

In the FAQ you find often: 

make dep clean bzImage modules moduleS_install

Now, I, myself, have found that often (especially with -ac kernels) this 
results in some file not being found...

Using

make clean dep .... 

solves the problem.


What is the correct way?

Thanks!

DK
-- 
Shaw's Principle:
	Build a system that even a fool can use, and only a fool will
want to use it.

