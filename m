Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264291AbUEDJpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbUEDJpS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 05:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264298AbUEDJpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 05:45:18 -0400
Received: from cernmx07.cern.ch ([137.138.166.171]:14661 "EHLO
	cernmx07.cern.ch") by vger.kernel.org with ESMTP id S264291AbUEDJpN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 05:45:13 -0400
Keywords: CERN SpamKiller Note: -50 Charset: west-latin
X-Filter: CERNMX07 SMTPGW CERN Spam Sink v1.0
From: Alexander ZVYAGIN <Alexander.Zviagine@cern.ch>
To: linux-kernel@vger.kernel.org
Subject: freezes with cdrecord
Date: Tue, 4 May 2004 11:45:05 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405041145.05894.Alexander.Zviagine@cern.ch>
X-OriginalArrivalTime: 04 May 2004 09:45:11.0718 (UTC) FILETIME=[7E61FC60:01C431BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I use DVD+RW with 2.6.5 kernel. Very often my computer
freezes for ~10-20 seconds when a disk is cleaning.
I can move my mouse pointer, and switch between some
windows, but that is all. Command prompt is
not responding as well. For me it looks like the
filesystem is locked.

During the burning process everything is fine and
smooth. But very close to the end, the computer freezes
again for ~10-20 seconds. It happens in 'fixating' stage
of the writing process.

The created disks are fine, and computer runs OK.
I use k3b fronted to cdrecord 2.1a25.

Any explanations why those freezes happen?

With best wishes,
Alexander.

