Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUIVHwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUIVHwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 03:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUIVHwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 03:52:13 -0400
Received: from bay9-f7.bay9.hotmail.com ([64.4.47.7]:59915 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S261602AbUIVHwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 03:52:09 -0400
X-Originating-IP: [202.79.62.16]
X-Originating-Email: [manish_regmi@hotmail.com]
From: "manish regmi" <manish_regmi@hotmail.com>
To: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: How SIGEV_THREAD is handled.
Date: Wed, 22 Sep 2004 07:48:43 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY9-F7jZXXF1Rw0aax0008f43b@hotmail.com>
X-OriginalArrivalTime: 22 Sep 2004 07:49:00.0863 (UTC) FILETIME=[9FACACF0:01C4A078]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
Can anybody tell me how sigevent notification for SIGEV_THREAD is 
implemented in linux.

According to POSIX,
for SIGEV_NONE , do nothing.
for SIGEV_SIGNAL, sent signal (sigev_signo).

but i have no idea what to do for SIGEV_THREAD.
POSIX tells that a notification function should be called. How is it 
implemented?where?

I am learning Posix signals and Timers.

thanks in advance.

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

