Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbTABQLO>; Thu, 2 Jan 2003 11:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262384AbTABQLO>; Thu, 2 Jan 2003 11:11:14 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:6297 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262380AbTABQLN>; Thu, 2 Jan 2003 11:11:13 -0500
From: Olaf Dietsche <olaf.dietsche@t-online.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.54: Filesystem capabilities 0.14
Date: Thu, 02 Jan 2003 17:19:26 +0100
Message-ID: <87r8bved81.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Military
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This *untested* patch implements filesystem capabilities. It allows to
run privileged executables without the need for suid root.

Changes:
- updated to 2.5.54

This patch is available at:
<http://home.t-online.de/home/olaf.dietsche/linux/capability/>

Regards, Olaf.
