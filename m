Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbSLZV11>; Thu, 26 Dec 2002 16:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264614AbSLZV11>; Thu, 26 Dec 2002 16:27:27 -0500
Received: from user-24-214-12-221.knology.net ([24.214.12.221]:41404 "EHLO
	localdomain") by vger.kernel.org with ESMTP id <S264610AbSLZV10> convert rfc822-to-8bit;
	Thu, 26 Dec 2002 16:27:26 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Ro0tSiEgE <lkml@ro0tsiege.org>
To: linux-kernel@vger.kernel.org
Subject: Debian boot-flopppies and 2.5.53 dont mix
Date: Thu, 26 Dec 2002 15:38:59 -0600
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212261538.59540.lkml@ro0tsiege.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried 5 different IRC channels and no one will give me any answers. I 
created a Debian (woody) install cd for my laptop (no floppy) and the kernel 
2.5.53 (2.4 and below have VERY weird issues with my pavilion notebook and 
the ALi chipset, which still no one can give an answer as to how to fix 
THAT), and it panics saying Unable to mount root "" or 01:00. Some people 
said try root=/dev/ide/[etc..] but that doesn't work, I want to boot the 
initrd for the install, not a partition on the hard drive. Please, how can I 
accomplish this?? Sorry if I'm being cranky but everyone has been driving me 
nuts and treating me like dirt in the channels.



