Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbTJDAB1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 20:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbTJCX40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:56:26 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:18942 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261659AbTJCXzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:55:32 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0-test6: Filesystem capabilities 0.15
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sat, 04 Oct 2003 01:55:29 +0200
Message-ID: <874qypdgge.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This *untested* patch implements filesystem capabilities. It allows to
run privileged executables without the need for suid root.

Changes:
- updated to 2.6.0-test6
- added lscap to show fs caps for a particular file

This patch is available at:
<http://www.olafdietsche.de/linux/capability/>

Regards, Olaf.
