Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263488AbTKFLBZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 06:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTKFLBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 06:01:25 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:47582 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263488AbTKFLBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 06:01:25 -0500
Message-Id: <5.1.0.14.2.20031106114658.00a881f8@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 06 Nov 2003 12:01:19 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: 2.4 Firmware Loader does not work builtin
Cc: Hubert Mantel <mantel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: Xjh+r8Z68eS2GCHf9-mwbLmZiAhsgB8iM4fG7aJNyGhsB+1t5wJbQJ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Either it is not supposed to work builtin, in which case, the make
should only offer it as a module, - or , somebody forgot to adjust
lib/Makefile and kernel/ksyms.c
(Copied to maintainer)

Margit


