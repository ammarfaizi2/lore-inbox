Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267883AbTBKOjA>; Tue, 11 Feb 2003 09:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267884AbTBKOjA>; Tue, 11 Feb 2003 09:39:00 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:13517 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267883AbTBKOi7>; Tue, 11 Feb 2003 09:38:59 -0500
From: Olaf Dietsche <olaf.dietsche@t-online.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.60: access permission filesystem 0.14
Date: Tue, 11 Feb 2003 15:48:23 +0100
Message-ID: <87lm0mdgaw.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Military
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This *untested* patch adds a new permission managing file system.
Furthermore, it adds two modules, which make use of this file system.

One module allows granting capabilities based on user-/groupid. The
second module allows to grant access to lower numbered ports based on
user-/groupid, too.

Changes:
- updated to 2.5.60

This patch is available at:
<http://home.t-online.de/home/olaf.dietsche/linux/accessfs/>

Regards, Olaf.
