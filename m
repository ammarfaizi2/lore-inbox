Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266805AbSLPQoN>; Mon, 16 Dec 2002 11:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266806AbSLPQoM>; Mon, 16 Dec 2002 11:44:12 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:43412 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266805AbSLPQoI>; Mon, 16 Dec 2002 11:44:08 -0500
From: Olaf Dietsche <olaf.dietsche@t-online.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.52: Filesystem capabilities 0.13
Date: Mon, 16 Dec 2002 17:51:38 +0100
Message-ID: <87fzsxgb51.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Military
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This *untested* patch implements filesystem capabilities. It allows to
run privileged executables without the need for suid root.

Changes:
- updated to 2.5.52
- fixed missing includes

This patch is available at:
<http://home.t-online.de/home/olaf.dietsche/linux/capability/>

Regards, Olaf.
