Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315417AbSGMUMY>; Sat, 13 Jul 2002 16:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315420AbSGMUMX>; Sat, 13 Jul 2002 16:12:23 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:29683 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S315417AbSGMUMX>; Sat, 13 Jul 2002 16:12:23 -0400
Message-ID: <3D308A30.7070702@wanadoo.fr>
Date: Sat, 13 Jul 2002 22:14:40 +0200
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a+) Gecko/20020704
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Greg KH <greg@kroah.com>
Subject: 2.5.25  uhci-hcd  very bad
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

usb inboard Abit BE6, ADSL modem Speedtouch usb.

I used to use satisfactorily usb-uhci-hcd before 2.5.25, switching to 
uhci-hcd halts the adsl modem after a few minutes with this message:

kernel: uhci-hcd.c: c000: host controller process error. something bad 
happened
kernel: uhci-hcd.c: c000: host controller halted. very bad

2.5.24 is not happy too with uhci-hcd.

What should I look at ?

Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

