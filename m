Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbUEFTJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbUEFTJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 15:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUEFTIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 15:08:20 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:52717 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S262337AbUEFTEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 15:04:35 -0400
Message-ID: <409A8C3F.5080005@bluewin.ch>
Date: Thu, 06 May 2004 21:04:31 +0200
From: Mario Vanoni <vanonim@bluewin.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 2.4.26: first crash 100%, NFS?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

8 machines running 2.4.26, >=19 days uptime.

P4HT3400, ASUS P4R800-V deluxe,
1GB memory, 1GB swap, 80GB IDE disk,
on-board 100Mb/s LAN.

- downloaded the last KNOPPIX...en
- 2 setitathome -nice 19 running

- mounted from another machine (UP P3-550)
- from P3-550 machine cp -a KNOPPIX...en
- after about 367MB of ~700MB ...
   P4HT3400 machine dead, message on console:

   Kernel panic: Aiee, killing interrupt handler!
   In interrupt handler -not syncing.

   Power switch ultima ratio, following fsck.

- the console on P3-550 was logged _out_.

No time for deeper researches, sorry,
kernel compiled -static with gcc-3.3.2,
no modules, without all lkml helps wanted.

_Feedback_ _only_ !!!

Kind regards

Mario, _not_ _in_ _lkml_.

