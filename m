Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTG1KlL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 06:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbTG1KlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 06:41:11 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:49898 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264030AbTG1KlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 06:41:10 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0-test2: Filesystem capabilities 0.15
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Mon, 28 Jul 2003 12:56:21 +0200
Message-ID: <871xwa9ay2.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This *untested* patch implements filesystem capabilities. It allows to
run privileged executables without the need for suid root.

Changes:
- updated to 2.6.0-test2

This patch is available at:
<http://www.olafdietsche.de/linux/capability/>

Regards, Olaf.
