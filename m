Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264850AbUDWPlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264850AbUDWPlp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 11:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264846AbUDWPlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 11:41:45 -0400
Received: from kogut.o2.pl ([212.126.20.60]:48072 "EHLO kogut.o2.pl")
	by vger.kernel.org with ESMTP id S264850AbUDWPl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 11:41:27 -0400
Message-ID: <408939AC.6050804@o2.pl>
Date: Fri, 23 Apr 2004 17:43:40 +0200
From: Dariusz Tylus <dtdarek@o2.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040312 Debian/1.6-3
X-Accept-Language: en-us, en, pl
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Rtlinux - kernel panic on rtlinux init
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have already instaled rtLinyx 3.2 pre3 with kernel 2.4.22
When I type "rtlinux start" the system crash,
there is kernel panic
On the screen is dump of registers and some lines like this:

Attempt to kill the idle task
In idle task - not syncing.
...
Unable to handle kernel paging request at virtual adres 80731744

I would like some advice what should I do,
darek
