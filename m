Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131807AbQLRKfC>; Mon, 18 Dec 2000 05:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131796AbQLRKez>; Mon, 18 Dec 2000 05:34:55 -0500
Received: from ns1.megapath.net ([216.200.176.4]:32521 "EHLO megapathdsl.net")
	by vger.kernel.org with ESMTP id <S130490AbQLRKeg>;
	Mon, 18 Dec 2000 05:34:36 -0500
Message-ID: <3A3DE1E6.3070005@megapathdsl.net>
Date: Mon, 18 Dec 2000 02:07:34 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12 i686; en-US; m18) Gecko/20001217
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test13-pre3:  unresolved symbols in dsbr100.o, ibmcam.o and ov511.o
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

depmod -ae -F System.map 2.4.0-test13-pre3
depmod: *** Unresolved symbols in /lib/modules/2.4.0-test13-pre3/kernel/drivers/usb/dsbr100.o
depmod: 	video_register_device
depmod: 	video_unregister_device
depmod: *** Unresolved symbols in /lib/modules/2.4.0-test13-pre3/kernel/drivers/usb/ibmcam.o
depmod: 	video_register_device
depmod: 	video_unregister_device
depmod: *** Unresolved symbols in /lib/modules/2.4.0-test13-pre3/kernel/drivers/usb/ov511.o
depmod: 	video_proc_entry
depmod: 	video_register_device
depmod: 	video_unregister_device

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
