Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280810AbRKGOzp>; Wed, 7 Nov 2001 09:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280809AbRKGOzf>; Wed, 7 Nov 2001 09:55:35 -0500
Received: from mustard.heime.net ([194.234.65.222]:45503 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S280808AbRKGOzP>; Wed, 7 Nov 2001 09:55:15 -0500
Date: Wed, 7 Nov 2001 15:55:13 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: RAID question
Message-ID: <Pine.LNX.4.30.0111071554160.29262-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

I booted up 2.4.13-ac5 today, and got this message

raid5: measuring checksumming speed
   8regs     :  1480.800 MB/sec
   32regs    :   711.200 MB/sec
   pIII_sse  :  1570.400 MB/sec
   pII_mmx   :  1787.200 MB/sec
   p5_mmx    :  1904.000 MB/sec
raid5: using function: pIII_sse (1570.400 MB/sec)

Why is raid5 using function pIII_sse when p5_MMX is way faster?

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

