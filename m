Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317091AbSFBAr6>; Sat, 1 Jun 2002 20:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317092AbSFBAr5>; Sat, 1 Jun 2002 20:47:57 -0400
Received: from mail211.mail.bellsouth.net ([205.152.58.151]:39546 "EHLO
	imf11bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S317091AbSFBAr5>; Sat, 1 Jun 2002 20:47:57 -0400
Subject: P4 hyperthreading
From: Louis Garcia <louisg00@bellsouth.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Jun 2002 20:40:44 -0400
Message-Id: <1022978449.2197.10.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How stable is hyperthreading under kernel-2.4.18? I compiled the kernel
for the Pentium4 and dmesg shows CPU0 and CPU1, but CPU1 is disabled.
How do I enable CPU1 and should I?? Do other libraries need to be updated
or is hyperthreading like having a two processor box?

--Lou

