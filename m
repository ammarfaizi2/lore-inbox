Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265125AbSKEVgw>; Tue, 5 Nov 2002 16:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265126AbSKEVgw>; Tue, 5 Nov 2002 16:36:52 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:13071 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S265125AbSKEVgv>; Tue, 5 Nov 2002 16:36:51 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB182B@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: Manish Lachwani <manish@Zambeel.com>
Subject: 0x40 errors reported by 3ware controllers ...
Date: Tue, 5 Nov 2002 13:43:17 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
We are making use of 3ware 7x50 controllers with Maxtor and Seagate drives.
In one such setup, the operating temperature of the drives/controllers is
between 45-55 C. Numerous 0x40 Error messages are reported by the 3ware
firmware. We are making use of 7.5 latest firmware and the latest 3ware
driver with the 2.4.17 kernel. 
I spoke with Maxtor and Seagate support and they claim that ECC errors are
rarely seen on their drives at even higher temperatures. Are there any
issues with the 3ware controllers/firmware that may cause it to misreport
ECC errors? Maxtor even claimed that it could be errors with the SRAM on the
controller. Could that be possible? Has this been seen? I noticed that the
operating temperature of the controllers is 40C. What kind of errors can
occur because of these ambient conditions?
We are seeing these errors accross different types of drives too ...
Thanks

