Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262373AbTABQKK>; Thu, 2 Jan 2003 11:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262380AbTABQKK>; Thu, 2 Jan 2003 11:10:10 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:50566 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262373AbTABQKJ>; Thu, 2 Jan 2003 11:10:09 -0500
From: Olaf Dietsche <olaf.dietsche@t-online.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.54: access permission filesystem 0.14
Date: Thu, 02 Jan 2003 17:18:22 +0100
Message-ID: <87wulned9t.fsf@goat.bogus.local>
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
- updated to 2.5.54

This patch is available at:
<http://home.t-online.de/home/olaf.dietsche/linux/accessfs/>

Regards, Olaf.
