Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266613AbUGKWIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266613AbUGKWIL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 18:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266630AbUGKWIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 18:08:11 -0400
Received: from smtp-out1.blueyonder.co.uk ([195.188.213.4]:47439 "EHLO
	smtp-out1.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S266613AbUGKWIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 18:08:09 -0400
Message-ID: <40F1BA46.9000207@blueyonder.co.uk>
Date: Sun, 11 Jul 2004 23:08:06 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.x Scheduler, preemption and responsiveness - puzzlement 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jul 2004 22:08:25.0545 (UTC) FILETIME=[9676FB90:01C46793]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the 2.6 kernel I expected that my boxes would be responsive under 
heavy loads such as exacted by updatedb. What I'm finding is that when 
updatedb and other heavy hitters are running, I'm often unable to switch 
desktops or start other tasks. I'm currently using 2.6.7-mm1, but this 
has been true for all 2.6 kernels. I have CONFIG_PREEMPT=y, 
/proc/sys/kernel/kernel_preemption doesn't exist.
SuSE 9.1, Athlon XP2800+, 512M.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
===== LINUX ONLY USED HERE =====

