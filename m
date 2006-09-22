Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWIVMzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWIVMzK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 08:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWIVMzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 08:55:10 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:30709 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932384AbWIVMzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 08:55:09 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.18: Filesystem capabilities 0.16
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Fri, 22 Sep 2006 14:55:04 +0200
Message-ID: <8764fg83iv.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Constant Variable,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This *untested* patch implements filesystem capabilities. It allows to
run privileged executables without the need for suid root.

Changes:
- updated to 2.6.18

This patch is available at:
<http://www.olafdietsche.de/linux/capability/>

Regards, Olaf.
