Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275508AbTHNV2D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 17:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275535AbTHNV2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 17:28:03 -0400
Received: from law14-f6.law14.hotmail.com ([64.4.21.6]:19984 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S275508AbTHNV2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 17:28:01 -0400
X-Originating-IP: [194.85.81.178]
X-Originating-Email: [john_r_newbie@hotmail.com]
From: "John Newbie" <john_r_newbie@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Boot sequence in 2.4
Date: Fri, 15 Aug 2003 01:28:00 +0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law14-F6YEuZFkTEPcO00055075@hotmail.com>
X-OriginalArrivalTime: 14 Aug 2003 21:28:00.0868 (UTC) FILETIME=[F019A240:01C362AA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please explain me couple of things.

1) I have / on filesystem, compiled as module, and have initial ram disk 
(initrd), with
    FS module, static insmod binary, linuxrc and so. So how kernel access 
initrd file at the boot time,
    when it doesn't understand FS on /? Which role plays lilo?

2) How to intercept system calls in 2.6 ? Old technique dont work any more 
'cause absence of
    syscall_table[].

_________________________________________________________________
The new MSN 8: advanced junk mail protection and 2 months FREE* 
http://join.msn.com/?page=features/junkmail

