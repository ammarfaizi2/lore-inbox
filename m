Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264873AbSKEPqS>; Tue, 5 Nov 2002 10:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbSKEPqR>; Tue, 5 Nov 2002 10:46:17 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:60135 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264873AbSKEPqR>; Tue, 5 Nov 2002 10:46:17 -0500
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.46: Filesystem capabilities
Date: Tue, 05 Nov 2002 16:52:36 +0100
Message-ID: <874raw57zv.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements filesystem capabilities. It allows to run
privileged executables without the need for suid root.

Changes:
- updated to 2.5.46
- updated config info

This patch is available at:
<http://home.t-online.de/home/olaf.dietsche/linux/capability/>

Regards, Olaf.
