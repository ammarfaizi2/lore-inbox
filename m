Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUBDAIQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 19:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266222AbUBDAIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 19:08:16 -0500
Received: from prin.lo2.opole.pl ([213.77.100.98]:12302 "EHLO
	prin.lo2.opole.pl") by vger.kernel.org with ESMTP id S266221AbUBDAIG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 19:08:06 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: glibc-kernel-headers 2.6.1.2 released
Date: Wed, 4 Feb 2004 01:05:13 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402040105.13867.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available at http://ep09.pld-linux.org/~mmazur/glibc-kernel-headers/

Changes:
- linux/fs.h and linux/quota.h got fixed (samba compiles)
- linux/awe_voice.h is back
- linux/types.h got fixed so it doesn't conflict with glibc
- signal handling was removed and everything switched to using glibc headers
- removed some kernel-only code
- plus some minor fixes here and there

