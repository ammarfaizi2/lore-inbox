Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265742AbUFDLpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265742AbUFDLpV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 07:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265746AbUFDLpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 07:45:21 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:30374 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265742AbUFDLpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 07:45:17 -0400
Message-ID: <40C060C3.7020801@t-online.de>
Date: Fri, 04 Jun 2004 13:45:07 +0200
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.6 & prism54: Computer gets stuck pretty often
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: rxJVs-ZQrePnOEdzUehQUOIUokPg8VNOnAAkeUJr7Ubz1Rv4vntl84
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I am not sure how to reproduce this reliably, but using
the prism54 device my i386 machine gets stuck pretty often
(about 3 times a day). The mouse freezes, I cannot switch
to another vt, but Alt-SysRq-b works.

If I use an old 3c59x PCI card to connect to the net, then
there is no such problem.

Kernel is 2.6.6 (without any patches).

Is there any way I could help to find a fix?


Regards

Harri
