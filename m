Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265429AbUGVNWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265429AbUGVNWE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 09:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265462AbUGVNWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 09:22:04 -0400
Received: from moutng.kundenserver.de ([212.227.126.176]:6125 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265429AbUGVNWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 09:22:01 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.7: Filesystem capabilities 0.16
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Thu, 22 Jul 2004 15:21:59 +0200
Message-ID: <87oem8xjm0.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements filesystem capabilities. It allows to run
privileged executables without the need for suid root.

Changes:
- updated to 2.6.7

This patch is available at:
<http://www.olafdietsche.de/linux/capability/>

Regards, Olaf.
