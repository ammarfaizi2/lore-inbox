Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936751AbWLCO7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936751AbWLCO7w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 09:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936752AbWLCO7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 09:59:52 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:9189 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S936751AbWLCO7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 09:59:51 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.19: access permission filesystem 0.19
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sun, 03 Dec 2006 15:59:49 +0100
Message-ID: <87ac25qb2y.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Constant Variable,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new permission managing file system.
Furthermore, it adds two modules, which make use of this file system.

One module allows granting capabilities based on user-/groupid. The
second module allows to grant access to lower numbered ports based on
user-/groupid, too.

Changes:
- updated to 2.6.19
- state license more precisely as GPL v2

This patch is available at:
<http://www.olafdietsche.de/linux/accessfs/>

Regards, Olaf.
