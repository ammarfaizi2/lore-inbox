Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936756AbWLCPAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936756AbWLCPAL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 10:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936753AbWLCPAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 10:00:07 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:25591 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S936752AbWLCPAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 10:00:03 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.19: Filesystem capabilities 0.16
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sun, 03 Dec 2006 16:00:02 +0100
Message-ID: <871wnhqb2l.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Constant Variable,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements filesystem capabilities. It allows to
run privileged executables without the need for suid root.

Changes:
- updated to 2.6.19

This patch is available at:
<http://www.olafdietsche.de/linux/capability/>

Regards, Olaf.
