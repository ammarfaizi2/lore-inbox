Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265227AbSKEVlV>; Tue, 5 Nov 2002 16:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265229AbSKEVlU>; Tue, 5 Nov 2002 16:41:20 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:16143 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S265227AbSKEVlU>; Tue, 5 Nov 2002 16:41:20 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB182C@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: Manish Lachwani <manish@Zambeel.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'linux@3ware.com'" <linux@3ware.com>,
       "'acme@conectiva.com'" <acme@conectiva.com>
Subject: RE: 0x40 errors reported by 3ware controllers ...
Date: Tue, 5 Nov 2002 13:47:44 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, I made a mistake here. I am making use of the latest driver with
the 2.2.16 kernel. Older drivers with version 1.02.00.018 also show the same
issues ...

Thanks
Manish

>  -----Original Message-----
> From: 	Manish Lachwani  
> Sent:	Tuesday, November 05, 2002 1:43 PM
> To:	'linux-kernel@vger.kernel.org'
> Cc:	Manish Lachwani
> Subject:	0x40 errors reported by 3ware controllers ...
> 
> Hello,
> We are making use of 3ware 7x50 controllers with Maxtor and Seagate
> drives. In one such setup, the operating temperature of the
> drives/controllers is between 45-55 C. Numerous 0x40 Error messages are
> reported by the 3ware firmware. We are making use of 7.5 latest firmware
> and the latest 3ware driver with the 2.4.17 kernel. 
> I spoke with Maxtor and Seagate support and they claim that ECC errors are
> rarely seen on their drives at even higher temperatures. Are there any
> issues with the 3ware controllers/firmware that may cause it to misreport
> ECC errors? Maxtor even claimed that it could be errors with the SRAM on
> the controller. Could that be possible? Has this been seen? I noticed that
> the operating temperature of the controllers is 40C. What kind of errors
> can occur because of these ambient conditions?
> We are seeing these errors accross different types of drives too ...
> Thanks
> 
