Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264867AbSKEPo5>; Tue, 5 Nov 2002 10:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264873AbSKEPo5>; Tue, 5 Nov 2002 10:44:57 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:60583 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264867AbSKEPo4>; Tue, 5 Nov 2002 10:44:56 -0500
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.46: access permission filesystem
Date: Tue, 05 Nov 2002 16:51:20 +0100
Message-ID: <87adko581z.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
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
- updated to 2.5.46

This patch is available at:
<http://home.t-online.de/home/olaf.dietsche/linux/accessfs/>

Regards, Olaf.
