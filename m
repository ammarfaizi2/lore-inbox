Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbTFXXV5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 19:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbTFXXV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 19:21:57 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:53454 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262524AbTFXXUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 19:20:17 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.72: Filesystem capabilities 0.14
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Wed, 25 Jun 2003 01:34:25 +0200
Message-ID: <8765mvrqwu.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements filesystem capabilities. It allows to run
privileged executables without the need for suid root.

Changes:
- updated to 2.5.72

This patch is available at:
<http://www.olafdietsche.de/linux/capability/>

Regards, Olaf.
