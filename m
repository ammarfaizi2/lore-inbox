Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270721AbTGNRDB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 13:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270717AbTGNRB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 13:01:27 -0400
Received: from hades.mk.cvut.cz ([147.32.96.3]:38790 "EHLO hades.mk.cvut.cz")
	by vger.kernel.org with ESMTP id S270712AbTGNRAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 13:00:52 -0400
Message-ID: <3F12E53A.7050802@kmlinux.fjfi.cvut.cz>
Date: Mon, 14 Jul 2003 19:15:38 +0200
From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0test1 - HPT374 kernel panic during booting
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am still having trouble with getting the HPT374 driver work on an EPoX 
8K9A3+ board with an integrated HPT374 controller. 2.6.0 ends with a 
kernel panic in hpt372_tune_chipset when the driver is compiled in the 
kernel, with hpt366 as a module the same error occurs, this time only 
with a segfault. 2.4.21 behaves the similar way - with a monolitic 
kernel it does a kernel panic, the module loads but doesn't find any 
disk. The driver from Highpoint website works fine.

Please cc: any replies, I am not a subscriber.

Regards,
-- 
Jindrich Makovicka

