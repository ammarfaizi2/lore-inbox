Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267211AbSLKQph>; Wed, 11 Dec 2002 11:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267214AbSLKQph>; Wed, 11 Dec 2002 11:45:37 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:52106 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267211AbSLKQpg>; Wed, 11 Dec 2002 11:45:36 -0500
From: Olaf Dietsche <olaf.dietsche@t-online.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.51: Filesystem capabilities 0.12
Date: Wed, 11 Dec 2002 17:53:11 +0100
Message-ID: <87d6o8lcp4.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Military
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This *untested* patch implements filesystem capabilities. It allows to
run privileged executables without the need for suid root.

Changes:
- updated to 2.5.51
- fixed deactivating fscaps at busy umount

This patch is available at:
<http://home.t-online.de/home/olaf.dietsche/linux/capability/>

Regards, Olaf.
