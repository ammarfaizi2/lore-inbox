Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131097AbRCGONx>; Wed, 7 Mar 2001 09:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131098AbRCGONn>; Wed, 7 Mar 2001 09:13:43 -0500
Received: from pucc.Princeton.EDU ([128.112.129.99]:56344 "EHLO
	pucc.Princeton.EDU") by vger.kernel.org with ESMTP
	id <S131097AbRCGONd>; Wed, 7 Mar 2001 09:13:33 -0500
To: linux-kernel@vger.kernel.org
From: Neale.Ferguson@softwareAG-usa.com
Date: Wed, 7 Mar 2001 09:04:31 +0200
Subject: 2.4.0-s390x progress
Message-Id: <20010307141337Z131097-407+2208@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been using the "Linux from Scratch" (LFS) document as a guide for building
a basic Linux system. The only things I've done outside the instructions
include:

1. Built 32 bit version of binutils, gcc, glibc for s390x
2. Built kernel
3. Created /root64 and populated it with /usr /bin etc.
4. Built 64-bit libncurses

I've now built statically linked 64-bit versions of:
1. bash
2. bzip2
3. diffutils
4. fileutils

These are all installed in the /root64 tree.

According to the LFS instructions I should now build grep, gzip, make,
sed, shellutils, tar, and textutils, before going onto the next phase.
However, I cannot find grep, sed, or tar srpms on the SuSE CDs.

In any event, progress is being made.

Neale
