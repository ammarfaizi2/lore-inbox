Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267884AbTBKOjJ>; Tue, 11 Feb 2003 09:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267885AbTBKOjJ>; Tue, 11 Feb 2003 09:39:09 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:64963 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267884AbTBKOjH>; Tue, 11 Feb 2003 09:39:07 -0500
From: Olaf Dietsche <olaf.dietsche@t-online.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.60: Filesystem capabilities 0.14
Date: Tue, 11 Feb 2003 15:48:41 +0100
Message-ID: <87fzqudgae.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Military
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This *untested* patch implements filesystem capabilities. It allows to
run privileged executables without the need for suid root.

Changes:
- updated to 2.5.60

This patch is available at:
<http://home.t-online.de/home/olaf.dietsche/linux/capability/>

Regards, Olaf.
