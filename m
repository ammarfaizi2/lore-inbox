Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbSLURYN>; Sat, 21 Dec 2002 12:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262783AbSLURYN>; Sat, 21 Dec 2002 12:24:13 -0500
Received: from [66.21.109.1] ([66.21.109.1]:6149 "EHLO
	mail.dynastytechnologies.net") by vger.kernel.org with ESMTP
	id <S262692AbSLURYM> convert rfc822-to-8bit; Sat, 21 Dec 2002 12:24:12 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Ro0tSiEgE <lkml@ro0tsiege.org>
To: linux-kernel@vger.kernel.org
Subject: Kernel GCC Optimizations
Date: Sat, 21 Dec 2002 11:35:10 -0600
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212211135.10289.lkml@ro0tsiege.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any risk using -O3 instead of -O2 to compile the kernel, and why?
 Also what about compiling against glibc 2.3.1 and gcc 3.2.x??
Thanks!

--Ro0tSiEgE