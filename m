Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262951AbUEBKHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUEBKHZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 06:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbUEBKHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 06:07:25 -0400
Received: from bay18-f4.bay18.hotmail.com ([65.54.187.54]:54027 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262951AbUEBKHX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 06:07:23 -0400
X-Originating-IP: [67.22.169.122]
X-Originating-Email: [jpiszcz@hotmail.com]
From: "Justin Piszcz" <jpiszcz@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Journaling File Sstem Question
Date: Sun, 02 May 2004 10:07:20 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY18-F4FXfyY0QUUBP00002758@hotmail.com>
X-OriginalArrivalTime: 02 May 2004 10:07:20.0752 (UTC) FILETIME=[41B8FB00:01C4302D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Concerning JFS vs REISERFS vs XFS...

Which would one use for stability?

I realize XFS has been in use probably longer than the other two on SGI's, 
but in Linux it was only recently merged into the 2.4.xx kernel.

However, ReiserFS has been in the 2.4 kernel since the early 2.4.x series, 
JFS on the other hand is somewhere in the middle.

Between ReiserFS and XFS, which would you choose for stability?
Total benchmark time on all three filesystems are practically the same, so 
this is why I am having such a difficult time deciding which to use, 
ReiserFS or XFS.

Also, ext3 is out of the question as it is the worst performing filesystem 
(according to my benchmarks) in almost all aspects when compared with the 
other journaling file systems (XFS,JFS,ReiserFS).

Any comments?

_________________________________________________________________
Check out the coupons and bargains on MSN Offers! http://youroffers.msn.com

