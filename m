Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266542AbSKGN3v>; Thu, 7 Nov 2002 08:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266544AbSKGN3u>; Thu, 7 Nov 2002 08:29:50 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:14291 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266542AbSKGN3u>; Thu, 7 Nov 2002 08:29:50 -0500
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.46: Filesystem capabilities 0.11
Date: Thu, 07 Nov 2002 14:36:21 +0100
Message-ID: <87el9xo622.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements filesystem capabilities. It allows to run
privileged executables without the need for suid root.

Changes:
- fixed reference counting
- fixed oops at umount

This patch is available at:
<http://home.t-online.de/home/olaf.dietsche/linux/capability/>

Regards, Olaf.
