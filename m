Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTIRMDT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 08:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbTIRMDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 08:03:19 -0400
Received: from mail.ondacorp.com.br ([200.195.196.14]:28359 "EHLO
	mail.ondacorp.com.br") by vger.kernel.org with ESMTP
	id S261180AbTIRMDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 08:03:15 -0400
Message-ID: <3F699FF3.1070102@arenanetwork.com.br>
Date: Thu, 18 Sep 2003 09:07:15 -0300
From: dual_bereta_r0x <dual_bereta_r0x@arenanetwork.com.br>
Organization: ArenaNetwork Lan House & Cyber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030727 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.9 vs 2.4.22 CPU/VM/Sched diffs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all.

We at Half-Life Dedicated Server Linux list are in a warm debat about 
changes in 2.4.9 CPU/VM/Scheduling code versus the actual 2.4.22 ones.

Some guys are reporting a huge cpu decrease usage in the "old" 2.4.9 
kernel version, about 40% lesser.

Others are talking about "broken top/ps" tools, but we aren't using 
these tools, but the "stats" command inside our gaming console.

In a quick find, we've not seen any "significant" change, nor nothing to 
really explain this change.

Please, can someone "revive" this "changelog" and answer us if this is 
really happening? Was really a real change in these params/code?!

Also, some specs also include extra packages and changes: the -ac9 
patch, ext3-2.4-0.9.9-249ac9 patch and param.h HZ base freq changes 
(200, 500, 700, 1000...).

Please CC me, as i'm not subscribed to list.

If one wants to view the full debat, archives exist at 
http://list.valvesoftware.com/mailman/private/hlds_linux/ (must 
subscribe before, sorry), September 2003, in thread "[hlds_linux] HOW TO 
GET SUPER LOW CPU USE!! THANK DLINKOZ"

Sorry about my poor english. Thanks in advance.

-- 
dual_bereta_r0x -- Alexandre Hautequest
ArenaNetwork Lan House & Cyber -- www.arenanetwork.com.br

